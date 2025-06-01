# listings/views.py

from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import HttpResponseForbidden

from django.db import connection
from django.db.models import Count, Q
from django.utils import timezone
from datetime import timedelta

from .forms import CustomUserCreationForm, ListingForm, OfferForm, BookSuggestionForm
from .models import Listing, Book, Offer, BookSuggestion, Course


def register(request):
    """
    User registration.
    """
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('listings:home')
    else:
        form = CustomUserCreationForm()
    return render(request, 'registration/register.html', {'form': form})


def home(request):
    """
    List “Available” (AVL) listings and apply
    optional GET filters: search (q), condition, course.
    """
    # 1) Read GET parameters
    query = request.GET.get('q', '').strip()
    condition_filter = request.GET.get('condition', '')
    course_filter = request.GET.get('course', '')

    # 2) Only “Available” listings
    available_listings = Listing.objects.filter(status='AVL').select_related('book', 'student')

    # 3) Search by title, author, ISBN
    if query:
        available_listings = available_listings.filter(
            Q(book__title__icontains=query) |
            Q(book__author__icontains=query) |
            Q(book__isbn__icontains=query)
        )

    # 4) Filter by condition if provided
    if condition_filter:
        available_listings = available_listings.filter(condition=condition_filter)

    # 5) Filter by course if provided
    if course_filter:
        available_listings = available_listings.filter(
            book__course_assignments__course__pk=course_filter
        )

    # 6) Pass all condition choices and all courses to the template
    all_conditions = Listing.CONDITION_CHOICES
    all_courses = Course.objects.order_by('course_code')

    context = {
        'listings': available_listings.distinct(),
        'query': query,
        'selected_condition': condition_filter,
        'selected_course': course_filter,
        'all_conditions': all_conditions,
        'all_courses': all_courses,
    }
    return render(request, 'listings/home.html', context)


@login_required
def create_listing(request):
    """
    Show “create new listing” form. Only logged-in users may access.
    """
    if request.method == 'POST':
        form = ListingForm(request.POST, request.FILES or None)
        if form.is_valid():
            listing = form.save(commit=False)
            listing.student = request.user
            listing.status = 'AVL'
            listing.save()
            messages.success(request, 'Your book listing has been created successfully!')
            return redirect('listings:home')
    else:
        form = ListingForm()

    return render(request, 'listings/create_listing.html', {
        'form': form,
        'page_title': 'List a New Book'
    })


def listing_detail(request, pk):
    """
    Show detail page for a single listing.
    """
    listing = get_object_or_404(
        Listing.objects.select_related('book', 'student'),
        pk=pk
    )
    return render(request, 'listings/listing_detail.html', {'listing': listing})


@login_required
def make_offer(request, pk):
    """
    A logged-in user makes an offer on a listing with status='AVL'.
    """
    listing = get_object_or_404(Listing, pk=pk, status='AVL')

    # The listing owner cannot make an offer on their own listing
    if request.user == listing.student:
        messages.error(request, "You cannot make an offer on your own listing.")
        return redirect('listings:listing_detail', pk=pk)

    # If the same user already offered, do not show the form again
    existing = Offer.objects.filter(listing=listing, buyer=request.user).first()
    if existing:
        messages.info(request, "You have already made an offer on this listing.")
        return redirect('listings:listing_detail', pk=pk)

    if request.method == 'POST':
        form = OfferForm(request.POST)
        if form.is_valid():
            offer = form.save(commit=False)
            offer.listing = listing
            offer.buyer = request.user
            offer.save()
            messages.success(request, "Your offer has been submitted.")
            return redirect('listings:listing_detail', pk=pk)
    else:
        form = OfferForm()

    return render(request, 'listings/make_offer.html', {
        'form': form,
        'listing': listing
    })


@login_required
def manage_offers(request, pk):
    """
    The listing owner sees all offers on their listing
    and can accept or reject each one.
    """
    listing = get_object_or_404(Listing, pk=pk, student=request.user)
    offers = listing.offers.select_related('buyer').all()

    if request.method == 'POST':
        action = request.POST.get('action')
        offer_id = request.POST.get('offer_id')
        offer = get_object_or_404(Offer, pk=offer_id, listing=listing)

        if action == 'accept':
            # Accept the offer
            offer.status = 'ACC'
            offer.save()
            # Mark the listing as “SOLD”
            listing.status = 'SOLD'
            listing.save()
            # Reject all other pending offers
            Offer.objects.filter(listing=listing).exclude(pk=offer.pk).update(status='REJ')
            messages.success(
                request,
                f"Accepted ${offer.offer_price} from {offer.buyer.username}. Listing marked as sold."
            )
        elif action == 'reject':
            # Reject the offer
            offer.status = 'REJ'
            offer.save()
            messages.info(request, f"Rejected ${offer.offer_price} from {offer.buyer.username}.")

        return redirect('listings:manage_offers', pk=pk)

    return render(request, 'listings/manage_offers.html', {
        'listing': listing,
        'offers': offers
    })


@login_required
def suggest_book(request):
    """
    Allow a logged-in user to suggest a new book.
    """
    if request.method == 'POST':
        form = BookSuggestionForm(request.POST)
        if form.is_valid():
            suggestion = form.save(commit=False)
            suggestion.suggested_by = request.user
            suggestion.save()
            messages.success(request, 'Thanks for suggesting a new book!')
            return redirect('listings:home')
    else:
        form = BookSuggestionForm()

    return render(request, 'listings/suggest_book.html', {
        'form': form
    })


@login_required
def my_listings(request):
    """
    Show all listings created by the currently logged-in user.
    """
    user_listings = Listing.objects.filter(student=request.user).select_related('book')
    return render(request, 'listings/my_listings.html', {
        'listings': user_listings
    })


@login_required
def edit_listing(request, pk):
    """
    Allow only the listing owner to edit their listing.
    """
    listing = get_object_or_404(Listing, pk=pk, student=request.user)
    if request.method == 'POST':
        form = ListingForm(request.POST, instance=listing)
        if form.is_valid():
            form.save()
            messages.success(request, 'Listing updated successfully!')
            return redirect('listings:my_listings')
    else:
        form = ListingForm(instance=listing)

    return render(request, 'listings/edit_listing.html', {
        'form': form,
        'listing': listing
    })


@login_required
def delete_listing(request, pk):
    """
    Show a confirmation page and delete the listing if the user posts the form.
    """
    listing = get_object_or_404(Listing, pk=pk, student=request.user)
    if request.method == 'POST':
        listing.delete()
        messages.success(request, 'Listing deleted successfully.')
        return redirect('listings:my_listings')

    return render(request, 'listings/delete_listing.html', {
        'listing': listing
    })


@login_required
def accept_offer(request, pk):
    """
    Accept the Offer with primary key=pk:
      - Set Offer.status to 'ACC'
      - Set the associated Listing.status to 'SOLD'
    """
    offer = get_object_or_404(Offer, pk=pk)
    listing = offer.listing

    # Only the listing owner can accept/reject
    if listing.student != request.user:
        return HttpResponseForbidden("You are not allowed to accept this offer.")

    # If already processed, do nothing
    if offer.status != 'PEN':
        messages.warning(request, 'This offer has already been processed.')
        return redirect('listings:manage_offers', pk=listing.pk)

    offer.status = 'ACC'
    offer.save()

    listing.status = 'SOLD'
    listing.save()

    # Optionally reject all other pending offers
    other_offers = listing.offers.filter(status='PEN').exclude(pk=offer.pk)
    for o in other_offers:
        o.status = 'REJ'
        o.save()

    messages.success(request, 'Offer accepted. The listing is now marked as SOLD.')
    return redirect('listings:manage_offers', pk=listing.pk)


@login_required
def reject_offer(request, pk):
    """
    Reject the Offer with primary key=pk by setting Offer.status to 'REJ'.
    """
    offer = get_object_or_404(Offer, pk=pk)
    listing = offer.listing

    if listing.student != request.user:
        return HttpResponseForbidden("You are not allowed to reject this offer.")

    if offer.status != 'PEN':
        messages.warning(request, 'This offer has already been processed.')
        return redirect('listings:manage_offers', pk=listing.pk)

    offer.status = 'REJ'
    offer.save()
    messages.success(request, 'Offer rejected.')
    return redirect('listings:manage_offers', pk=listing.pk)


def top_listing_raw(request):
    """
    Use raw SQL to fetch the single listing with the highest number of offers.
    """
    sql = """
        SELECT l.*, COUNT(o.id) AS num_offers
        FROM listings_listing AS l
        LEFT JOIN listings_offer AS o
          ON l.id = o.listing_id
        GROUP BY l.id
        ORDER BY num_offers DESC
        LIMIT 1;
    """
    top_listing_qs = Listing.objects.raw(sql)
    top = next(iter(top_listing_qs), None)

    return render(request, 'listings/top_listing.html', {
        'top_listing': top
    })


@login_required
def reports(request):
    """
    Only raw SQL:
      1) Find the listing with the most offers.
      2) Count how many listings each course has.
      3) Count how many listings were created in the last 7 days.
    """
    top_listing_raw = None
    courses_data_raw = []
    recent_count_raw = 0

    # 1) Top listing by number of offers
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT
                l.id AS listing_id,
                b.title AS book_title,
                COUNT(o.id) AS total_offers
            FROM listings_listing AS l
            JOIN listings_offer AS o
              ON l.id = o.listing_id
            JOIN listings_book AS b
              ON l.book_id = b.id
            GROUP BY l.id, b.title
            ORDER BY total_offers DESC
            LIMIT 1;
        """)
        row = cursor.fetchone()
    if row:
        top_listing_raw = {
            'listing_id': row[0],
            'book_title': row[1],
            'total_offers': row[2],
        }

    # 2) Listings per course
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT
                c.id AS course_id,
                c.course_code,
                c.course_name,
                COUNT(l.id) AS listing_count
            FROM listings_course AS c
            LEFT JOIN listings_bookcourseassignment AS bca
              ON c.id = bca.course_id
            LEFT JOIN listings_listing AS l
              ON l.book_id = bca.book_id
            GROUP BY c.id, c.course_code, c.course_name
            ORDER BY listing_count DESC;
        """)
        rows = cursor.fetchall()
    for course_id, course_code, course_name, listing_count in rows:
        courses_data_raw.append({
            'course_id': course_id,
            'course_code': course_code,
            'course_name': course_name,
            'listing_count': listing_count,
        })

    # 3) Listings created in last 7 days
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT
                COUNT(*) AS recent_count
            FROM listings_listing
            WHERE date_listed >= NOW() - INTERVAL 7 DAY;
        """)
        result = cursor.fetchone()
        recent_count_raw = result[0] if result else 0

    return render(request, 'listings/reports.html', {
        'top_listing_raw': top_listing_raw,
        'courses_data_raw': courses_data_raw,
        'recent_count_raw': recent_count_raw,
    })


def listings_per_course_raw(request):
    """
    Count how many listings each course has, using raw SQL.
    """
    data = []
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT c.id AS course_id,
                   c.course_code,
                   c.course_name,
                   COUNT(l.id) AS listing_count
            FROM listings_course AS c
            LEFT JOIN listings_bookcourseassignment AS bca
              ON c.id = bca.course_id
            LEFT JOIN listings_listing AS l
              ON l.book_id = bca.book_id
            GROUP BY c.id, c.course_code, c.course_name
            ORDER BY listing_count DESC;
        """)
        rows = cursor.fetchall()
    for course_id, course_code, course_name, listing_count in rows:
        data.append({
            'course_id': course_id,
            'course_code': course_code,
            'course_name': course_name,
            'listing_count': listing_count,
        })

    return render(request, 'listings/listings_per_course.html', {
        'courses_data': data
    })


def listings_by_condition_raw(request):
    """
    Raw SQL: filter listings by GET param “condition” (e.g. ?condition=NEW).
    """
    condition = request.GET.get('condition', '').strip().upper()
    if condition not in dict(Listing.CONDITION_CHOICES):
        condition = ''

    data = []
    with connection.cursor() as cursor:
        if condition:
            cursor.execute("""
                SELECT id, book_id, student_id, condition, price, status, date_listed, description
                FROM listings_listing
                WHERE condition = %s AND status = 'AVL'
            """, [condition])
        else:
            cursor.execute("""
                SELECT id, book_id, student_id, condition, price, status, date_listed, description
                FROM listings_listing
                WHERE status = 'AVL'
            """)
        rows = cursor.fetchall()

    for row in rows:
        data.append({
            'id': row[0],
            'book_id': row[1],
            'student_id': row[2],
            'condition': row[3],
            'price': row[4],
            'status': row[5],
            'date_listed': row[6],
            'description': row[7],
        })

    return render(request, 'listings/listings_by_condition.html', {
        'data': data,
        'selected_condition': condition,
    })


def top_listing_with_offers_count(request):
    """
    Raw SQL: fetch the single listing with the highest number of offers,
    including the “num_offers” field.
    """
    listing_obj = None
    num_offers = 0

    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT l.id, l.book_id, l.student_id, l.condition, l.price, l.status, l.date_listed, l.description,
                   COUNT(o.id) AS num_offers
            FROM listings_listing AS l
            LEFT JOIN listings_offer AS o
              ON l.id = o.listing_id
            GROUP BY l.id
            ORDER BY num_offers DESC
            LIMIT 1;
        """)
        row = cursor.fetchone()

    if row:
        # (id, book_id, student_id, condition, price, status, date_listed, description, num_offers)
        try:
            listing_obj = Listing.objects.get(pk=row[0])
            num_offers = row[8]
        except Listing.DoesNotExist:
            listing_obj = None

    return render(request, 'listings/top_listing_with_count.html', {
        'listing': listing_obj,
        'num_offers': num_offers,
    })

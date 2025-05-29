# listings/views.py

from django.shortcuts import render, redirect
from django.contrib.auth import login
# Import your custom form from forms.py
from .forms import CustomUserCreationForm
from .models import Listing 

def register(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save() # This now saves email, first_name, last_name too
            login(request, user) # Log the user in directly
            
            # Optional: Create a Profile for the user if you have a Profile model
            # from .models import Profile
            # if not hasattr(user, 'profile'): # Check if profile already exists (e.g. via signal)
            #    Profile.objects.create(user=user)

            return redirect('listings:home') # Redirect to the homepage
    else:
        form = CustomUserCreationForm()
    return render(request, 'registration/register.html', {'form': form})

def home(request):
    # THIS LINE DEFINES 'available_listings'
    available_listings = Listing.objects.filter(status='AVL').select_related('book', 'student')
    
    # NOW 'available_listings' CAN BE USED IN THE CONTEXT
    context = {
        'listings': available_listings
    }
    return render(request, 'listings/home.html', context)


# view for creating listings
@login_required # This decorator ensures only logged-in users can access this view
def create_listing(request):
    if request.method == 'POST':
        form = ListingForm(request.POST, request.FILES or None) # Add request.FILES for potential image uploads later
        if form.is_valid():
            listing = form.save(commit=False) # Don't save to DB immediately
            listing.student = request.user    # Set the student to the currently logged-in user
            listing.status = 'AVL'            # Set status to Available by default
            listing.save()                    # Now save to the database
            
            messages.success(request, 'Your book listing has been created successfully!')
            return redirect('listings:home') # Redirect to homepage (or a listing detail page later)
    else: # If GET request or form was invalid and re-rendered
        form = ListingForm()

    context = {
        'form': form,
        'page_title': 'List a New Book' # Optional title for the template
    }
    return render(request, 'listings/create_listing.html', context)
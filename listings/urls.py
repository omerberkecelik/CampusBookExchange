# listings/urls.py

from django.urls import path
from . import views

app_name = 'listings'

urlpatterns = [
    # 1) Home page (available listings)
    path('', views.home, name='home'),

    # 2) Registration
    path('register/', views.register, name='register'),

    # 3) Create new listing
    path('listings/new/', views.create_listing, name='create_listing'),

    # 4) Listing detail
    path('listings/<int:pk>/', views.listing_detail, name='listing_detail'),

    # 5) Make an offer (only on listings with status='AVL')
    path('listings/<int:pk>/offer/', views.make_offer, name='make_offer'),

    # 6) Manage offers (listing owner sees all incoming offers)
    path('listings/<int:pk>/offers/', views.manage_offers, name='manage_offers'),

    # 7) Suggest a new book
    path('suggest-book/', views.suggest_book, name='suggest_book'),

    # 8) “My Listings” – show current user’s listings
    path('my-listings/', views.my_listings, name='my_listings'),

    # 9) Edit listing
    path('listings/<int:pk>/edit/', views.edit_listing, name='edit_listing'),

    # 10) Delete listing
    path('listings/<int:pk>/delete/', views.delete_listing, name='delete_listing'),

    # Offer accept / reject
    path('offers/accept/<int:pk>/', views.accept_offer, name='accept_offer'),
    path('offers/reject/<int:pk>/', views.reject_offer, name='reject_offer'),

    # Raw-SQL report pages
    path('reports/', views.reports, name='reports'),
    path('listings-per-course/', views.listings_per_course_raw, name='listings_per_course_raw'),
    path('top-listing-count/', views.top_listing_with_offers_count, name='top_listing_with_offers_count'),
    path('top-listing/', views.top_listing_raw, name='top_listing_raw'),
]

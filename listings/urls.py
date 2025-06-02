# listings/urls.py

from django.urls import path
from . import views

app_name = 'listings'

urlpatterns = [

    path('', views.home, name='home'),


    path('register/', views.register, name='register'),


    path('listings/new/', views.create_listing, name='create_listing'),


    path('listings/<int:pk>/', views.listing_detail, name='listing_detail'),


    path('listings/<int:pk>/offer/', views.make_offer, name='make_offer'),


    path('listings/<int:pk>/offers/', views.manage_offers, name='manage_offers'),


    path('suggest-book/', views.suggest_book, name='suggest_book'),


    path('my-listings/', views.my_listings, name='my_listings'),


    path('listings/<int:pk>/edit/', views.edit_listing, name='edit_listing'),


    path('listings/<int:pk>/delete/', views.delete_listing, name='delete_listing'),


    path('offers/accept/<int:pk>/', views.accept_offer, name='accept_offer'),
    path('offers/reject/<int:pk>/', views.reject_offer, name='reject_offer'),


    path('reports/', views.reports, name='reports'),
    path('listings-per-course/', views.listings_per_course_raw, name='listings_per_course_raw'),
    path('top-listing-count/', views.top_listing_with_offers_count, name='top_listing_with_offers_count'),
    path('top-listing/', views.top_listing_raw, name='top_listing_raw'),
]

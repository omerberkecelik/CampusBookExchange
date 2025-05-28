# CampusBookExchange/book_exchange_project/urls.py
"""
URL configuration for book_exchange_project project.
"""
from django.contrib import admin
from django.urls import path, include # Make sure include is imported

urlpatterns = [
    path('admin/', admin.site.urls),
    path('accounts/', include('django.contrib.auth.urls')), # For built-in login, logout, password management
    path('', include('listings.urls')), # Includes all URLs from your 'listings' app (like home and register)
]
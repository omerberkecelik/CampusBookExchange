# CampusBookExchange/listings/urls.py

from django.urls import path
from . import views  # Imports views.py from the current app (listings)

app_name = 'listings'  # Defines an application namespace

urlpatterns = [
    # Maps the root path of this app (e.g., /) to the 'home' view
    path('', views.home, name='home'),

    # Maps the /register/ path within this app to the 'register' view
    path('register/', views.register, name='register'),

    # Add other listings-specific URLs here later
]
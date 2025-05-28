# listings/views.py

from django.shortcuts import render, redirect
from django.contrib.auth import login
# Import your custom form from forms.py
from .forms import CustomUserCreationForm

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
    # Later this will render a template with listings fetched from the database
    # For now, it just renders a static page.
    return render(request, 'listings/home.html')

# Add other views for your listings app here later, e.g.:
# def all_listings(request):
#     pass
# def listing_detail(request, listing_id):
#     pass
# def create_listing(request):
#     pass
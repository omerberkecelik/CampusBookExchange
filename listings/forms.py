# listings/forms.py

from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import Listing, Book, Offer, BookSuggestion

class CustomUserCreationForm(UserCreationForm):
    email = forms.EmailField(required=True, help_text='Required. Enter a valid email address.')
    first_name = forms.CharField(max_length=30, required=False, help_text='Optional.')
    last_name = forms.CharField(max_length=150, required=False, help_text='Optional.')

    class Meta(UserCreationForm.Meta):
        model = User
        fields = ('username', 'email', 'first_name', 'last_name') # Add fields in desired order

    def save(self, commit=True):
        user = super().save(commit=False)
        # Ensure email, first_name, and last_name are saved from cleaned_data
        user.email = self.cleaned_data["email"]
        user.first_name = self.cleaned_data["first_name"]
        user.last_name = self.cleaned_data["last_name"]
        if commit:
            user.save()
        return user
    

# form for creating listings
class ListingForm(forms.ModelForm):
    # We might want to allow users to add details for a new book
    # if it's not already in the database. For simplicity now,
    # we'll assume the Book must already exist.
    # Alternatively, you could add Book fields directly here.

    class Meta:
        model = Listing
        fields = ['book', 'condition', 'price', 'description'] # Fields user will fill
        # 'student' will be set automatically from the logged-in user in the view.
        # 'status' will default to 'Available' (AVL) as per model default.
        # 'date_listed' is auto_now_add.

        widgets = {
            'description': forms.Textarea(attrs={'rows': 4}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Optional: make 'book' field easier to use, e.g., by ordering
        self.fields['book'].queryset = Book.objects.order_by('title')
        # Optional: Add help text or placeholders
        self.fields['price'].help_text = "Leave blank if for trade only or price not set."


class OfferForm(forms.ModelForm):
    """
    Only 'offer_price' is needed because your Offer model has no 'message' field.
    """
    class Meta:
        model = Offer
        fields = ["offer_price"]
        widgets = {
            "offer_price": forms.NumberInput(attrs={"step": "0.01"}),
        }
        labels = {
            "offer_price": "Your Offer (USD)",
        }
        help_texts = {
            "offer_price": "Enter the amount you wish to offer for this book.",
        }


class BookSuggestionForm(forms.ModelForm):
    """
    Used when a user wants to suggest a new book that isn’t in the catalog.
    """
    class Meta:
        model = BookSuggestion
        fields = ["title", "author", "isbn"]
        labels = {
            "title": "Book Title",
            "author": "Author",
            "isbn": "ISBN",
        }
        help_texts = {
            "isbn": "13-character ISBN (e.g., 9781234567897)",
        }
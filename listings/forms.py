from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import Listing, Book, Offer, BookSuggestion
from typing import Any
class CustomUserCreationForm(UserCreationForm):
    email = forms.EmailField(required=True, help_text='Required. Enter a valid email address.')
    first_name = forms.CharField(max_length=30, required=False, help_text='Optional.')
    last_name = forms.CharField(max_length=150, required=False, help_text='Optional.')
    class Meta:
        model = User
        fields = ('username', 'email', 'first_name', 'last_name', 'password1', 'password2')
    def save(self, commit=True):
        user = super().save(commit=False)
        user.email = self.cleaned_data["email"]
        user.first_name = self.cleaned_data["first_name"]
        user.last_name = self.cleaned_data["last_name"]
        if commit:
            user.save()
        return user
class ListingForm(forms.ModelForm):
    class Meta:
        model = Listing
        fields = ['book', 'condition', 'price', 'description']
        widgets = {
            'description': forms.Textarea(attrs={'rows': 4}),
        }
    def __init__(self, *args: Any, **kwargs: Any) -> None:
        super().__init__(*args, **kwargs)
        book_field = self.fields.get('book')
        if book_field and hasattr(book_field, 'queryset'):
            setattr(book_field, 'queryset', Book.objects.order_by('title'))
        price_field = self.fields.get('price')
        if price_field and hasattr(price_field, 'help_text'):
            setattr(price_field, 'help_text', "Leave blank if for trade only or price not set.")
class OfferForm(forms.ModelForm):
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
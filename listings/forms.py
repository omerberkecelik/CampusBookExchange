# listings/forms.py

from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User

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
from django.contrib import admin
from .models import (
    Profile,
    Book,
    Course,
    Listing,
    BookCourseAssignment,
    Offer,
    BookSuggestion
)

admin.site.register(Profile)
admin.site.register(Book)
admin.site.register(Course)
admin.site.register(BookCourseAssignment)

admin.site.register(Offer)
admin.site.register(BookSuggestion)

class ListingAdmin(admin.ModelAdmin):
    list_display = ('book', 'student', 'price', 'status', 'date_listed')
    list_filter = ('status', 'condition', 'date_listed')
    search_fields = ('book__title', 'student__username', 'description')

admin.site.register(Listing, ListingAdmin)
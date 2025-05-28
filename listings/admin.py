# listings/admin.py
from django.contrib import admin
from .models import Profile, Book, Course, Listing, BookCourseAssignment # Import all your models

# Simple registration (more customization is possible)
admin.site.register(Profile)
admin.site.register(Book)
admin.site.register(Course)
admin.site.register(Listing)
admin.site.register(BookCourseAssignment)

# You can also customize how models appear in the admin.
# For example, to show more details for the Listing model:
# class ListingAdmin(admin.ModelAdmin):
#     list_display = ('book', 'student', 'price', 'status', 'date_listed')
#     list_filter = ('status', 'condition', 'date_listed')
#     search_fields = ('book__title', 'student__username', 'description')

# admin.site.register(Listing, ListingAdmin) # Register Listing with custom options
# For now, the simple registration above is fine.
# listings/models.py

from django.db import models
from django.contrib.auth.models import User # Django's built-in User model
from django.utils import timezone # For default dates/times if needed

# 1. Profile Model (to extend the built-in User model for student-specific info)
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE) # Links to Django's User model
    major = models.CharField(max_length=100, blank=True, null=True)
    # RegistrationDate is automatically handled by User.date_joined

    def __str__(self):
        return f"{self.user.username}'s Profile"

# You might want to create a profile automatically when a user is created.
# This can be done using signals (more advanced) or by overriding User's save method
# or by handling it in your registration view. For now, we'll just define the model.

# 2. Book Model
class Book(models.Model):
    isbn = models.CharField(max_length=13, unique=True, help_text="13 Character ISBN")
    title = models.CharField(max_length=255)
    author = models.CharField(max_length=255)
    edition = models.CharField(max_length=50, blank=True, null=True)
    publisher = models.CharField(max_length=100, blank=True, null=True)
    publication_year = models.PositiveIntegerField(blank=True, null=True, help_text="Year of publication")

    def __str__(self):
        return f"{self.title} (ISBN: {self.isbn})"

# 3. Course Model
class Course(models.Model):
    course_code = models.CharField(max_length=20, unique=True, help_text="e.g., COMP306")
    course_name = models.CharField(max_length=150)
    department = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
        return f"{self.course_code} - {self.course_name}"

# 4. Listing Model
class Listing(models.Model):
    CONDITION_CHOICES = [
        ('NEW', 'New'),
        ('LN', 'Like New'),
        ('GOOD', 'Good'),
        ('FAIR', 'Fair'),
        ('ACC', 'Acceptable'),
    ]
    STATUS_CHOICES = [
        ('AVL', 'Available'),
        ('PEN', 'Pending Trade/Sale'),
        ('SOLD', 'Sold'),
        ('TRD', 'Traded'),
        ('REM', 'Removed'),
    ]

    # Student who listed the book (links to the built-in User model)
    student = models.ForeignKey(User, on_delete=models.CASCADE, related_name="listings")
    book = models.ForeignKey(Book, on_delete=models.RESTRICT, related_name="listings")
    condition = models.CharField(max_length=4, choices=CONDITION_CHOICES)
    price = models.DecimalField(max_digits=6, decimal_places=2, null=True, blank=True, help_text="Leave blank if for trade only or price not set.")
    status = models.CharField(max_length=4, choices=STATUS_CHOICES, default='AVL')
    date_listed = models.DateTimeField(auto_now_add=True) # Automatically set when object is first created
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"Listing for '{self.book.title}' by {self.student.username} ({self.get_status_display()})"

    class Meta:
        ordering = ['-date_listed'] # Default ordering for listings

# 5. BookCourseAssignment Model (for the Many-to-Many relationship between Book and Course)
class BookCourseAssignment(models.Model):
    book = models.ForeignKey(Book, on_delete=models.CASCADE, related_name="course_assignments")
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name="book_assignments")
    is_required = models.BooleanField(default=True, help_text="Is this book required or just recommended for the course?")

    def __str__(self):
        return f"'{self.book.title}' for '{self.course.course_code}' (Required: {self.is_required})"

    class Meta:
        unique_together = ('book', 'course') # Ensures a book isn't assigned to the same course multiple times
        verbose_name = "Book-Course Assignment"
        verbose_name_plural = "Book-Course Assignments"
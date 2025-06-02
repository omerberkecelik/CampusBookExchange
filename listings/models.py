# listings/models.py

from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

# 1. Profile Model (extends User with student-specific info)
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    major = models.CharField(max_length=100, blank=True, null=True)
    

    def __str__(self):
        return f"{self.user.username}'s Profile"


# 2. Book Model
class Book(models.Model):
    isbn = models.CharField(
        max_length=13,
        unique=True,
        help_text="13 Character ISBN"
    )
    title = models.CharField(max_length=255)
    author = models.CharField(max_length=255)
    edition = models.CharField(max_length=50, blank=True, null=True)
    publisher = models.CharField(max_length=100, blank=True, null=True)
    publication_year = models.PositiveIntegerField(
        blank=True,
        null=True,
        help_text="Year of publication"
    )

    def __str__(self):
        return f"{self.title} (ISBN: {self.isbn})"


# 3. Course Model
class Course(models.Model):
    course_code = models.CharField(
        max_length=20,
        unique=True,
        help_text="e.g., COMP306"
    )
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

    student = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name="listings"
    )
    book = models.ForeignKey(
        Book,
        on_delete=models.RESTRICT,
        related_name="listings"
    )
    condition = models.CharField(max_length=4, choices=CONDITION_CHOICES)
    price = models.DecimalField(
        max_digits=6,
        decimal_places=2,
        null=True,
        blank=True,
        help_text="Leave blank if for trade only."
    )
    status = models.CharField(
        max_length=4,
        choices=STATUS_CHOICES,
        default='AVL'
    )
    date_listed = models.DateTimeField(auto_now_add=True)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"Listing for '{self.book.title}' by {self.student.username} ({self.get_status_display()})"

    class Meta:
        ordering = ['-date_listed']


# 5. BookCourseAssignment Model
class BookCourseAssignment(models.Model):
    book = models.ForeignKey(
        Book,
        on_delete=models.CASCADE,
        related_name="course_assignments"
    )
    course = models.ForeignKey(
        Course,
        on_delete=models.CASCADE,
        related_name="book_assignments"
    )
    is_required = models.BooleanField(
        default=True,
        help_text="Is this book required or recommended for the course?"
    )

    def __str__(self):
        return f"'{self.book.title}' for '{self.course.course_code}' (Required: {self.is_required})"

    class Meta:
        unique_together = ('book', 'course')
        verbose_name = "Book-Course Assignment"
        verbose_name_plural = "Book-Course Assignments"


# 6. Offer Model (users can make offers on Listings)
class Offer(models.Model):
    listing = models.ForeignKey(
        Listing,
        on_delete=models.CASCADE,
        related_name='offers'
    )
    buyer = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='offers_made'
    )
    offer_price = models.DecimalField(max_digits=8, decimal_places=2)
    STATUS_CHOICES = [
        ('PEN', 'Pending'),
        ('ACC', 'Accepted'),
        ('REJ', 'Rejected'),
    ]
    status = models.CharField(max_length=3, choices=STATUS_CHOICES, default='PEN')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.buyer.username} offers ${self.offer_price} on {self.listing.book.title}"


# 7. BookSuggestion Model (students can suggest new books)
class BookSuggestion(models.Model):
    title = models.CharField(max_length=255)
    author = models.CharField(max_length=255, blank=True, null=True)
    isbn = models.CharField(max_length=13, blank=True, null=True)
    suggested_by = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='book_suggestions'
    )
    timestamp = models.DateTimeField(auto_now_add=True)
    is_approved = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.title} suggested by {self.suggested_by.username}"

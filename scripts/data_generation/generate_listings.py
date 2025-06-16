import os
import sys
import django
import random
from decimal import Decimal
sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'book_exchange_project.settings')
django.setup()
from listings.models import Book, Listing, User
from django.contrib.auth.models import User
def create_listings_for_new_books():
    """Create listings for books that don't have any listings yet"""
    books_without_listings = Book.objects.filter(listings__isnull=True)
    users = list(User.objects.filter(is_superuser=False))
    if not users:
        print("No regular users found. Please create some users first.")
        return
    condition_choices = ['NEW', 'LN', 'GOOD', 'FAIR', 'ACC']
    status_choices = ['AVL']
    created_count = 0
    for book in books_without_listings:
        num_listings = random.randint(1, 3)
        if num_listings > len(users):
            num_listings = len(users)
        selected_users = random.sample(users, num_listings)
        for user in selected_users:
            condition = random.choice(condition_choices)
            base_price = random.uniform(20, 200)
            condition_multipliers = {
                'NEW': 1.0,
                'LN': 0.85,
                'GOOD': 0.70,
                'FAIR': 0.55,
                'ACC': 0.40
            }
            price = base_price * condition_multipliers[condition]
            price = round(price, 2)
            if random.random() < 0.15:
                price = None
            descriptions = [
                f"Great {condition.lower()} condition textbook for {book.title}. Used for one semester.",
                f"Selling my copy of {book.title}. {condition.lower()} condition, no major damage.",
                f"{book.title} in {condition.lower()} condition. All pages intact.",
                f"Used {book.title} textbook. Condition: {condition.lower()}. Great for studying!",
                f"No longer need this {book.title} book. {condition.lower()} condition.",
                "",
            ]
            description = random.choice(descriptions)
            try:
                listing = Listing.objects.create(
                    student=user,
                    book=book,
                    condition=condition,
                    price=price,
                    status='AVL',
                    description=description
                )
                created_count += 1
                price_str = f"${price}" if price else "Trade only"
                print(f"Created listing: {book.title} by {user.username} - {condition} - {price_str}")
            except Exception as e:
                print(f"Error creating listing for {book.title}: {e}")
    print(f"\nTotal listings created: {created_count}")
    print(f"Total listings in database: {Listing.objects.count()}")
    print(f"Books with listings: {Book.objects.filter(listings__isnull=False).distinct().count()}")
    print(f"Books without listings: {Book.objects.filter(listings__isnull=True).count()}")
if __name__ == "__main__":
    create_listings_for_new_books()
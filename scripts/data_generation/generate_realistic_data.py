#!/usr/bin/env python3
"""
Generate realistic data for Campus Book Exchange using Faker
"""

import os
import sys
import django
from faker import Faker
import random
from django.utils import timezone

# Add the project root to Python path
sys.path.append('/Users/oykuaslan/Desktop/CampusBookExchange')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'book_exchange_project.settings')
django.setup()

from django.contrib.auth.models import User
from django.contrib.auth.hashers import make_password
from listings.models import Profile, Book, Course, BookCourseAssignment, Listing, Offer, BookSuggestion

# Initialize Faker
fake = Faker()
Faker.seed(12345)  # For reproducible results

# Academic majors for realistic profiles
MAJORS = [
    'Computer Science', 'Mathematics', 'Literature', 'Engineering', 'Biology',
    'Chemistry', 'Physics', 'Psychology', 'Business Administration', 
    'Economics', 'Political Science', 'History', 'Philosophy', 'Art',
    'Music', 'Theater', 'Journalism', 'Communications', 'Education',
    'Nursing', 'Pre-Med', 'Pre-Law', 'Environmental Science', 'Geology'
]

# Realistic book conditions and descriptions
BOOK_CONDITIONS = ['NEW', 'LN', 'GOOD', 'FAIR', 'ACC']

CONDITION_DESCRIPTIONS = {
    'NEW': [
        'Brand new, never opened',
        'Still in original packaging',
        'Perfect condition, unused',
        'Factory sealed copy'
    ],
    'LN': [
        'Like new condition, barely used',
        'Used only once for reference',
        'Excellent condition, no marks',
        'Nearly perfect, minimal wear'
    ],
    'GOOD': [
        'Good condition with minor highlighting',
        'Some notes in margins but readable',
        'Light wear on cover, pages intact',
        'Well-maintained copy',
        'Minor shelf wear only'
    ],
    'FAIR': [
        'Fair condition with highlighting and notes',
        'Some page corners bent but all pages present',
        'Cover shows wear, content fully readable',
        'Previous owner made notes throughout',
        'Used but functional condition'
    ],
    'ACC': [
        'Acceptable condition, heavy highlighting',
        'Well-used with extensive notes',
        'Some page damage but readable',
        'Heavily annotated by previous student',
        'Functional despite wear'
    ]
}

def clear_existing_data():
    """Clear existing generated data (keep books and courses)"""
    print("Clearing existing user-generated data...")
    Offer.objects.all().delete()
    Listing.objects.all().delete()
    BookSuggestion.objects.all().delete()
    # Keep users 1-5 (admin and test users), remove the rest
    User.objects.filter(id__gt=5).delete()
    Profile.objects.filter(user_id__gt=5).delete()
    print("Existing data cleared.")

def generate_realistic_users(count=50):
    """Generate realistic student users with profiles"""
    print(f"Generating {count} realistic users...")
    
    users_created = []
    
    for i in range(count):
        # Generate realistic user data
        first_name = fake.first_name()
        last_name = fake.last_name()
        username = f"{first_name.lower()}.{last_name.lower()}{random.randint(1, 999)}"
        email = f"{username}@university.edu"
        
        # Create user
        user = User.objects.create(
            username=username,
            email=email,
            first_name=first_name,
            last_name=last_name,
            password=make_password('password123'),  # Default password
            date_joined=timezone.make_aware(fake.date_time_between(start_date='-2y', end_date='now'))
        )
        
        # Create profile with realistic major
        profile = Profile.objects.create(
            user=user,
            major=random.choice(MAJORS)
        )
        
        users_created.append(user)
        
        if (i + 1) % 10 == 0:
            print(f"Created {i + 1} users...")
    
    print(f"Successfully created {len(users_created)} realistic users.")
    return users_created

def generate_realistic_listings(users, count=200):
    """Generate realistic book listings with faker descriptions"""
    print(f"Generating {count} realistic listings...")
    
    # Get all books
    books = list(Book.objects.all())
    if not books:
        print("No books found! Please populate books first.")
        return []
    
    listings_created = []
    
    for i in range(count):
        # Select random user and book
        user = random.choice(users)
        book = random.choice(books)
        
        # Skip if user already has a listing for this book
        if Listing.objects.filter(student=user, book=book).exists():
            continue
        
        # Generate realistic listing data
        condition = random.choice(BOOK_CONDITIONS)
        
        # Generate price based on condition and randomness
        base_prices = {'NEW': (80, 120), 'LN': (60, 100), 'GOOD': (40, 80), 'FAIR': (20, 60), 'ACC': (10, 40)}
        min_price, max_price = base_prices[condition]
        
        # 20% chance of trade-only listing
        if random.random() < 0.2:
            price = None
        else:
            price = round(random.uniform(min_price, max_price), 2)
        
        # Generate realistic description
        description_templates = [
            f"{random.choice(CONDITION_DESCRIPTIONS[condition])}. {fake.sentence()}",
            f"Used for {random.choice(['one semester', 'two semesters', 'a few classes'])}. {random.choice(CONDITION_DESCRIPTIONS[condition])}.",
            f"{random.choice(CONDITION_DESCRIPTIONS[condition])}. {fake.sentence()} Perfect for {random.choice(['studying', 'coursework', 'reference'])}.",
            f"Selling because I {random.choice(['graduated', 'changed majors', 'finished the course', 'no longer need it'])}. {random.choice(CONDITION_DESCRIPTIONS[condition])}."
        ]
        
        description = random.choice(description_templates)
        
        # Random date within last 6 months
        date_listed = timezone.make_aware(fake.date_time_between(start_date='-6M', end_date='now'))
        
        # Create listing
        listing = Listing.objects.create(
            student=user,
            book=book,
            condition=condition,
            price=price,
            status='AVL',
            date_listed=date_listed,
            description=description
        )
        
        listings_created.append(listing)
        
        if (i + 1) % 25 == 0:
            print(f"Created {len(listings_created)} listings...")
    
    print(f"Successfully created {len(listings_created)} realistic listings.")
    return listings_created

def generate_realistic_offers(listings, users, count=100):
    """Generate realistic offers on listings"""
    print(f"Generating {count} realistic offers...")
    
    offers_created = []
    
    for i in range(count):
        # Select random listing and buyer
        listing = random.choice(listings)
        buyer = random.choice(users)
        
        # Skip if buyer is the seller or already made an offer
        if buyer == listing.student or Offer.objects.filter(listing=listing, buyer=buyer).exists():
            continue
        
        # Skip trade-only listings sometimes
        if not listing.price and random.random() < 0.7:
            continue
        
        # Generate realistic offer price
        if listing.price:
            # Offer 70-95% of asking price
            offer_percentage = random.uniform(0.70, 0.95)
            offer_price = round(listing.price * offer_percentage, 2)
        else:
            # For trade-only, offer a reasonable amount
            offer_price = round(random.uniform(15, 60), 2)
        
        # Random status
        status_weights = [('PEN', 0.6), ('ACC', 0.2), ('REJ', 0.2)]
        status = random.choices([s[0] for s in status_weights], [s[1] for s in status_weights])[0]
        
        # Random creation time
        created_at = timezone.make_aware(fake.date_time_between(start_date=listing.date_listed.replace(tzinfo=None), end_date='now'))
        
        # Create offer
        offer = Offer.objects.create(
            listing=listing,
            buyer=buyer,
            offer_price=offer_price,
            status=status,
            created_at=created_at
        )
        
        offers_created.append(offer)
        
        if (i + 1) % 20 == 0:
            print(f"Created {len(offers_created)} offers...")
    
    print(f"Successfully created {len(offers_created)} realistic offers.")
    return offers_created

def generate_book_suggestions(users, count=30):
    """Generate realistic book suggestions"""
    print(f"Generating {count} book suggestions...")
    
    # Common textbook subjects and titles
    suggestion_templates = [
        ("Advanced {subject}", "{author}"),
        ("Introduction to {subject}", "{author}"),
        ("{subject}: Theory and Practice", "{author}"),
        ("Modern {subject}", "{author}"),
        ("{subject} Fundamentals", "{author}"),
        ("Essential {subject}", "{author}"),
        ("{subject}: A Comprehensive Guide", "{author}"),
    ]
    
    subjects = [
        "Machine Learning", "Data Science", "Artificial Intelligence", "Web Development",
        "Mobile Programming", "Cybersecurity", "Cloud Computing", "DevOps",
        "Linear Algebra", "Calculus", "Statistics", "Discrete Math",
        "American Literature", "World Literature", "Creative Writing", "Poetry",
        "Biology", "Chemistry", "Physics", "Environmental Science"
    ]
    
    suggestions_created = []
    
    for i in range(count):
        user = random.choice(users)
        subject = random.choice(subjects)
        title_template, author_template = random.choice(suggestion_templates)
        
        title = title_template.format(subject=subject)
        author = fake.name()
        isbn = fake.isbn13()[:13]  # Ensure ISBN is max 13 characters
        
        suggestion = BookSuggestion.objects.create(
            title=title,
            author=author,
            isbn=isbn,
            suggested_by=user,
            timestamp=timezone.make_aware(fake.date_time_between(start_date='-3M', end_date='now')),
            is_approved=random.choice([True, False])
        )
        
        suggestions_created.append(suggestion)
        
        if (i + 1) % 10 == 0:
            print(f"Created {i + 1} suggestions...")
    
    print(f"Successfully created {len(suggestions_created)} book suggestions.")
    return suggestions_created

def main():
    """Main function to generate all realistic data"""
    print("🎭 Generating realistic data using Faker...")
    print("=" * 50)
    
    # Clear existing data
    clear_existing_data()
    
    # Generate users
    users = generate_realistic_users(50)
    
    # Generate listings
    listings = generate_realistic_listings(users, 200)
    
    # Generate offers
    offers = generate_realistic_offers(listings, users, 100)
    
    # Generate book suggestions
    suggestions = generate_book_suggestions(users, 30)
    
    print("\n" + "=" * 50)
    print("✅ Realistic data generation complete!")
    print(f"📊 Summary:")
    print(f"   👥 Users: {len(users)}")
    print(f"   📚 Listings: {len(listings)}")
    print(f"   💰 Offers: {len(offers)}")
    print(f"   💡 Suggestions: {len(suggestions)}")
    print("\n🎯 Your Campus Book Exchange now has realistic data!")

if __name__ == "__main__":
    main()
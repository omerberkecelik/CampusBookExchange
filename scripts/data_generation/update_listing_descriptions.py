#!/usr/bin/env python3
"""
Update existing listings with realistic descriptions using Faker
"""

import os
import sys
import django
from faker import Faker
import random

# Add the project root to Python path
sys.path.append('/Users/oykuaslan/Desktop/CampusBookExchange')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'book_exchange_project.settings')
django.setup()

from listings.models import Listing

# Initialize Faker
fake = Faker()
Faker.seed(12345)

def generate_realistic_descriptions():
    """Update existing listings with realistic descriptions"""
    print("Updating existing listings with realistic descriptions...")
    
    # Realistic description templates by condition
    description_templates = {
        'NEW': [
            "Brand new textbook, never opened. Still in original packaging.",
            "Perfect condition - bought but never used due to course change.",
            "Unopened copy, decided to go digital instead.",
            "Brand new condition, purchased but course was cancelled.",
            "Factory sealed, extra copy I don't need."
        ],
        'LN': [
            "Like new condition, only used for one semester.",
            "Excellent condition with no highlighting or writing.",
            "Barely used, kept in pristine condition.",
            "Used only for reference a few times, looks brand new.",
            "Nearly perfect condition, very light use only."
        ],
        'GOOD': [
            "Good condition with some light highlighting in key chapters.",
            "Well-maintained copy with minimal wear and tear.",
            "Some notes in margins but overall very clean.",
            "Good condition, normal wear from one semester of use.",
            "Clean copy with just a few highlighted passages.",
            "Solid condition, helped me get an A in the class!"
        ],
        'FAIR': [
            "Fair condition with highlighting throughout most chapters.",
            "Noticeable wear but all pages intact and readable.",
            "Previous owner made extensive notes, great for studying.",
            "Shows use but perfect for someone who needs the content.",
            "Well-studied copy with lots of helpful annotations.",
            "Some cover wear but interior is completely functional."
        ],
        'ACC': [
            "Acceptable condition with heavy highlighting and notes.",
            "Well-used but all content is perfectly readable.",
            "Lots of previous student notes which might be helpful.",
            "Shows significant wear but great for budget-conscious students.",
            "Heavy use visible but perfect for getting the information you need.",
            "Extensively annotated - previous student clearly studied hard!"
        ]
    }
    
    # Additional context phrases
    context_phrases = [
        "Selling because I graduated.",
        "Changed majors, no longer need this.",
        "Course requirement changed, selling this edition.",
        "Moving and need to downsize my collection.",
        "Finished the course series, passing it on.",
        "Got the newer edition, selling this one.",
        "Need money for next semester's books.",
        "Great textbook that really helped me understand the material.",
        "Professor recommended this edition specifically.",
        "Used this throughout the entire course sequence."
    ]
    
    # Specific subject-related phrases
    subject_phrases = {
        'Computer Science': [
            "Great for learning programming fundamentals.",
            "Excellent code examples and exercises.",
            "Perfect for CS majors and coding bootcamps.",
            "Helped me ace my programming assignments."
        ],
        'Mathematics': [
            "Clear explanations of complex mathematical concepts.",
            "Excellent problem sets for practice.",
            "Great for both theoretical understanding and practical applications.",
            "Step-by-step solutions really helped my learning."
        ],
        'Literature': [
            "Comprehensive analysis and great critical essays.",
            "Perfect for literature majors and English courses.",
            "Excellent commentary and historical context.",
            "Great for understanding literary movements and themes."
        ]
    }
    
    # Get all listings
    listings = Listing.objects.all()
    updated_count = 0
    
    for listing in listings:
        # Skip if already has a good description
        if listing.description and len(listing.description) > 50:
            continue
        
        # Get the book's associated courses to determine subject
        course_assignments = listing.book.course_assignments.all()
        first_assignment = course_assignments.first()
        subject_context = ""
        
        if first_assignment is not None:
            first_course = first_assignment.course
            if 'COMP' in first_course.course_code:
                subject_context = random.choice(subject_phrases['Computer Science'])
            elif 'MATH' in first_course.course_code:
                subject_context = random.choice(subject_phrases['Mathematics'])
            elif 'LIT' in first_course.course_code:
                subject_context = random.choice(subject_phrases['Literature'])
        
        # Build realistic description
        condition_desc = random.choice(description_templates.get(listing.condition, description_templates['GOOD']))
        context = random.choice(context_phrases)
        
        # Combine elements
        if subject_context and random.random() < 0.4:  # 40% chance to include subject context
            description = f"{condition_desc} {subject_context} {context}"
        else:
            description = f"{condition_desc} {context}"
        
        # Add price-related context for some listings
        if listing.price and random.random() < 0.3:  # 30% chance
            price_phrases = [
                f"Asking ${listing.price} (paid ${listing.price + random.randint(20, 60)} new).",
                f"Fair price at ${listing.price} for this condition.",
                f"Priced to sell quickly at ${listing.price}."
            ]
            description += " " + random.choice(price_phrases)
        elif not listing.price and random.random() < 0.5:  # 50% chance for trade-only
            trade_phrases = [
                "Open to trades for other textbooks!",
                "Looking to trade for books I need next semester.",
                "Prefer trade but will consider reasonable offers.",
                "Trade preferred, but open to cash offers too."
            ]
            description += " " + random.choice(trade_phrases)
        
        # Update the listing
        listing.description = description
        listing.save()
        updated_count += 1
        
        if updated_count % 20 == 0:
            print(f"Updated {updated_count} listings...")
    
    print(f" Successfully updated {updated_count} listings with realistic descriptions.")

if __name__ == "__main__":
    generate_realistic_descriptions()
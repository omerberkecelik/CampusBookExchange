#!/usr/bin/env python3
"""
Quick script to regenerate realistic data
"""

import os
import sys

# Add the project root to Python path
sys.path.append('/Users/oykuaslan/Desktop/CampusBookExchange')

def main():
    print(" Quick Data Regeneration")
    print("=" * 30)
    
    choice = input("What would you like to do?\n"
                  "1. Generate new users and listings (recommended)\n"
                  "2. Update existing listing descriptions only\n"
                  "3. Full regeneration (clear all and start fresh)\n"
                  "Enter choice (1-3): ")
    
    if choice == "1":
        print("\n Generating new users and listings...")
        from generate_realistic_data import generate_realistic_users, generate_realistic_listings, generate_realistic_offers
        import django
        os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'book_exchange_project.settings')
        django.setup()
        
        users = generate_realistic_users(25)
        listings = generate_realistic_listings(users, 100)
        offers = generate_realistic_offers(listings, users, 50)
        
        print(f" Added {len(users)} users, {len(listings)} listings, {len(offers)} offers")
        
    elif choice == "2":
        print("\n📝 Updating listing descriptions...")
        from update_listing_descriptions import generate_realistic_descriptions
        import django
        os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'book_exchange_project.settings')
        django.setup()
        
        generate_realistic_descriptions()
        
    elif choice == "3":
        print("\n Full regeneration...")
        from generate_realistic_data import main as full_regen
        full_regen()
        
    else:
        print("Invalid choice")
        
    print("\n🎯 Data regeneration complete!")

if __name__ == "__main__":
    main()
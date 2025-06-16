# Scripts Directory

This directory contains utility scripts and data files for the Campus Book Exchange project.

## Directory Structure

### `/data_generation/`
Contains Python scripts for generating and importing data:
- `generate_books.py` - Generates sample books and course assignments
- `generate_listings.py` - Creates sample listings for books
- `import_users.py` - Imports users from CSV data
- `import_data.py` - General data import utilities

### `/sql/`
Contains SQL scripts for database operations:
- `create_database.sql` - Database creation script
- `populate_data.sql` - Data population script
- `advanced_queries.sql` - Complex queries for reports

### `/data/`
Contains data files:
- `people-10000.csv` - Sample user data for import

## Usage

### Running Data Generation Scripts
All scripts should be run from the project root directory:

```bash
# Generate sample books
python scripts/data_generation/generate_books.py

# Generate sample listings
python scripts/data_generation/generate_listings.py

# Import users from CSV
python scripts/data_generation/import_users.py
```

### SQL Scripts
SQL scripts can be run directly in your database management tool or via Django's database shell.

## Notes
- All Python scripts are configured to work with Django and will automatically set up the Django environment
- Scripts assume they are run from the project root directory
- Make sure your virtual environment is activated before running scripts
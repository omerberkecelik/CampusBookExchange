import csv
from django.utils.timezone import now
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User

def import_users_from_csv(csv_path, limit=1000):
    with open(csv_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        for i, row in enumerate(reader):
            if i >= limit:
                break

            email = row['Email']
            username = email.split('@')[0]  
            first_name = row['First Name']
            last_name = row['Last Name']
            password = make_password('defaultpass123')  

            if not User.objects.filter(username=username).exists():
                User.objects.create(
                    username=username,
                    first_name=first_name,
                    last_name=last_name,
                    email=email,
                    password=password,
                    is_active=True,
                    is_staff=False,
                    is_superuser=False,
                    date_joined=now()
                )

# import_users.py

import csv
from django.utils import timezone
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User

def import_users_from_csv(csv_path, limit=1000):
    default_hash = make_password('DefaultpaSSword123')

    with open(csv_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        for i, row in enumerate(reader):
            if i >= limit:
                break

            try:
                username = (row['First Name'] + row['Last Name']).lower() + str(i)
                first_name = row['First Name']
                last_name = row['Last Name']
                email = row['Email']

                if not User.objects.filter(username=username).exists():
                    User.objects.create(
                        username=username,
                        first_name=first_name,
                        last_name=last_name,
                        email=email,
                        password=default_hash,
                        is_active=True,
                        is_superuser=False,
                        is_staff=False,
                        date_joined=timezone.now(),
                        last_login=None
                    )
                    print(f"User {username} created.")
            except Exception as e:
                print(f"Error on row {i}: {e}")

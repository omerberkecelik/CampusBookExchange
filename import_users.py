

import csv
from django.utils import timezone
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User

def import_users_from_csv(csv_path, limit=1000):
    """
    CSV format (örnek: scripts/people-10000.csv):
      Index,User Id,First Name,Last Name,Sex,Email,Phone,Date of birth,Job Title
    Bu fonksiyon, CSV içindeki her satırı okuyup Django User modeline ekler.
    `limit` parametresi, kaç satır okunduğunu sınırlar.
    """


    default_hash = make_password('DefaultpaSSword123')

    with open(csv_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)

        count = 0
        for i, row in enumerate(reader):
            if count >= limit:
                break

            try:
                
                first_name = row.get('First Name', '').strip()
                last_name = row.get('Last Name', '').strip()
                email = row.get('Email', '').strip()

                if not email:
                    continue

                base_username = (first_name + last_name).lower()
                username = base_username

                suffix = 1
                while User.objects.filter(username=username).exists():
                    username = f"{base_username}{suffix}"
                    suffix += 1

                user = User(
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
                user.save()
                count += 1
                print(f"User {username} created.")
            except Exception as e:
                print(f"Error on row {i}: {e}")

        print(f"\nToplam {count} kullanıcı eklendi: {csv_path} (limit={limit})")


if __name__ == "__main__":
    import_users_from_csv("scripts/people-10000.csv", limit=200)

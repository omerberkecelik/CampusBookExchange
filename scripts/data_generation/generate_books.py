import os
import sys
import django
import random
from datetime import datetime
sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'book_exchange_project.settings')
django.setup()
from listings.models import Book, Course, BookCourseAssignment
def generate_isbn():
    """Generate a valid 13-digit ISBN"""
    prefix = "978"
    group = str(random.randint(0, 9))
    publisher = str(random.randint(10000, 99999))
    title = str(random.randint(100, 999))
    partial = prefix + group + publisher + title
    partial = partial[:12]
    total = 0
    for i, digit in enumerate(partial):
        if i % 2 == 0:
            total += int(digit)
        else:
            total += int(digit) * 3
    check_digit = (10 - (total % 10)) % 10
    isbn = partial + str(check_digit)
    assert len(isbn) == 13, f"ISBN must be 13 digits, got {len(isbn)}"
    return isbn
BOOK_DATA = [
    ("Modern Web Development with React", "Sarah Chen", "Web Development", 2023, "Tech Press"),
    ("Advanced Machine Learning Techniques", "Dr. Michael Roberts", "Artificial Intelligence", 2024, "AI Publications"),
    ("Cloud Computing Architecture", "Jennifer Wu", "Cloud Computing", 2023, "Cloud Books"),
    ("Cybersecurity Fundamentals", "David Thompson", "Security", 2024, "SecureNet Press"),
    ("Python for Data Science", "Emily Zhang", "Programming", 2023, "Code Masters"),
    ("Blockchain Technology Explained", "Robert Kim", "Cryptocurrency", 2024, "Crypto Press"),
    ("Mobile App Development with Flutter", "Lisa Anderson", "Mobile Development", 2023, "App Dev Books"),
    ("Database Systems: Design and Implementation", "Prof. James Miller", "Databases", 2024, "DB Publishers"),
    ("Software Engineering Best Practices", "Maria Garcia", "Software Engineering", 2023, "Engineering Press"),
    ("Computer Networks: A Modern Approach", "Dr. Steven Lee", "Networking", 2024, "Network Books"),
    ("Advanced Calculus for Engineers", "Prof. Alan Stewart", "Mathematics", 2023, "Math Publications"),
    ("Statistical Methods in Research", "Dr. Rebecca White", "Statistics", 2024, "Stats Press"),
    ("Linear Algebra and Applications", "Thomas Brown", "Mathematics", 2023, "Academic Publishers"),
    ("Probability Theory and Random Processes", "Dr. Nina Patel", "Mathematics", 2024, "Probability Press"),
    ("Discrete Mathematics for Computer Science", "Prof. Kevin Liu", "Mathematics", 2023, "CS Math Books"),
    ("Numerical Analysis Methods", "Sandra Johnson", "Mathematics", 2024, "Numerical Press"),
    ("Mathematical Modeling in Science", "Dr. Christopher Davis", "Applied Math", 2023, "Science Books"),
    ("Game Theory and Economic Behavior", "Prof. Elizabeth Taylor", "Economics", 2024, "Econ Press"),
    ("Differential Equations: Theory and Practice", "Michael Wilson", "Mathematics", 2023, "DE Publishers"),
    ("Abstract Algebra: Modern Approach", "Dr. Patricia Moore", "Mathematics", 2024, "Algebra Books"),
    ("Strategic Management in Digital Age", "Karen Thompson", "Business", 2023, "Business Press"),
    ("International Finance and Markets", "Dr. Richard Anderson", "Finance", 2024, "Finance Books"),
    ("Marketing Analytics and Data Science", "Jessica Martinez", "Marketing", 2023, "Marketing Press"),
    ("Entrepreneurship and Innovation", "Prof. Daniel Brown", "Business", 2024, "Startup Publishers"),
    ("Corporate Finance Essentials", "Laura Williams", "Finance", 2023, "Corp Finance Press"),
    ("Supply Chain Management", "Dr. Robert Davis", "Operations", 2024, "SCM Books"),
    ("Business Ethics and Sustainability", "Michelle Johnson", "Business Ethics", 2023, "Ethics Press"),
    ("Human Resource Management", "Prof. Steven Clark", "HR Management", 2024, "HR Publishers"),
    ("Accounting Principles and Practice", "Nancy White", "Accounting", 2023, "Accounting Books"),
    ("E-commerce Strategies", "Dr. Brian Lee", "E-commerce", 2024, "Digital Commerce Press"),
    ("Modern Physics for Scientists", "Dr. Alexandra Chen", "Physics", 2023, "Physics Press"),
    ("Organic Chemistry: Structure and Function", "Prof. David Miller", "Chemistry", 2024, "Chem Books"),
    ("Cell Biology and Genetics", "Dr. Sarah Anderson", "Biology", 2023, "Bio Publishers"),
    ("Environmental Science and Sustainability", "Mark Johnson", "Environmental Science", 2024, "Green Press"),
    ("Astronomy: Exploring the Universe", "Dr. Lisa Brown", "Astronomy", 2023, "Space Books"),
    ("Biochemistry Fundamentals", "Prof. John Davis", "Biochemistry", 2024, "Biochem Press"),
    ("Quantum Mechanics Explained", "Dr. Emma Wilson", "Physics", 2023, "Quantum Publishers"),
    ("Marine Biology and Oceanography", "Prof. Michael Taylor", "Marine Science", 2024, "Ocean Books"),
    ("Geology: Earth's Dynamic Systems", "Dr. Jennifer Moore", "Geology", 2023, "Earth Science Press"),
    ("Microbiology: Principles and Applications", "Robert Garcia", "Microbiology", 2024, "Micro Publishers"),
    ("Mechanical Engineering Design", "Prof. Christopher Lee", "Mechanical Engineering", 2023, "Mech Press"),
    ("Electrical Circuits and Systems", "Dr. Amanda White", "Electrical Engineering", 2024, "EE Books"),
    ("Civil Engineering: Structures and Materials", "James Martinez", "Civil Engineering", 2023, "Civil Press"),
    ("Chemical Process Engineering", "Dr. Patricia Brown", "Chemical Engineering", 2024, "ChemE Publishers"),
    ("Aerospace Engineering Fundamentals", "Prof. William Johnson", "Aerospace", 2023, "Aero Books"),
    ("Biomedical Engineering Applications", "Dr. Susan Davis", "Biomedical Engineering", 2024, "BioMed Press"),
    ("Materials Science and Engineering", "Kevin Wilson", "Materials Science", 2023, "Materials Publishers"),
    ("Control Systems Engineering", "Dr. Barbara Taylor", "Control Systems", 2024, "Control Books"),
    ("Renewable Energy Systems", "Prof. Thomas Anderson", "Energy Engineering", 2023, "Energy Press"),
    ("Robotics and Automation", "Dr. Joseph Clark", "Robotics", 2024, "Robotics Publishers"),
    ("Modern American Literature", "Prof. Elizabeth Thompson", "Literature", 2023, "Lit Press"),
    ("World History: Global Perspectives", "Dr. Richard Brown", "History", 2024, "History Books"),
    ("Introduction to Philosophy", "Michael Davis", "Philosophy", 2023, "Philosophy Press"),
    ("Art History: Renaissance to Modern", "Dr. Sarah Miller", "Art History", 2024, "Art Publishers"),
    ("Cultural Anthropology", "Prof. Jennifer Wilson", "Anthropology", 2023, "Anthro Books"),
    ("Psychology: Mind and Behavior", "Dr. David Johnson", "Psychology", 2024, "Psych Press"),
    ("Sociology: Understanding Society", "Laura Martinez", "Sociology", 2023, "Society Publishers"),
    ("Music Theory and Composition", "Prof. Robert Lee", "Music", 2024, "Music Books"),
    ("Theatre and Performance Studies", "Dr. Amanda White", "Theatre", 2023, "Drama Press"),
    ("Film Studies: Critical Analysis", "Christopher Taylor", "Film Studies", 2024, "Film Publishers"),
    ("Modern Spanish Grammar", "Prof. Maria Rodriguez", "Spanish", 2023, "Language Press"),
    ("French Literature and Culture", "Dr. Pierre Dubois", "French", 2024, "French Books"),
    ("Mandarin Chinese for Business", "Li Wei", "Chinese", 2023, "Chinese Publishers"),
    ("German Language Essentials", "Prof. Hans Mueller", "German", 2024, "German Press"),
    ("Japanese: Language and Society", "Dr. Yuki Tanaka", "Japanese", 2023, "Japanese Books"),
    ("Arabic for Beginners", "Prof. Ahmed Hassan", "Arabic", 2024, "Arabic Publishers"),
    ("Italian Conversation and Grammar", "Dr. Marco Rossi", "Italian", 2023, "Italian Press"),
    ("Russian Language and Literature", "Prof. Natasha Petrov", "Russian", 2024, "Russian Books"),
    ("Korean: Modern Language Guide", "Dr. Kim Jung-ho", "Korean", 2023, "Korean Publishers"),
    ("Portuguese for Professionals", "Prof. Ana Silva", "Portuguese", 2024, "Portuguese Press"),
    ("Human Anatomy and Physiology", "Dr. Jennifer Smith", "Medicine", 2023, "Medical Press"),
    ("Pharmacology: Drug Actions", "Prof. Michael Brown", "Pharmacy", 2024, "Pharma Books"),
    ("Nursing Fundamentals", "Sarah Johnson", "Nursing", 2023, "Nursing Publishers"),
    ("Public Health and Epidemiology", "Dr. David Wilson", "Public Health", 2024, "Health Press"),
    ("Nutrition Science and Diet", "Prof. Lisa Anderson", "Nutrition", 2023, "Nutrition Books"),
    ("Physical Therapy Techniques", "Dr. Robert Davis", "Physical Therapy", 2024, "PT Publishers"),
    ("Mental Health and Counseling", "Michelle Taylor", "Psychology", 2023, "Mental Health Press"),
    ("Sports Medicine and Rehabilitation", "Dr. Christopher Lee", "Sports Medicine", 2024, "Sports Med Books"),
    ("Dental Science and Practice", "Prof. Amanda Martinez", "Dentistry", 2023, "Dental Publishers"),
    ("Emergency Medicine Protocols", "Dr. Steven Clark", "Emergency Medicine", 2024, "Emergency Press"),
    ("Educational Psychology", "Prof. Nancy White", "Education", 2023, "Education Press"),
    ("Curriculum Design and Assessment", "Dr. Brian Johnson", "Education", 2024, "Curriculum Books"),
    ("Teaching Methods for STEM", "Jessica Brown", "Education", 2023, "STEM Ed Publishers"),
    ("Special Education Strategies", "Prof. Daniel Miller", "Special Education", 2024, "Special Ed Press"),
    ("Early Childhood Development", "Dr. Laura Davis", "Child Development", 2023, "Child Dev Books"),
    ("Online Learning and Technology", "Prof. Robert Wilson", "EdTech", 2024, "EdTech Publishers"),
    ("Classroom Management Techniques", "Michelle Anderson", "Education", 2023, "Teaching Press"),
    ("Educational Leadership", "Dr. Steven Taylor", "Administration", 2024, "Leadership Books"),
    ("Language Teaching Methods", "Prof. Elizabeth Garcia", "Language Education", 2023, "Lang Ed Publishers"),
    ("Assessment and Evaluation", "Dr. Thomas Lee", "Education", 2024, "Assessment Press"),
    ("Constitutional Law Principles", "Prof. Richard Thompson", "Law", 2023, "Legal Press"),
    ("International Relations Theory", "Dr. Sarah Brown", "Political Science", 2024, "Politics Books"),
    ("Criminal Justice System", "Michael Davis", "Criminal Justice", 2023, "CJ Publishers"),
    ("Contract Law Essentials", "Prof. Jennifer Wilson", "Law", 2024, "Contract Press"),
    ("Political Philosophy", "Dr. David Johnson", "Philosophy", 2023, "Political Theory Books"),
    ("Environmental Law and Policy", "Laura Martinez", "Environmental Law", 2024, "Env Law Publishers"),
    ("Human Rights and Justice", "Prof. Robert Lee", "Human Rights", 2023, "Rights Press"),
    ("Corporate Law and Governance", "Dr. Amanda White", "Corporate Law", 2024, "Corp Law Books"),
    ("Public Policy Analysis", "Christopher Taylor", "Public Policy", 2023, "Policy Publishers"),
    ("International Law", "Prof. Elizabeth Anderson", "International Law", 2024, "Int Law Press"),
    ("Modern Architecture Principles", "Prof. Frank Wright", "Architecture", 2023, "Architecture Press"),
    ("Interior Design Fundamentals", "Dr. Sarah Chen", "Interior Design", 2024, "Design Books"),
    ("Urban Planning and Development", "Michael Brown", "Urban Planning", 2023, "Urban Publishers"),
    ("Sustainable Architecture", "Prof. Jennifer Green", "Green Architecture", 2024, "Sustainable Press"),
    ("Landscape Architecture", "Dr. David Miller", "Landscape Design", 2023, "Landscape Books"),
    ("Graphic Design Theory", "Laura Johnson", "Graphic Design", 2024, "Graphics Publishers"),
    ("Industrial Design Methods", "Prof. Robert Davis", "Industrial Design", 2023, "Industrial Press"),
    ("Digital Design and CAD", "Dr. Christopher Lee", "CAD Design", 2024, "CAD Books"),
    ("Historic Preservation", "Prof. Amanda Martinez", "Architecture History", 2023, "Preservation Publishers"),
    ("Building Construction Methods", "Steven Clark", "Construction", 2024, "Construction Press"),
    ("Sustainable Agriculture Practices", "Prof. Nancy White", "Agriculture", 2023, "Ag Press"),
    ("Climate Change Science", "Dr. Brian Johnson", "Environmental Science", 2024, "Climate Books"),
    ("Soil Science and Management", "Jessica Brown", "Agriculture", 2023, "Soil Publishers"),
    ("Water Resources Engineering", "Prof. Daniel Miller", "Environmental Engineering", 2024, "Water Press"),
    ("Forest Ecology and Management", "Dr. Laura Davis", "Forestry", 2023, "Forest Books"),
    ("Agricultural Economics", "Prof. Robert Wilson", "Ag Economics", 2024, "AgEcon Publishers"),
    ("Wildlife Conservation", "Michelle Anderson", "Conservation", 2023, "Wildlife Press"),
    ("Renewable Resources", "Dr. Steven Taylor", "Environmental Studies", 2024, "Renewable Books"),
    ("Plant Pathology", "Prof. Elizabeth Garcia", "Plant Science", 2023, "Plant Publishers"),
    ("Environmental Policy", "Dr. Thomas Lee", "Policy", 2024, "Env Policy Press"),
    ("Digital Media Production", "Prof. Richard Thompson", "Media Studies", 2023, "Media Press"),
    ("Journalism in Digital Age", "Dr. Sarah Brown", "Journalism", 2024, "Journal Books"),
    ("Public Relations Strategy", "Michael Davis", "PR", 2023, "PR Publishers"),
    ("Mass Communication Theory", "Prof. Jennifer Wilson", "Communications", 2024, "Comm Press"),
    ("Social Media Marketing", "Dr. David Johnson", "Marketing", 2023, "Social Media Books"),
    ("Broadcasting and Production", "Laura Martinez", "Broadcasting", 2024, "Broadcast Publishers"),
    ("Media Ethics and Law", "Prof. Robert Lee", "Media Ethics", 2023, "Ethics Press"),
    ("Visual Communication", "Dr. Amanda White", "Visual Arts", 2024, "Visual Books"),
    ("Digital Storytelling", "Christopher Taylor", "Digital Media", 2023, "Story Publishers"),
    ("Communication Research Methods", "Prof. Elizabeth Anderson", "Research", 2024, "Research Press"),
    ("Gender Studies: Contemporary Issues", "Prof. Maria Rodriguez", "Gender Studies", 2023, "Gender Press"),
    ("Religious Studies: World Religions", "Dr. Ahmed Hassan", "Religious Studies", 2024, "Religion Books"),
    ("African American Studies", "Michael Washington", "Ethnic Studies", 2023, "African Am Publishers"),
    ("Latin American Studies", "Prof. Carlos Mendez", "Area Studies", 2024, "Latin Am Press"),
    ("Asian Studies: History and Culture", "Dr. Yuki Tanaka", "Asian Studies", 2023, "Asian Books"),
    ("Middle Eastern Studies", "Prof. Fatima Al-Said", "Area Studies", 2024, "ME Publishers"),
    ("Indigenous Studies", "Dr. Joseph Crow", "Indigenous Studies", 2023, "Indigenous Press"),
    ("Peace and Conflict Studies", "Laura Peace", "Peace Studies", 2024, "Peace Books"),
    ("Museum Studies", "Prof. Elizabeth Gallery", "Museum Studies", 2023, "Museum Publishers"),
    ("Library and Information Science", "Dr. Thomas Book", "Information Science", 2024, "Library Press"),
    ("Data Visualization Techniques", "Alex Johnson", "Data Science", 2023, "DataViz Publishers"),
    ("Quantum Computing Fundamentals", "Dr. Lisa Quantum", "Computer Science", 2024, "Quantum Press"),
    ("Bioinformatics and Computational Biology", "Prof. Gene Sequence", "Biology", 2023, "BioComp Publishers"),
    ("Nanotechnology Applications", "Dr. Nano Small", "Engineering", 2024, "NanoTech Books"),
    ("Cognitive Neuroscience", "Prof. Brain Mind", "Neuroscience", 2023, "Neuro Press"),
    ("Renewable Energy Economics", "Dr. Solar Wind", "Economics", 2024, "Green Economics Publishers"),
    ("Digital Forensics and Security", "Prof. Cyber Safe", "Computer Science", 2023, "Security Books"),
    ("Advanced Robotics Systems", "Dr. Robot Auto", "Engineering", 2024, "Robotics Publishers"),
    ("Climate Engineering Solutions", "Prof. Weather Fix", "Environmental Science", 2023, "Climate Tech Press"),
    ("Space Technology and Exploration", "Dr. Star Trek", "Aerospace", 2024, "Space Publishers"),
    ("Artificial Intelligence Ethics", "Prof. AI Rights", "Philosophy", 2023, "Ethics in Tech Press"),
]
def create_books():
    """Create 151 new unique books to reach 220 total"""
    existing_isbns = set(Book.objects.values_list('isbn', flat=True))
    existing_titles = set(Book.objects.values_list('title', flat=True))
    courses = list(Course.objects.all())
    created_count = 0
    for title, author, subject, year, publisher in BOOK_DATA:
        if created_count >= 151:
            break
        if title in existing_titles:
            continue
        isbn = generate_isbn()
        while isbn in existing_isbns:
            isbn = generate_isbn()
        existing_isbns.add(isbn)
        edition = random.choice(["1st", "2nd", "3rd", "4th", "5th", "International", "Updated", "Revised"])
        book = Book.objects.create(
            isbn=isbn,
            title=title,
            author=author,
            edition=edition,
            publisher=publisher,
            publication_year=year
        )
        num_courses = random.randint(1, min(3, len(courses)))
        selected_courses = random.sample(courses, num_courses)
        for course in selected_courses:
            BookCourseAssignment.objects.create(
                book=book,
                course=course,
                is_required=random.choice([True, True, False])
            )
        created_count += 1
        print(f"Created book: {title} (ISBN: {isbn})")
    print(f"\nTotal books created: {created_count}")
    print(f"Total books in database: {Book.objects.count()}")
if __name__ == "__main__":
    create_books()
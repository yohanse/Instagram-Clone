
import random
from django.core.mail import send_mail
from django.conf import settings

def send_email(email):
    code = str(generate_six_digit_code())
    try: 
        send_mail(
            'Instagram',
            code,
            'settings.EMAIL_HOST_USER',
            [email],
            fail_silently=False
        )
        return code
    except Exception as error:
        raise Exception("The email doesn't sent")
    

def generate_six_digit_code():
    return random.randint(100000, 999999)
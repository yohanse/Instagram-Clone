
import random
from django.core.mail import send_mail
from django.conf import settings
from templated_mail.mail import BaseEmailMessage

def send_email(email):
    confirmation_code = generate_six_digit_code()

    try:
        message = BaseEmailMessage(
            template_name="emails/code_send_template.html",
            context={'code': confirmation_code,
                     'email': email}
        )
        message.send([email])
        # subject = 'Instagram Confirmation Code'
        # message = f'Your confirmation code is: {confirmation_code}'
        # from_email = settings.EMAIL_HOST_USER
        # send_mail(subject, message, from_email, [email], fail_silently=False)
        # return confirmation_code  # Return code if successful

    except Exception as error:
        print(f"Error sending email: {error}")
        raise Exception("The email could not be sent. Please check your email configuration or contact us for assistance.")
    

def generate_six_digit_code():
    return random.randint(100000, 999999)
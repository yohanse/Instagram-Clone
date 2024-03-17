from django.db import models
from django.contrib.auth.models import AbstractUser
from datetime import date

# Create your models here.

class User(AbstractUser):
    email = models.EmailField(unique=True)
    birth_date = models.DateField(default=date.today)
    is_loged_in = models.BooleanField(default=True)

class Confirmation(models.Model):
    email = models.EmailField()
    confirmation_code = models.CharField(max_length=6, null=True)
    is_confirmed = models.BooleanField(default=False)
from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.

class User(AbstractUser):
    email = models.EmailField(unique=True)
    birth_date = models.DateField()
    confirmation_code = models.CharField(max_length=6, default="123456")
    is_confirmed = models.BooleanField(default=False)
    is_loged_in = models.BooleanField(default=False)
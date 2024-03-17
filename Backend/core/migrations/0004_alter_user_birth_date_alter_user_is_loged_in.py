# Generated by Django 5.0.2 on 2024-03-17 13:48

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0003_alter_user_birth_date_alter_user_is_loged_in'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='birth_date',
            field=models.DateField(default=datetime.date.today),
        ),
        migrations.AlterField(
            model_name='user',
            name='is_loged_in',
            field=models.BooleanField(default=True),
        ),
    ]

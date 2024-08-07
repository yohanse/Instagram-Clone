# Generated by Django 5.0.3 on 2024-05-17 13:10

import django.db.models.deletion
import instagram.validator
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('instagram', '0006_userfollow'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userfollow',
            name='follower',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='following', to='instagram.user', validators=[instagram.validator.validate_not_same_user]),
        ),
    ]

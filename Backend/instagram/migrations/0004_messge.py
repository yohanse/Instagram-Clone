# Generated by Django 5.0.3 on 2024-05-07 12:27

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('instagram', '0003_reel_content'),
    ]

    operations = [
        migrations.CreateModel(
            name='Messge',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField()),
                ('file', models.FileField(blank=True, null=True, upload_to='message/files/')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('receiver', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='receiver', to='instagram.user')),
                ('sender', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sender', to='instagram.user')),
            ],
            options={
                'ordering': ['-created_at'],
            },
        ),
    ]
# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django_countries.fields
import django.utils.timezone
from django.conf import settings
import django.core.validators


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Friend',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('status', models.IntegerField(default=1, choices=[(1, b'Waiting'), (2, b'Confirmed'), (3, b'Stuck')])),
                ('seen', models.BooleanField(default=False)),
                ('data_request', models.DateField(default=django.utils.timezone.now)),
                ('reciver', models.ForeignKey(related_name='reciver_user', to=settings.AUTH_USER_MODEL)),
                ('sender', models.ForeignKey(related_name='sender_user', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Message',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('seen', models.BooleanField(default=False)),
                ('data_request', models.DateTimeField(default=django.utils.timezone.now)),
                ('text', models.TextField(null=True, blank=True)),
                ('reciver_message', models.ForeignKey(related_name='reciver_message', to=settings.AUTH_USER_MODEL)),
                ('sender_message', models.ForeignKey(related_name='sender_message', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='MusicianProfile',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('bio', models.TextField(null=True, blank=True)),
                ('img', models.ImageField(default=b'/static/musician/images/vm.jpg', null=True, upload_to=b'profile/', blank=True)),
                ('data', models.DateField(null=True, blank=True)),
                ('gender', models.CharField(blank=True, max_length=1, choices=[(b'M', b'Male'), (b'F', b'Female')])),
                ('phone_number', models.CharField(blank=True, max_length=15, null=True, validators=[django.core.validators.RegexValidator(regex=b'^\\+?1?\\d{9,15}$', message=b"Phone number must be entered in the format: '+999999999'. Up to 15 digits allowed.")])),
                ('city', models.CharField(max_length=50, null=True, blank=True)),
                ('country', django_countries.fields.CountryField(blank=True, max_length=2)),
                ('user', models.OneToOneField(to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Skill',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name_skill', models.CharField(unique=True, max_length=20)),
                ('image_skill', models.ImageField(default=b'/static/musician/images/question-mark-icon.png', null=True, upload_to=b'skill/', blank=True)),
            ],
        ),
        migrations.AlterUniqueTogether(
            name='friend',
            unique_together=set([('sender', 'reciver')]),
        ),
    ]

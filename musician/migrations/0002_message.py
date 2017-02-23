# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.utils.timezone
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('musician', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Message',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('seen', models.BooleanField(default=False)),
                ('data_request', models.DateField(default=django.utils.timezone.now)),
                ('text', models.TextField(null=True, blank=True)),
                ('reciver_message', models.ForeignKey(related_name='reciver_message', to=settings.AUTH_USER_MODEL)),
                ('sender_message', models.ForeignKey(related_name='sender_message', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]

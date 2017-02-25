import os

from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from django.utils import timezone
from django.core.validators import RegexValidator
from django.forms import forms
# Settings root image folder

profile_image = os.path.join(settings.STATIC_URL, 'musician/images/vm.jpg')
profile_url = 'profile/'


class MusicianProfile(models.Model):
    GENDER_CHOICES = (
        ('M', 'Male'),
        ('F', 'Female'),
    )
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    bio = models.TextField(null=True, blank=True)
    img = models.ImageField(null=True, blank=True, default=profile_image, upload_to=profile_url)
    data = models.DateField(null=True, blank=True)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES, blank=True)

    def __unicode__(self):
        return unicode(self.user)


#class Characteristic(models.Model):
#    charact_text = models.CharField(max_length=50)
#    def __unicode__(self):
#        return self.charact_text


#class Notification(models.Model):
#    note_title = models.CharField(max_length=20)
#    note_desc = models.CharField(max_length=50)
#    def __unicode__(self):
#        return self.note_title

class Friend(models.Model):

    STATUS_CHOICES = (
        (1, 'Waiting'),
        (2, 'Confirmed'),
        (3, 'Stuck'),
    )

    class Meta:
        unique_together = (('sender', 'reciver'),)

    sender = models.ForeignKey(User, related_name="sender_user")
    reciver = models.ForeignKey(User, related_name="reciver_user")
    status = models.IntegerField(choices=STATUS_CHOICES, default=1)
    seen = models.BooleanField(default=False)
    data_request = models.DateField(default=timezone.now)

    def __unicode__(self):
        return unicode(self.sender)

    @classmethod
    def create(self, sender, reciver):
        friend = self(sender=sender, reciver=reciver)
        return friend


class Message(models.Model):

    sender_message = models.ForeignKey(User, related_name="sender_message")
    reciver_message = models.ForeignKey(User, related_name="reciver_message")
    seen = models.BooleanField(default=False)
    data_request = models.DateField(default=timezone.now)
    text = models.TextField(null=True, blank=True)

    def __unicode__(self):
        return unicode(self.sender_message)

    @classmethod
    def create(self, sender, reciver, text):
        message = self(sender_message=sender, reciver_message=reciver, text=text)
        return message


class Skill(models.Model):
    name_skill = models.CharField(max_length=20, unique=True)

    def __unicode__(self):
        return unicode(self.name_skill)

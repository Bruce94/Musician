import os

from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from django.utils import timezone
from django.db.models import Q
from django.core.validators import RegexValidator
from django_countries.fields import CountryField

# Settings root image folder
profile_image = os.path.join(settings.STATIC_URL, 'musician/images/vm.jpg')
skill_image = os.path.join(settings.STATIC_URL, 'musician/images/question-mark-icon.png')
profile_url = 'profile/'
skill_url = 'skill/'


class Skill(models.Model):
    name_skill = models.CharField(max_length=20, unique=True)
    image_skill = models.ImageField(null=True, blank=True, default=skill_image, upload_to=skill_url)

    def __unicode__(self):
        return unicode(self.name_skill)


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
    phone_regex = RegexValidator(regex=r'^\+?1?\d{9,15}$',
                                 message="Phone number must be"
                                         " entered in the format: '+999999999'. Up to 15 digits allowed.")
    phone_number = models.CharField(validators=[phone_regex], null=True, blank=True, max_length=15)
    city = models.CharField(null=True, blank=True, max_length=50)
    country = CountryField(blank=True)
    skills = models.ManyToManyField(Skill, through='HasSkill')
    #endorsement = models.ManyToManyField("HasSkill")

    def __unicode__(self):
        return unicode(self.user)

    @staticmethod
    def get_musician(**kwargs):
        return MusicianProfile.objects.filter(**kwargs)


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

    @staticmethod
    def n_req_friendship(user):
        return len(Friend.objects.all().filter(Q(reciver__username=user.username) & Q(seen=False) &
                                               Q(status=1)))

    @staticmethod
    def get_friendship(user1, user2):

        if Friend.objects.all().filter(Q(sender__username=user1.username) &
                                       Q(reciver__username=user2.username)):
            return list(Friend.objects.all().filter(Q(sender__username=user1.username) &
                                                    Q(reciver__username=user2.username))).__getitem__(0)
        elif Friend.objects.all().filter(Q(sender__username=user2.username) &
                                         Q(reciver__username=user1.username)):
            return list(Friend.objects.all().filter(Q(sender__username=user2.username) &
                                                    Q(reciver__username=user1.username))).__getitem__(0)
        return None

    @staticmethod
    def get_user_friends(user):

        friendships = Friend.objects.all().filter((Q(sender__username=user.username) |
                                                   Q(reciver__username=user.username)) &
                                                  Q(status=2))
        friend_user = []
        if friendships:
            for friendship in friendships:
                if friendship.reciver.id == user.id:
                    friend_user += list(MusicianProfile.objects.all().filter(Q(user__id=friendship.sender.id)))
                elif friendship.sender.id == user.id:
                    friend_user += list(MusicianProfile.objects.all().filter(Q(user__id=friendship.reciver.id)))
        return friend_user

    @staticmethod
    def get_pending_request(user):
        return Friend.objects.all().filter(Q(reciver__username=user.username) &
                                           Q(status=1))


class Message(models.Model):

    sender_message = models.ForeignKey(User, related_name="sender_message")
    reciver_message = models.ForeignKey(User, related_name="reciver_message")
    seen = models.BooleanField(default=False)
    data_request = models.DateTimeField(default=timezone.now)
    text = models.TextField(null=True, blank=True)

    def __unicode__(self):
        return unicode(self.sender_message)

    @classmethod
    def create(self, sender, reciver, text):
        message = self(sender_message=sender, reciver_message=reciver, text=text)
        return message

    @staticmethod
    def n_new_messages(user):
        return len(Message.objects.all().filter(Q(reciver_message__username=user.username) & Q(seen=False)))

    @staticmethod
    def new_user_message(user):
        new_mes = Message.objects.all().filter(seen=False, reciver_message__username=user.username)
        new_mes_user = []
        for mes in new_mes:
            if not (MusicianProfile.objects.all().filter(
                    Q(user__username=mes.sender_message.username)).__getitem__(0) in new_mes_user):
                new_mes_user += list(
                    MusicianProfile.objects.all().filter(Q(user__username=mes.sender_message.username)))
        return new_mes_user

    @staticmethod
    def messages_of_chat(user1, user2):
        return Message.objects.all().filter((Q(reciver_message__username=user1.username) &
                                             Q(sender_message__username=user2.username)) |
                                            (Q(reciver_message__username=user2.username) &
                                             Q(sender_message__username=user1.username))).order_by('data_request')


class HasSkill(models.Model):
    class Meta:
        unique_together = (('musicianprofile', 'skill'),)

    musicianprofile = models.ForeignKey(MusicianProfile, related_name="user_skill")
    skill = models.ForeignKey(Skill)
    endorse_user = models.ManyToManyField(MusicianProfile)

    def __unicode__(self):
        return unicode(self.musicianprofile)

    @classmethod
    def create(self, musicianprofile, skill):
        if not HasSkill.objects.filter(musicianprofile=musicianprofile, skill=skill):
            has_skill = self(musicianprofile=musicianprofile, skill=skill)
            has_skill.save()


class Post(models.Model):

    musician_profile = models.ForeignKey(MusicianProfile, on_delete=models.CASCADE, related_name="user_post")
    post_text = models.CharField(max_length=255, blank=False)
    pub_date = models.DateTimeField(default=timezone.now)
    user_comments = models.ManyToManyField(MusicianProfile, through='Comment')

    def __unicode__(self):
        return unicode(self.musician_profile)

    class Meta:
        ordering = ['-pub_date']


class Comment(models.Model):
    musician_profile = models.ForeignKey(MusicianProfile)
    post = models.ForeignKey(Post)
    pub_date = models.DateTimeField(default=timezone.now)
    comment_text = models.CharField(max_length=255, blank=False)

    def __unicode__(self):
        return unicode(self.musician_profile)

    class Meta:
        ordering = ['pub_date']

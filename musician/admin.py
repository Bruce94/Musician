from django.contrib import admin
from .models import MusicianProfile, Friend, Message, Skill, Post, HasSkill, Comment
from django.db import models
from django.forms import CheckboxSelectMultiple


class MusicianProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'data', 'gender', 'city', 'country')
    list_filter = ('skills', 'country')
    ordering = ('user', )
    formfield_overrides = {
        models.ManyToManyField: {'widget': CheckboxSelectMultiple},
    }
    fieldsets = [
        ('Musician profile data:', {'fields': ['user', 'bio', 'img']}),
        ('Personal Information:', {'fields': ['data', 'gender', 'country', 'city']}),
        ('General Information:', {'fields': ['phone_number']}),
    ]


class MessageAdmin(admin.ModelAdmin):
    list_display = ('sender_message', 'reciver_message', 'data_request')
    list_filter = ('data_request', )
    ordering = ('-data_request', )
    search_fields = ('text',)
    fieldsets = [
        ('Message Info: ', {'fields': ['sender_message', 'reciver_message', 'text', 'seen', 'data_request']}),
    ]


class FriendAdmin(admin.ModelAdmin):
    list_display = ('sender', 'reciver', 'status', 'data_request')
    list_filter = ('data_request', )
    ordering = ('-data_request', )
    fieldsets = [
        ('Friendship Info: ', {'fields': ['sender', 'reciver', 'status', 'seen', 'data_request']})
    ]


class HasSkillAdmin(admin.ModelAdmin):
    list_display = ('musicianprofile', 'skill')
    ordering = ('musicianprofile', )
    fieldsets = [
        ('HasSkill Info: ', {'fields': ['musicianprofile', 'skill', 'endorse_user']})
    ]


class PostAdmin(admin.ModelAdmin):
    list_display = ('musician_profile', 'post_text')
    ordering = ('-pub_date', )
    list_filter = ('musician_profile', 'pub_date')
    fieldsets = [
        ('HasSkill Info: ', {'fields': ['musician_profile', 'post_text', 'pub_date']})
    ]


class CommentAdmin(admin.ModelAdmin):
    list_display = ('musician_profile', 'post', 'comment_text')
    ordering = ('-pub_date', )
    list_filter = ('musician_profile', 'pub_date')
    fieldsets = [
        ('HasSkill Info: ', {'fields': ['musician_profile', 'post', 'pub_date', 'comment_text', 'seen']})
    ]

admin.site.register(MusicianProfile, MusicianProfileAdmin)
admin.site.register(Friend, FriendAdmin)
admin.site.register(Message, MessageAdmin)
admin.site.register(HasSkill, HasSkillAdmin)
admin.site.register(Skill)
admin.site.register(Post, PostAdmin)
admin.site.register(Comment, CommentAdmin)

#admin.site.register(HasSkill, HasSkillAdmin)


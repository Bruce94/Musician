from django.contrib import admin
from .models import MusicianProfile, Friend, Message, Skill, Post
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


admin.site.register(MusicianProfile, MusicianProfileAdmin)
admin.site.register(Friend, FriendAdmin)
admin.site.register(Message, MessageAdmin)
admin.site.register(Skill)
admin.site.register(Post)

#admin.site.register(HasSkill, HasSkillAdmin)


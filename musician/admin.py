from django.contrib import admin
from .models import MusicianProfile, Friend, Message, Skill, Post, HasSkill, Comment, Tag, Preference
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
    list_display = ('musician_profile_name', 'skill_name')
    ordering = ('musicianprofile', )
    fieldsets = [
        ('HasSkill Info: ', {'fields': ['musicianprofile', 'skill', 'endorse_user']})
    ]

    def skill_name(self, obj):
        return obj.skill.name_skill

    def musician_profile_name(self, obj):
        return obj.musicianprofile.user


class SkillAdmin(admin.ModelAdmin):
    list_display = ('name_skill',)
    ordering = ('name_skill', )
    fieldsets = [
        ('Skill Info: ', {'fields': ['name_skill', 'image_skill']})
    ]


class PostAdmin(admin.ModelAdmin):
    list_display = ('musician_profile_name', 'post_text')
    ordering = ('-pub_date', )
    list_filter = ('musician_profile', 'pub_date')
    fieldsets = [
        ('Post Info: ', {'fields': ['musician_profile', 'post_text', 'pub_date']})
    ]

    def musician_profile_name(self, obj):
        return obj.musician_profile.user

class CommentAdmin(admin.ModelAdmin):
    list_display = ('musician_profile_name', 'post_text', 'comment_text')
    ordering = ('-pub_date', )
    list_filter = ('musician_profile', 'pub_date')
    fieldsets = [
        ('Comment Info: ', {'fields': ['musician_profile', 'post', 'pub_date', 'comment_text', 'seen']})
    ]

    def musician_profile_name(self, obj):
        return obj.musician_profile.user

    def post_text(self, obj):
        return obj.post.post_text

class TagAdmin(admin.ModelAdmin):
    list_display = ('tag_text',)
    ordering = ('-pub_date', )
    list_filter = ('post','comment')
    fieldsets = [
        ('Tag Info: ', {'fields': ['tag_text', 'post', 'comment']})
    ]

class PreferenceAdmin(admin.ModelAdmin):
    list_display = ('musician_profile_name', 'vote', 'post_text',)
    ordering = ('-pub_date', )
    list_filter = ('vote','musician_profile')
    fieldsets = [
        ('Preference Info: ', {'fields': ['vote', 'post']})
    ]

    def musician_profile_name(self, obj):
        return obj.musician_profile.user

    def post_text(self, obj):
        return obj.post.post_text

admin.site.register(MusicianProfile, MusicianProfileAdmin)
admin.site.register(Friend, FriendAdmin)
admin.site.register(Message, MessageAdmin)
admin.site.register(HasSkill, HasSkillAdmin)
admin.site.register(Skill, SkillAdmin)
admin.site.register(Post, PostAdmin)
admin.site.register(Comment, CommentAdmin)
admin.site.register(Tag, TagAdmin)
admin.site.register(Preference, PreferenceAdmin)

#admin.site.register(HasSkill, HasSkillAdmin)


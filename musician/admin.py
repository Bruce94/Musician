from django.contrib import admin
from .models import MusicianProfile, Friend, Message, Skill, HasSkill


class MusicianProfileAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['bio', 'img', 'gender', 'data']}),
    ]


class MessageAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['sender_message', 'reciver_message', 'text', 'seen', 'data_request']}),
    ]


class FriendAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['sender', 'reciver', 'status', 'seen', 'data_request']})
    ]


class SkillAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['name_skill', 'image_skill']})
    ]


class HasSkillAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['user', 'skill', 'endorsement']})
    ]

admin.site.register(MusicianProfile, MusicianProfileAdmin)
admin.site.register(Friend, FriendAdmin)
admin.site.register(Message, MessageAdmin)
admin.site.register(Skill, SkillAdmin)
admin.site.register(HasSkill, HasSkillAdmin)


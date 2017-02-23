from django.contrib import admin
from .models import MusicianProfile, Friend, Message
#from .models import Characteristic, Notification


class MusicianProfileAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['bio', 'img', 'gender', 'data']}),
    ]


class FriendAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['sender', 'reciver', 'status', 'seen', 'data_request']})
    ]


class MessageAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['sender', 'reciver', 'text', 'seen', 'data_request']})
    ]

admin.site.register(MusicianProfile, MusicianProfileAdmin)
admin.site.register(Friend, FriendAdmin)
admin.site.register(Message, MessageAdmin)

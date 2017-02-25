from django.contrib import admin
from .models import MusicianProfile, Friend, Message


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


admin.site.register(MusicianProfile, MusicianProfileAdmin)
admin.site.register(Friend, FriendAdmin)
admin.site.register(Message, MessageAdmin)

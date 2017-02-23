from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^(?P<user_id>[0-9]+)/$', views.profile, name='profile'),
    url(r'^(?P<user_id>[0-9]+)/info$', views.musician_info, name='musician-profile'),
    url(r'^(?P<user_id>[0-9]+)/friends$', views.musician_friends, name='musician-firends'),
    url(r'messages$', views.messages, name='messages'),
    url(r'^messages/(?P<user_id>[0-9]+)/$', views.chat, name='chat')
]

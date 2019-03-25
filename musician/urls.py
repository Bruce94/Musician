from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^(?P<user_id>[0-9]+)/$', views.profile, name='profile'),
    url(r'^(?P<user_id>[0-9]+)/info$', views.musician_info, name='musician-profile'),
    url(r'^(?P<user_id>[0-9]+)/friends$', views.musician_friends, name='musician-firends'),
    url(r'^messages$', views.messages, name='messages'),
    url(r'^messages/(?P<user_id>[0-9]+)/$', views.chat, name='chat'),
    url(r'^messages/(?P<user_id>[0-9]+)/post/$', views.chat_post, name='chat_post'),
    url(r'^messages/(?P<user_id>[0-9]+)/get/$', views.chat_get, name='chat_get'),
    url(r'^messages/get_newmsg/$', views.new_msg, name='new_msg'),

]

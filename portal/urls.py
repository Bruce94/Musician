from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.portal_welcome, name='portal_welcome'),
    url(r'^search$', views.search_musician, name='search_user'),
    url(r'^friendship_requests$', views.friendship_request, name='friendship_request'),
    url(r'^comment_notifications$', views.comment_notifications, name='comment_notifications'),
    url(r'^post/(?P<post_id>[0-9]+)/$', views.post, name='post'),
    url(r'^new_post/(?P<user_id>[0-9]+)/post/$', views.newpost_post, name='newpost_post'),
    url(r'^new_post/get/$', views.newpost_get, name='newpost_get'),
    url(r'^tag/(?P<tag_text>.*)/$', views.tag_post, name='tag_post'),
]

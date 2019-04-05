from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.portal_welcome, name='portal_welcome'),
    url(r'^search$', views.search_musician, name='search_user'),
    url(r'^friendship_requests$', views.friendship_request, name='friendship_request'),
    url(r'^comment_notifications$', views.comment_notifications, name='comment_notifications'),
    url(r'^view_post_notificated/(?P<post_id>[0-9]+)/$', views.view_post_notificated, name='view_post_notificated'),
    url(r'^new_post/(?P<user_id>[0-9]+)/post/$', views.newpost_post, name='newpost_post'),
    url(r'^new_post/get/$', views.newpost_get, name='newpost_get'),
    url(r'^tag/(?P<tag_text>.*)/$', views.tag_post, name='tag_post'),
    url(r'^like/(?P<vote>[0-9]+)/(?P<post_id>[0-9]+)/get/$', views.like_post_get, name='like_post_get'),
]

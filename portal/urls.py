from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.portal_welcome, name='portal_welcome'),
    url(r'^search$', views.search_musician, name='search_user'),
    url(r'friendship_requests$', views.friendship_request, name='friendship_request')
]

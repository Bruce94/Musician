from django.conf.urls import include, url
from django.contrib import admin
from django.conf import settings
from django.views.generic.edit import CreateView
from django.contrib.auth.forms import UserCreationForm, User
from django.conf.urls.static import static
from . import views

urlpatterns = [
    url(r'^musician/', include('musician.urls', namespace="musician")),
    url(r'^portal/', include('portal.urls', namespace="portal")),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', views.main_page),
    url(r'^logout/$', views.logout_view, name='logout_view'),
    #url(r'^register/$', CreateView.as_view(template_name='registration/register.html',
    #                                       form_class=UserCreationForm,
    #                                       success_url='/'), name="register"),
    url(r'^register/$', views.register, name='register'),
    url(r'^register/ok$', views.register_ok, name='register_ok'),
    url(r'^', include('django.contrib.auth.urls'))
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

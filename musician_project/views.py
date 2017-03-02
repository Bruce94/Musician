from django.shortcuts import render, render_to_response, get_object_or_404
from django.contrib.auth import logout
from django.http import HttpResponseRedirect, HttpResponse
from django.template import RequestContext
from django.core.urlresolvers import reverse
from musician.models import MusicianProfile
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from musician_project.forms import UserForm, MusicianProfileForm


def main_page(request):
    return render(request, 'index.html')


def logout_view(request):
    logout(request)
    return HttpResponseRedirect('/')


def reg_view(request):
    return render(request, 'registration/register.html')


def register(request):
    if request.method == 'POST':
        uf = UserForm(request.POST, prefix='user')
        mpf = MusicianProfileForm(request.POST, request.FILES, prefix='profile')
        if uf.is_valid() * mpf.is_valid():
            user = uf.save()
            musicianprofile = mpf.save(commit=False)
            musicianprofile.user = user
            musicianprofile.img = mpf.cleaned_data["img"]
            musicianprofile.save()
            return HttpResponseRedirect(reverse('register_ok'))
    else:
        uf = UserForm(prefix='user')
        mpf = MusicianProfileForm(prefix='profile')
    return render_to_response('registration/register.html',
                              dict(userform=uf,
                                   musicianprofileform=mpf),
                                   context_instance=RequestContext(request))


def register_ok(request):
    return render(request, 'registration/register_ok.html')

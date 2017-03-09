from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.db.models import Q
from django.http import HttpResponseRedirect

from musician.models import MusicianProfile, Friend, Message, Skill, HasSkill, Post
from musician_project.forms import UserForm, MusicianProfileForm
from itertools import chain
from django.template import RequestContext


@login_required
def portal_welcome(request):
    user = get_object_or_404(User, pk=request.user.id)
    n_req = Friend.n_req_friendship(request.user)
    n_mes = len(Message.objects.all().filter(Q(reciver_message__username=request.user.username) & Q(seen=False)))
    user_friends = Friend.get_user_friends(user)
    home_posts = []
    for post in Post.objects.all():
        if (post.musician_profile in user_friends) or post.musician_profile == user.musicianprofile:
            home_posts += [post]

    if request.POST.get('post'):
        user.musicianprofile.user_post.create(post_text=request.POST['post'])

    for post in user.musicianprofile.user_post.all():
        if request.POST.get('del_'+str(post.id)):
            post.delete()
            return HttpResponseRedirect('/portal/')
    return render(request, 'portal/home.html', {'user': user,
                                                'home_posts': home_posts,
                                                'n_req': n_req,
                                                'n_mes': n_mes})


@login_required
def search_musician(request):

    profile_list = []
    checked_skills = []

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)
    mpf = MusicianProfileForm(prefix='profile')

    skills = Skill.objects.all()

    if request.method == 'GET':
        mpf = MusicianProfileForm(request.GET, request.FILES, prefix='profile')

        query = request.GET.get('search_musician') or None
        if query:
            for q in query.split():
                profile_list = set(chain(MusicianProfile.get_musician(user__username__icontains=q),
                                         MusicianProfile.get_musician(user__first_name__icontains=q),
                                         MusicianProfile.get_musician(user__last_name__icontains=q)))

        if request.GET.getlist('check_skill'):
            checked_skills = request.GET.getlist('check_skill')
            profiles = []
            for skill in checked_skills:
                has_skills = HasSkill.objects.filter(skill__name_skill=skill)
                for hs in has_skills:
                    profiles += [hs.musicianprofile]
            profiles = set(profiles)
            if profile_list:
                profile_list = profiles.intersection(profile_list)
            else:
                profile_list = profiles

        if mpf.is_valid():
            if mpf.cleaned_data['country']:
                profiles = set(MusicianProfile.get_musician(country=mpf.cleaned_data['country']))
                if profile_list:
                    profile_list = profiles.intersection(profile_list)
                else:
                    profile_list = profiles

            if mpf.cleaned_data['gender']:
                profiles = set(MusicianProfile.get_musician(gender=mpf.cleaned_data['gender']))
                if profile_list:
                    profile_list = profiles.intersection(profile_list)
                else:
                    profile_list = profiles

    return render(request, 'portal/search_musician.html', {'profile_list': profile_list,
                                                           'query': query,
                                                           'skills': skills,
                                                           'checked_skills': checked_skills,
                                                           'musicianprofileform': mpf,
                                                           'n_req': n_req,
                                                           'n_mes': n_mes})


@login_required
def friendship_request(request):

    friendships = Friend.get_pending_request(request.user)
    n_mes = Message.n_new_messages(request.user)

    result = False
    musicians = MusicianProfile.objects.all()
    profile_list = []

    if friendships:
        for friendship in friendships:
            if musicians.filter(Q(user__username=friendship.sender.username)):
                profile_list += list(musicians.filter(Q(user__username=friendship.sender.username)))
                friendship.seen = True
                friendship.save()
                result = True

    n_req = Friend.n_req_friendship(request.user)
    return render(request, 'portal/friendship_request.html', {'profile_list': profile_list,
                                                              'result': result,
                                                              'n_req': n_req,
                                                              'n_mes': n_mes})


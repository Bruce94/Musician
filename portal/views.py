from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.db.models import Q
from musician.models import MusicianProfile, Friend, Message, Skill, HasSkill
from musician_project.forms import UserForm, MusicianProfileForm
from itertools import chain
from django.template import RequestContext


@login_required
def portal_welcome(request):
    user = get_object_or_404(User, pk=request.user.id)
    profile = get_object_or_404(MusicianProfile, user=request.user.id)
    n_req = Friend.n_req_friendship(request.user)
    n_mes = len(Message.objects.all().filter(Q(reciver_message__username=request.user.username) & Q(seen=False)))

    return render(request, 'portal/home.html', {'user': user,
                                                'profile': profile,
                                                'n_req': n_req,
                                                'n_mes': n_mes})


@login_required
def search_musician(request):

    query = request.GET.get('search_musician') or None
    profile_list = []

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)
    mpf = MusicianProfileForm(prefix='profile')

    skills = Skill.objects.all()

    if query:
        for q in query.split():
            profile_list = set(chain(MusicianProfile.get_musician(user__username__icontains=q),
                                     MusicianProfile.get_musician(user__first_name__icontains=q),
                                     MusicianProfile.get_musician(user__last_name__icontains=q)))

    if request.method == 'GET':
        b = []
        if request.GET.getlist('check_skill'):
            checked_skills = request.GET.getlist('check_skill')
            for skill in checked_skills:
                users = HasSkill.get_users(Skill.objects.filter(name_skill=skill).__getitem__(0))
                for user in users:
                    b = chain(b, MusicianProfile.get_musician(user=user))
                    print(b)
            profile_list = set(b)
    return render(request, 'portal/search_musician.html', {'profile_list': profile_list,
                                                           'query': query,
                                                           'skills': skills,
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


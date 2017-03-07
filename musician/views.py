from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, render
from django.contrib.auth.models import User
from django.http import HttpResponseRedirect
from django.core.urlresolvers import reverse
from musician_project.forms import UserForm, MusicianProfileForm
from musician.models import MusicianProfile, Friend, Message, Skill, HasSkill


@login_required
def profile(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    profile = get_object_or_404(MusicianProfile, user=user_id)

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)

    status_friend = 0
    reciver = None

    if Friend.get_friendship(request.user, user):
        fs = Friend.get_friendship(request.user, user)
        reciver = fs.reciver
        status_friend = fs.status

    if request.method == 'POST':
        if "add-friend" in request.POST:
            friend = Friend.create(sender=request.user, reciver=user)
            friend.save()
            status_friend = 1
        elif "cancel-request" in request.POST:
            fs.delete()
            status_friend = 0
        elif "accept-friend" in request.POST:
            fs.status = 2
            fs.save()
            status_friend = 2
        elif "send-message" in request.POST:
            return HttpResponseRedirect('/musician/messages/'+str(user.id))

    return render(request, 'musician/profile.html', {'user': user,
                                                     'profile': profile,
                                                     'reciver': reciver,
                                                     'status_friend': status_friend,
                                                     'n_req': n_req,
                                                     'n_mes': n_mes})


@login_required
def musician_info(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    profile = get_object_or_404(MusicianProfile, user=user_id)

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)

    mpf = MusicianProfileForm(prefix='profile')

    skills = Skill.objects.all()

    if request.method == 'GET':

        mpf = MusicianProfileForm(request.GET, request.FILES, prefix='profile')

        if request.GET.get('first_name'):
            user.first_name = request.GET.get('first_name')
            user.save()

        if request.GET.get('first_name'):
            user.last_name = request.GET.get('last_name')
            user.save()

        if request.GET.get('city'):
            profile.city = request.GET.get('city')
            profile.save()

        if request.GET.get('bio'):
            profile.bio = request.GET.get('bio')
            profile.save()

        if request.GET.getlist('check_skill'):
            checked_skills = request.GET.getlist('check_skill')
            for user_skill in profile.skills.all():
                if not(user_skill.name_skill in checked_skills):
                    hs = HasSkill.objects.all().filter(musicianprofile=profile, skill=user_skill).__getitem__(0)
                    hs.delete()
            for skill in skills:
                if skill.name_skill in checked_skills:
                    HasSkill.create(musicianprofile=profile, skill=skill)
        if mpf.is_valid():
            if mpf.cleaned_data['data']:
                profile.data = mpf.cleaned_data['data']
                profile.save()
            if mpf.cleaned_data['gender']:
                profile.gender = mpf.cleaned_data['gender']
                profile.save()
            if mpf.cleaned_data['country']:
                profile.country = mpf.cleaned_data['country']
                profile.save()
            if mpf.cleaned_data['phone_number']:
                profile.phone_number = mpf.cleaned_data['phone_number']
                profile.save()
    status_friend = 0
    reciver = None

    if Friend.get_friendship(request.user, user):
        fs = Friend.get_friendship(request.user, user)
        reciver = fs.reciver
        status_friend = fs.status

    if request.method == 'POST':
        if "add-friend" in request.POST:
            friend = Friend.create(sender=request.user, reciver=user)
            friend.save()
            status_friend = 1
        elif "cancel-request" in request.POST:
            fs.delete()
            status_friend = 0
        elif "accept-friend" in request.POST:
            fs.status = 2
            fs.save()
            status_friend = 2

        # handle the endorsements of users on skills
        for skill in skills:
            if ("btn_"+skill.name_skill) in request.POST:
                has_skill = HasSkill.objects.filter(musicianprofile=user.musicianprofile, skill=skill)
                for hs in has_skill:
                    hs.endorse_user.add(request.user.musicianprofile)
            elif ("btn_"+skill.name_skill+"_rem") in request.POST:
                has_skill = HasSkill.objects.filter(musicianprofile=user.musicianprofile, skill=skill)
                for hs in has_skill:
                    hs.endorse_user.remove(request.user.musicianprofile)

    user_has_skill = HasSkill.objects.filter(musicianprofile=user.musicianprofile)
    return render(request, 'musician/musician_info.html', {'user': user,
                                                           'profile': profile,
                                                           'reciver': reciver,
                                                           'user_has_skill': user_has_skill,
                                                           'musicianprofileform': mpf,
                                                           'skills': skills,
                                                           'status_friend': status_friend,
                                                           'n_req': n_req,
                                                           'n_mes': n_mes})


@login_required
def musician_friends(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    profile = get_object_or_404(MusicianProfile, user=user_id)

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)

    status_friend = 0
    reciver = None
    if Friend.get_friendship(request.user, user):
        fs = Friend.get_friendship(request.user, user)
        reciver = fs.reciver
        status_friend = fs.status

    friend_user = Friend.get_user_friends(user)

    if request.method == 'POST':
        if "add-friend" in request.POST:
            friend = Friend.create(sender=request.user, reciver=user)
            friend.save()
            status_friend = 1
        elif "cancel-request" in request.POST:
            fs.delete()
            status_friend = 0
        elif "accept-friend" in request.POST:
            fs.status = 2
            fs.save()
            status_friend = 2

    return render(request, 'musician/musician_friends.html', {'user': user,
                                                              'profile': profile,
                                                              'reciver': reciver,
                                                              'friend_user': friend_user,
                                                              'status_friend': status_friend,
                                                              'n_req': n_req,
                                                              'n_mes': n_mes})


@login_required
def messages(request):

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)

    friend_user = Friend.get_user_friends(request.user)
    friend_user.sort(key=lambda x: x.user.first_name, reverse=False)

    new_mes_user = Message.new_user_message(request.user)
    return render(request, 'musician/messages.html', {'n_req': n_req,
                                                      'n_mes': n_mes,
                                                      'friend_user': friend_user,
                                                      'new_mes_user': new_mes_user
                                                      })


@login_required
def chat(request, user_id):
    user = get_object_or_404(User, pk=user_id)

    n_req = Friend.n_req_friendship(request.user)

    messages_of_chat = Message.messages_of_chat(request.user, user)

    for message in messages_of_chat:
        if message.reciver_message.id == request.user.id:
            message.seen = True
            message.save()

    n_mes = Message.n_new_messages(request.user)

    friend_user = Friend.get_user_friends(request.user)
    friend_user.sort(key=lambda x: x.user.first_name, reverse=False)
    new_mes_user = Message.new_user_message(request.user)

    if request.POST.get('message'):
        message = Message.create(sender=request.user, reciver=user, text=request.POST['message'])
        message.save()

    return render(request, 'musician/chat.html', {'n_req': n_req,
                                                  'friend_user': friend_user,
                                                  'selected_user': user,
                                                  'messages': messages_of_chat,
                                                  'n_mes': n_mes,
                                                  'new_mes_user': new_mes_user})

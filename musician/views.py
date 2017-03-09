from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, render
from django.contrib.auth.models import User
from django.http import HttpResponseRedirect
from django.core.urlresolvers import reverse
from musician_project.forms import UserForm, MusicianProfileForm
from musician.models import MusicianProfile, Friend, Message, Skill, HasSkill, Post


@login_required
def profile(request, user_id):
    user = get_object_or_404(User, pk=user_id)

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)

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

        for post in user.musicianprofile.user_post.all():
            if request.POST.get('del_' + str(post.id)):
                post.delete()
                return HttpResponseRedirect('/musician/'+str(user.id))

            if request.POST.get('comment_' + str(post.id)):
                print(request.POST['comment_' + str(post.id)])

                post.comment_set.create(comment_text=request.POST['comment_' + str(post.id)],
                                        musician_profile=request.user.musicianprofile)

    return render(request, 'musician/profile.html', {'user': user,
                                                     'reciver': reciver,
                                                     'status_friend': status_friend,
                                                     'n_req': n_req,
                                                     'n_mes': n_mes,
                                                     'n_comm': n_comm})


@login_required
def musician_info(request, user_id):
    user = get_object_or_404(User, pk=user_id)

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)

    mpf = MusicianProfileForm(prefix='profile')

    skills = Skill.objects.all()

    status_friend = 0
    reciver = None

    if Friend.get_friendship(request.user, user):
        fs = Friend.get_friendship(request.user, user)
        reciver = fs.reciver
        status_friend = fs.status

    if request.method == 'POST':

        mpf = MusicianProfileForm(request.POST, request.FILES, prefix='profile')

        # Friendscip post
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

        # Personal Info edit post
        if "first_name" in request.POST:
            user.first_name = request.POST['first_name']
            user.save()
        if "last_name" in request.POST:
            user.last_name = request.POST['last_name']
            user.save()
        if "city" in request.POST:
            user.musicianprofile.city = request.POST['city']
            user.musicianprofile.save()
        if "bio" in request.POST:
            user.musicianprofile.bio = request.POST['bio']
            user.musicianprofile.save()

        # skill list post
        if request.POST.getlist('check_skill'):
            checked_skills = request.POST.getlist('check_skill')
            for user_skill in user.musicianprofile.skills.all():
                if not(user_skill.name_skill in checked_skills):
                    hs = HasSkill.objects.all().filter(musicianprofile=user.musicianprofile, skill=user_skill).__getitem__(0)
                    hs.delete()
            for skill in skills:
                if skill.name_skill in checked_skills:
                    HasSkill.create(musicianprofile=user.musicianprofile, skill=skill)

        if mpf.is_valid():
            if mpf.cleaned_data['gender']:
                user.musicianprofile.gender = mpf.cleaned_data['gender']
                user.musicianprofile.save()
            if mpf.cleaned_data['country']:
                user.musicianprofile.country = mpf.cleaned_data['country']
                user.musicianprofile.save()
            if mpf.cleaned_data['data']:
                print(mpf.cleaned_data['data'])
                user.musicianprofile.data = mpf.cleaned_data['data']
                user.musicianprofile.save()
            # General Info edit post
            if mpf.cleaned_data['phone_number']:
                user.musicianprofile.phone_number = mpf.cleaned_data['phone_number']
                user.musicianprofile.save()

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
                                                           'reciver': reciver,
                                                           'user_has_skill': user_has_skill,
                                                           'musicianprofileform': mpf,
                                                           'skills': skills,
                                                           'status_friend': status_friend,
                                                           'n_req': n_req,
                                                           'n_mes': n_mes,
                                                           'n_comm': n_comm})


@login_required
def musician_friends(request, user_id):
    user = get_object_or_404(User, pk=user_id)

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)

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
                                                              'reciver': reciver,
                                                              'friend_user': friend_user,
                                                              'status_friend': status_friend,
                                                              'n_req': n_req,
                                                              'n_mes': n_mes,
                                                              'n_comm': n_comm})


@login_required
def messages(request):

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)

    friend_user = Friend.get_user_friends(request.user)
    friend_user.sort(key=lambda x: x.user.first_name, reverse=False)

    new_mes_user = Message.new_user_message(request.user)
    return render(request, 'musician/messages.html', {'n_req': n_req,
                                                      'n_mes': n_mes,
                                                      'n_comm': n_comm,
                                                      'friend_user': friend_user,
                                                      'new_mes_user': new_mes_user
                                                      })


@login_required
def chat(request, user_id):
    user = get_object_or_404(User, pk=user_id)

    n_req = Friend.n_req_friendship(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)

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
                                                  'new_mes_user': new_mes_user,
                                                  'n_comm': n_comm})

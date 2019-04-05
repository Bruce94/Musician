from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, render
from django.contrib.auth.models import User
from django.http import HttpResponseRedirect
from django.core.urlresolvers import reverse
from musician_project.forms import UserForm, MusicianProfileForm
from musician.models import MusicianProfile, Friend, Message, Skill, HasSkill, Post, Preference
from django.http import JsonResponse
import json
import _thread


@login_required
def profile(request, user_id):
    user = get_object_or_404(User, pk=user_id)

    n_req = Friend.n_req_friendship(request.user)
    user_distance = request.user.musicianprofile.musician_distance(user.musicianprofile)

    voted_posts = Preference.objects.filter(musician_profile=request.user.musicianprofile)

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
            reciver = user
        elif "cancel-request" in request.POST:
            fs.delete()
            status_friend = 0
            _thread.start_new_thread(update_suggestions, (request, user_id))
        elif "accept-friend" in request.POST:
            fs.status = 2
            fs.save()
            status_friend = 2
            _thread.start_new_thread(update_suggestions, (request, user_id))
        elif "send-message" in request.POST:
            return HttpResponseRedirect('/musician/messages/'+str(user.id))

        for post in user.musicianprofile.user_post.all():
            if request.POST.get('del_' + str(post.id)):
                post.delete()
                return HttpResponseRedirect('/musician/'+str(user.id))

            if request.POST.get('comment_' + str(post.id)):

                post.comment_set.create(comment_text=request.POST['comment_' + str(post.id)],
                                        musician_profile=request.user.musicianprofile,
                                        seen=(True if post.musician_profile == request.user.musicianprofile else False))
                comment = post.comment_set.filter(comment_text=request.POST['comment_' + str(post.id)],
                                               musician_profile=request.user.musicianprofile)[0]
                comment.checkForTagsInComment()

    return render(request, 'musician/profile.html', {'user': user,
                                                     'reciver': reciver,
                                                     'status_friend': status_friend,
                                                     'n_req': n_req,
                                                     'user_distance': user_distance,
                                                     'voted_posts': voted_posts
                                                     })


@login_required
def musician_info(request, user_id):
    user = get_object_or_404(User, pk=user_id)

    n_req = Friend.n_req_friendship(request.user)
    user_distance = request.user.musicianprofile.musician_distance(user.musicianprofile)

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
                                                           'user_distance': user_distance})


@login_required
def musician_friends(request, user_id):
    user = get_object_or_404(User, pk=user_id)

    n_req = Friend.n_req_friendship(request.user)
    user_distance = request.user.musicianprofile.musician_distance(user.musicianprofile)

    status_friend = 0
    reciver = None
    if Friend.get_friendship(request.user, user):
        fs = Friend.get_friendship(request.user, user)
        reciver = fs.reciver
        status_friend = fs.status

    friend_user = Friend.get_user_friends(user)
    fu = {}
    for f in friend_user:
        fu[f] = f.get_n_common_friend(request.user)
    fu = sorted(fu.items(), key=lambda x: x[1], reverse=True)
    return render(request, 'musician/musician_friends.html', {'user': user,
                                                              'reciver': reciver,
                                                              'fu': fu,
                                                              'status_friend': status_friend,
                                                              'n_req': n_req,
                                                              'user_distance': user_distance
                                                              })


@login_required
def messages(request):
    n_req = Friend.n_req_friendship(request.user)

    friend_user = Friend.get_user_friends(request.user)
    friend_user.sort(key=lambda x: x.user.first_name, reverse=False)

    new_mes_user = Message.new_user_message(request.user)

    return render(request, 'musician/messages.html', {'n_req': n_req,
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

    friend_user = Friend.get_user_friends(request.user)
    friend_user.sort(key=lambda x: x.user.first_name, reverse=False)
    new_mes_user = Message.new_user_message(request.user)

    return render(request, 'musician/chat.html', {'n_req': n_req,
                                                  'friend_user': friend_user,
                                                  'selected_user': user,
                                                  'messages': messages_of_chat,
                                                  'new_mes_user': new_mes_user,
                                                })


@login_required
def chat_post(request, user_id):
    user = get_object_or_404(User, pk=user_id)

    if request.POST.get('message'):
        message = Message.create(sender=request.user, reciver=user, text=request.POST['message'])
        message.save()
    sender = '{} {}'.format(request.user.first_name, request.user.last_name)
    icon = request.user.musicianprofile.img.url
    return JsonResponse({'usr_id': request.user.id, 'sender': sender, 'icon': icon})


@login_required
def chat_get(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    messages_of_chat = Message.messages_of_chat(request.user, user)
    messages = []
    for moc in messages_of_chat:
        if not moc.seen and moc.reciver_message == request.user:
            moc.seen = True
            moc.save()
        mes = {}
        mes['sender'] = moc.sender_message.id
        mes['receiver'] = moc.reciver_message.id
        mes['text'] = moc.text
        mes['data_request'] = str(moc.data_request.strftime("%Y-%m-%d %H:%M"))
        messages.append(mes)
    response = {'messages': messages}
    r = json.dumps(response, False)
    return JsonResponse(r, safe=False)


@login_required
def new_msg(request):
    nm_users = []
    for usr in Message.new_user_message(request.user):
        data = {}
        data['id'] = usr.user.id
        data['img_url'] = usr.img.url
        data['first_name'] = usr.user.first_name
        data['last_name'] = usr.user.last_name
        data['username'] = usr.user.username
        nm_users.append(data)
    response = {'nm_users': nm_users}
    r = json.dumps(response, False)
    return JsonResponse(r, safe=False)


@login_required
def num_new_msg(request):
    n_mes = Message.n_new_messages(request.user)
    response = {'n_mes': n_mes}
    r = json.dumps(response, False)
    return JsonResponse(r, safe=False)


@login_required
def num_notif(request):
    print("siamo dentro num_notif() con: " + str(request.user))
    n_votes = Preference.n_new_votes(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)
    response = {'n_votes': n_votes,'n_comm': n_comm}
    r = json.dumps(response, False)
    return JsonResponse(r, safe=False)


@login_required
def fs_request(request):
    n_fs = Friend.n_req_friendship(request.user)
    response = {'n_fs': n_fs}
    r = json.dumps(response, False)
    return JsonResponse(r, safe=False)


def remove_friend_from_suggested(us1, us2id):
    strid2 = '{}'.format(us2id)

    suggested = us1.suggested_friend.split(',')
    if strid2 in suggested:
        suggested.remove(strid2)
        str_suggested = ''
        for s in suggested:
            str_suggested = str_suggested+'{},'.format(s)
        us1.suggested_friend = str_suggested[:-1]
        us1.save()


def update_suggestions(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    remove_friend_from_suggested(request.user.musicianprofile, user.id)
    remove_friend_from_suggested(user.musicianprofile, request.user.id)
    ul_friends = set(Friend.get_user_friends(request.user))
    us_friends = set(Friend.get_user_friends(user))
    users = ul_friends | us_friends | set([user.musicianprofile]) | set([request.user.musicianprofile])
    for u in users:
        u.update_suggested_musician()
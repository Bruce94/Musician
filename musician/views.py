from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, render
from django.contrib.auth.models import User
from django.http import HttpResponseRedirect
from django.core.urlresolvers import reverse
from musician.models import MusicianProfile, Friend, Message
from django.db.models import Q


@login_required
def profile(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    profile = get_object_or_404(MusicianProfile, user=user_id)
    logguser = request.user

    n_req = len(Friend.objects.all().filter(Q(reciver__username=request.user.username) & Q(seen=False) &
                                            Q(status=1)))
    n_mes = len(Message.objects.all().filter(Q(reciver_message__username=request.user.username) & Q(seen=False)))

    #creare un metodo da richiamare per evitare di replicare il codice!!
    status_friend = 0
    f = Friend.objects.all()
    reciver = None

    if(f.filter(Q(sender__username=logguser.username) &
                Q(reciver__username=user.username))):
        fs = list(f.filter(Q(sender__username=logguser.username) &
                           Q(reciver__username=user.username))).__getitem__(0)
        status_friend = fs.status
        reciver = fs.reciver

    if(f.filter(Q(sender__username=user.username) &
                Q(reciver__username=logguser.username))):
        fs = list(f.filter(Q(sender__username=user.username) &
                           Q(reciver__username=logguser.username))).__getitem__(0)
        status_friend = fs.status
        reciver = fs.reciver

    if request.method == 'POST':
        if "add-friend" in request.POST:
            friend = Friend.create(sender=logguser, reciver=user)
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
                                                     'logguser': logguser,
                                                     'reciver': reciver,
                                                     'status_friend': status_friend,
                                                     'n_req': n_req,
                                                     'n_mes': n_mes})


@login_required
def musician_info(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    profile = get_object_or_404(MusicianProfile, user=user_id)

    n_req = len(Friend.objects.all().filter(Q(reciver__username=request.user.username) & Q(seen=False) &
                                            Q(status=1)))

    n_mes = len(Message.objects.all().filter(Q(reciver_message__username=request.user.username) & Q(seen=False)))

    if request.GET.get('first_name'):
        user.first_name = request.GET.get('first_name')
        user.save()

    if request.GET.get('first_name'):
        user.last_name = request.GET.get('last_name')
        user.save()

    if request.GET.get('email'):
        user.email = request.GET.get('email')
        user.save()

    logguser = request.user
    status_friend = 0
    f = Friend.objects.all()
    reciver = None

    if(f.filter(Q(sender__username=logguser.username) &
                Q(reciver__username=user.username))):
        fs = list(f.filter(Q(sender__username=logguser.username) &
                           Q(reciver__username=user.username))).__getitem__(0)
        status_friend = fs.status
        reciver = fs.reciver

    if(f.filter(Q(sender__username__icontains=user.username) &
                Q(reciver__username__icontains=logguser.username))):
        fs = list(f.filter(Q(sender__username=user.username) &
                           Q(reciver__username=logguser.username))).__getitem__(0)
        status_friend = fs.status
        reciver = fs.reciver

    if request.method == 'POST':
        if "add-friend" in request.POST:
            friend = Friend.create(sender=logguser, reciver=user)
            friend.save()
            status_friend = 1
        elif "cancel-request" in request.POST:
            fs.delete()
            status_friend = 0
        elif "accept-friend" in request.POST:
            fs.status = 2
            fs.save()
            status_friend = 2

    return render(request, 'musician/musician_info.html', {'user': user,
                                                           'profile': profile,
                                                           'logguser': logguser,
                                                           'reciver': reciver,
                                                           'status_friend': status_friend,
                                                           'n_req': n_req,
                                                           'n_mes': n_mes})


@login_required
def musician_friends(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    profile = get_object_or_404(MusicianProfile, user=user_id)
    logguser = request.user
    n_req = len(Friend.objects.all().filter(Q(reciver__username=request.user.username) & Q(seen=False) &
                                            Q(status=1)))
    n_mes = len(Message.objects.all().filter(Q(reciver_message__username=request.user.username) & Q(seen=False)))

    musicians = MusicianProfile.objects.all()

    status_friend = 0
    f = Friend.objects.all()
    reciver = None
    friend_user = []

    if(f.filter(Q(sender__username=logguser.username) &
                Q(reciver__username=user.username))):
        fs = list(f.filter(Q(sender__username=logguser.username) &
                           Q(reciver__username=user.username))).__getitem__(0)
        status_friend = fs.status
        reciver = fs.reciver

    if(f.filter(Q(sender__username=user.username) &
                Q(reciver__username=logguser.username))):
        fs = list(f.filter(Q(sender__username=user.username) &
                           Q(reciver__username=logguser.username))).__getitem__(0)
        status_friend = fs.status
        reciver = fs.reciver

    friendships = Friend.objects.all().filter((Q(sender__username=user.username) |
                                               Q(reciver__username=user.username)) &
                                              Q(status=2))
    if friendships:
        for friendship in friendships:
            if friendship.reciver.id == user.id:
                friend_user += list(musicians.filter(Q(user__id=friendship.sender.id)))
            elif friendship.sender.id == user.id:
                friend_user += list(musicians.filter(Q(user__id=friendship.reciver.id)))

    if request.method == 'POST':
        if "add-friend" in request.POST:
            friend = Friend.create(sender=logguser, reciver=user)
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
                                                              'logguser': logguser,
                                                              'reciver': reciver,
                                                              'friend_user': friend_user,
                                                              'status_friend': status_friend,
                                                              'n_req': n_req,
                                                              'n_mes': n_mes})


@login_required
def messages(request):

    n_req = len(Friend.objects.all().filter(Q(reciver__username=request.user.username) & Q(seen=False) &
                                            Q(status=1)))
    n_mes = len(Message.objects.all().filter(Q(reciver_message__username=request.user.username) & Q(seen=False)))

    friendships = Friend.objects.all().filter((Q(sender__username=request.user.username) |
                                               Q(reciver__username=request.user.username)) &
                                              Q(status=2))
    musicians = MusicianProfile.objects.all()

    new_mes = Message.objects.all().filter(seen=False, reciver_message__username=request.user.username)

    friend_user = []
    new_mes_user = []

    if friendships:
        for friendship in friendships:
            if friendship.reciver.id == request.user.id:
                friend_user += list(musicians.filter(Q(user__id=friendship.sender.id)))
            elif friendship.sender.id == request.user.id:
                friend_user += list(musicians.filter(Q(user__id=friendship.reciver.id)))

    friend_user.sort(key=lambda x: x.user.first_name, reverse=False)

    if new_mes:
        for mes in new_mes:
            if not (MusicianProfile.objects.all().filter(
                    Q(user__username=mes.sender_message.username)).__getitem__(0) in new_mes_user):
                new_mes_user += list(
                    MusicianProfile.objects.all().filter(Q(user__username=mes.sender_message.username)))

    return render(request, 'musician/messages.html', {'n_req': n_req,
                                                      'n_mes': n_mes,
                                                      'friend_user': friend_user,
                                                      'new_mes_user': new_mes_user
                                                      })


@login_required
def chat(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    logguser = request.user

    n_req = len(Friend.objects.all().filter(Q(reciver__username=request.user.username) & Q(seen=False) &
                                            Q(status=1)))

    friendships = Friend.objects.all().filter((Q(sender__username=request.user.username) |
                                               Q(reciver__username=request.user.username)) &
                                              Q(status=2))
    musicians = MusicianProfile.objects.all()
    new_mes = Message.objects.all().filter(seen=False, reciver_message__username=request.user.username)

    messages_filtered = Message.objects.all().filter((Q(reciver_message__username=logguser.username) &
                                                      Q(sender_message__username=user.username)) |
                                                     (Q(reciver_message__username=user.username) &
                                                      Q(sender_message__username=logguser.username))).order_by('data_request')
    for message in messages_filtered:
        if message.reciver_message.id == logguser.id:
            message.seen = True
            message.save()

    n_mes = len(Message.objects.all().filter(Q(reciver_message__username=request.user.username) & Q(seen=False)))

    friend_user = []
    new_mes_user = []

    if friendships:
        for friendship in friendships:
            if friendship.reciver.id == request.user.id:
                friend_user += list(musicians.filter(Q(user__id=friendship.sender.id)))
            elif friendship.sender.id == request.user.id:
                friend_user += list(musicians.filter(Q(user__id=friendship.reciver.id)))

    friend_user.sort(key=lambda x: x.user.first_name, reverse=False)

    if new_mes:
        for mes in new_mes:
            if not (MusicianProfile.objects.all().filter(
                    Q(user__username=mes.sender_message.username)).__getitem__(0) in new_mes_user):
                new_mes_user += list(
                    MusicianProfile.objects.all().filter(Q(user__username=mes.sender_message.username)))

    if request.POST.get('message'):
        message = Message.create(sender=logguser, reciver=user, text=request.POST['message'])
        message.save()

    return render(request, 'musician/chat.html', {'n_req': n_req,
                                                  'friend_user': friend_user,
                                                  'selected_user': user,
                                                  'messages': messages_filtered,
                                                  'n_mes': n_mes,
                                                  'new_mes_user': new_mes_user})

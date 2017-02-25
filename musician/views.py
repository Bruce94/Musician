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

    n_req = len(Friend.objects.all().filter(Q(reciver__username__icontains=request.user.username) &
                                            Q(status__icontains=1)))


    #creare un metodo da richiamare per evitare di replicare il codice!!
    status_friend = 0
    f = Friend.objects.all()
    reciver = None

    if(f.filter(Q(sender__username__icontains=logguser.username) &
                Q(reciver__username__icontains=user.username))):
        fs = list(f.filter(Q(sender__username__icontains=logguser.username) &
                           Q(reciver__username__icontains=user.username))).__getitem__(0)
        status_friend = fs.status
        reciver = fs.reciver

    if(f.filter(Q(sender__username__icontains=user.username) &
                Q(reciver__username__icontains=logguser.username))):
        fs = list(f.filter(Q(sender__username__icontains=user.username) &
                           Q(reciver__username__icontains=logguser.username))).__getitem__(0)
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

    return render(request, 'musician/profile.html', {'user': user,
                                                     'profile': profile,
                                                     'logguser': logguser,
                                                     'reciver': reciver,
                                                     'status_friend': status_friend,
                                                     'n_req': n_req
                                                     })


@login_required
def musician_info(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    profile = get_object_or_404(MusicianProfile, user=user_id)

    n_req = len(Friend.objects.all().filter(Q(reciver__username__icontains=request.user.username) &
                                            Q(status__icontains=1)))

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

    if(f.filter(Q(sender__username__icontains=logguser.username) &
                Q(reciver__username__icontains=user.username))):
        fs = list(f.filter(Q(sender__username__icontains=logguser.username) &
                           Q(reciver__username__icontains=user.username))).__getitem__(0)
        status_friend = fs.status
        reciver = fs.reciver

    if(f.filter(Q(sender__username__icontains=user.username) &
                Q(reciver__username__icontains=logguser.username))):
        fs = list(f.filter(Q(sender__username__icontains=user.username) &
                           Q(reciver__username__icontains=logguser.username))).__getitem__(0)
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
                                                           'n_req': n_req})


@login_required
def musician_friends(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    profile = get_object_or_404(MusicianProfile, user=user_id)
    logguser = request.user
    n_req = len(Friend.objects.all().filter(Q(reciver__username__icontains=request.user.username) &
                                            Q(status__icontains=1)))

    musicians = MusicianProfile.objects.all()

    status_friend = 0
    f = Friend.objects.all()
    reciver = None
    friend_user = []

    if(f.filter(Q(sender__username__icontains=logguser.username) &
                Q(reciver__username__icontains=user.username))):
        fs = list(f.filter(Q(sender__username__icontains=logguser.username) &
                           Q(reciver__username__icontains=user.username))).__getitem__(0)
        status_friend = fs.status
        reciver = fs.reciver

    if(f.filter(Q(sender__username__icontains=user.username) &
                Q(reciver__username__icontains=logguser.username))):
        fs = list(f.filter(Q(sender__username__icontains=user.username) &
                           Q(reciver__username__icontains=logguser.username))).__getitem__(0)
        status_friend = fs.status
        reciver = fs.reciver

    friendships = Friend.objects.all().filter((Q(sender__username__icontains=user.username) |
                                               Q(reciver__username__icontains=user.username)) &
                                              Q(status__icontains=2))
    if friendships:
        for friendship in friendships:
            if friendship.reciver.id == user.id:
                friend_user += list(musicians.filter(Q(user__id__icontains=friendship.sender.id)))
            elif friendship.sender.id == user.id:
                friend_user += list(musicians.filter(Q(user__id__icontains=friendship.reciver.id)))

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
                                                              'n_req': n_req})


@login_required
def messages(request):

    n_req = len(Friend.objects.all().filter(Q(reciver__username__icontains=request.user.username) &
                                            Q(status__icontains=1)))
    friendships = Friend.objects.all().filter((Q(sender__username__icontains=request.user.username) |
                                               Q(reciver__username__icontains=request.user.username)) &
                                              Q(status__icontains=2))
    musicians = MusicianProfile.objects.all()

    friend_user = []
    if friendships:
        for friendship in friendships:
            if friendship.reciver.id == request.user.id:
                friend_user += list(musicians.filter(Q(user__id__icontains=friendship.sender.id)))
            elif friendship.sender.id == request.user.id:
                friend_user += list(musicians.filter(Q(user__id__icontains=friendship.reciver.id)))

    return render(request, 'musician/messages.html', {'n_req': n_req,
                                                      'friend_user': friend_user})


@login_required
def chat(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    logguser = request.user

    n_req = len(Friend.objects.all().filter(Q(reciver__username__icontains=request.user.username) &
                                            Q(status__icontains=1)))
    friendships = Friend.objects.all().filter((Q(sender__username__icontains=request.user.username) |
                                               Q(reciver__username__icontains=request.user.username)) &
                                              Q(status__icontains=2))
    musicians = MusicianProfile.objects.all()

    friend_user = []
    if friendships:
        for friendship in friendships:
            if friendship.reciver.id == request.user.id:
                friend_user += list(musicians.filter(Q(user__id__icontains=friendship.sender.id)))
            elif friendship.sender.id == request.user.id:
                friend_user += list(musicians.filter(Q(user__id__icontains=friendship.reciver.id)))

    if request.POST.get('message'):
        message = Message.create(sender=logguser, reciver=user, text=request.POST['message'])
        message.save()

    return render(request, 'musician/chat.html', {'n_req': n_req,
                                                  'friend_user': friend_user,
                                                  'selected_user': user})

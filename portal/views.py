from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.db.models import Q
from musician.models import MusicianProfile, Friend
from django.template import RequestContext


@login_required
def portal_welcome(request):
    user = get_object_or_404(User, pk=request.user.id)
    profile = get_object_or_404(MusicianProfile, user=request.user.id)
    n_req = len(Friend.objects.all().filter(Q(reciver__username__icontains=request.user.username) &
                                            Q(status__icontains=1)))

    return render(request, 'portal/home.html', {'user': user,
                                                'profile': profile,
                                                'n_req': n_req})


@login_required
def search_musician(request):

    query = request.GET.get('search_musician') or None
    profile_list = []
    qs = MusicianProfile.objects.all()

    n_req = len(Friend.objects.all().filter(Q(reciver__username__icontains=request.user.username) &
                                            Q(status__icontains=1)))

    if query:
        for q in query.split():
            if list(qs.filter(Q(user__first_name__icontains=q) | Q(user__last_name__icontains=q) |
                              Q(user__username__icontains=q))):
                if(not (list(qs.filter(Q(user__first_name__icontains=q) |
                                       Q(user__last_name__icontains=q) |
                                       Q(user__username__icontains=q))).__getitem__(0) in profile_list)):

                    profile_list += list(qs.filter(Q(user__first_name__icontains=q) |
                                                   Q(user__last_name__icontains=q) |
                                                   Q(user__username__icontains=q)))

    return render(request, 'portal/search_musician.html', {'profile_list': profile_list,
                                                           'query': query,
                                                           'n_req': n_req})


@login_required
def friendship_request(request):

    friendships = Friend.objects.all().filter(Q(reciver__username__icontains=request.user.username) &
                                              Q(status__icontains=1))

    n_req = len(Friend.objects.all().filter(Q(reciver__username__icontains=request.user.username) &
                                            Q(status__icontains=1)))
    result = False
    musicians = MusicianProfile.objects.all()
    profile_list = []

    if friendships:
        for friendship in friendships:
            if musicians.filter(Q(user__id__icontains=friendship.sender.id)):
                profile_list += list(musicians.filter(Q(user__id__icontains=friendship.sender.id)))
                result = True
    return render(request, 'portal/friendship_request.html', {'profile_list': profile_list,
                                                              'result': result,
                                                              'n_req': n_req})

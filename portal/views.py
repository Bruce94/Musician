from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.db.models import Q
from django.http import HttpResponseRedirect

from musician.models import MusicianProfile, Friend, Message, Skill, HasSkill, Post, Comment
from musician_project.forms import UserForm, MusicianProfileForm
from itertools import chain
from django.template import RequestContext


@login_required
def portal_welcome(request):
    user = get_object_or_404(User, pk=request.user.id)
    n_req = Friend.n_req_friendship(request.user)
    n_mes = len(Message.objects.all().filter(Q(reciver_message__username=request.user.username) & Q(seen=False)))
    n_comm = Post.n_new_comments(request.user.musicianprofile)
    n_first_neigh = len(Friend.get_user_friends(request.user))

    user_friends = Friend.get_user_friends(user)
    home_posts = []
    for p in Post.objects.all():
        if (p.musician_profile in user_friends) or p.musician_profile == user.musicianprofile:
            home_posts += [p]

        if request.POST.get('comment_'+str(p.id)):
            print(request.POST['comment_'+str(p.id)])
            p.comment_set.create(comment_text=request.POST['comment_'+str(p.id)],
                                 musician_profile=request.user.musicianprofile,
                                 seen=(True if p.musician_profile == request.user.musicianprofile else False))

    if request.POST.get('post'):
        user.musicianprofile.user_post.create(post_text=request.POST['post'])

    for p in user.musicianprofile.user_post.all():
        if request.POST.get('del_'+str(p.id)):
            p.delete()
            return HttpResponseRedirect('/portal/')

    return render(request, 'portal/home.html', {'user': user,
                                                'home_posts': home_posts,
                                                'n_req': n_req,
                                                'n_mes': n_mes,
                                                'n_comm': n_comm,
                                                'n_first_neigh': n_first_neigh
                                                })


@login_required
def search_musician(request):

    profile_list = []
    checked_skills = []

    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)

    mpf = MusicianProfileForm(prefix='profile')

    skills = Skill.objects.all()

    if request.method == 'GET':
        mpf = MusicianProfileForm(request.GET, request.FILES, prefix='profile')

        query = request.GET.get('search_musician')
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
            elif not query:
                profile_list = profiles

        if mpf.is_valid():
            if mpf.cleaned_data['country']:
                profiles = set(MusicianProfile.get_musician(country=mpf.cleaned_data['country']))
                if profile_list:
                    profile_list = profiles.intersection(profile_list)
                elif not request.GET.getlist('check_skill'):
                    profile_list = profiles

            if mpf.cleaned_data['gender']:
                profiles = set(MusicianProfile.get_musician(gender=mpf.cleaned_data['gender']))
                if profile_list:
                    profile_list = profiles.intersection(profile_list)
                elif not mpf.cleaned_data['country'] and not request.GET.getlist('check_skill'):
                    profile_list = profiles

    return render(request, 'portal/search_musician.html', {'profile_list': profile_list,
                                                           'query': query,
                                                           'skills': skills,
                                                           'checked_skills': checked_skills,
                                                           'musicianprofileform': mpf,
                                                           'n_req': n_req,
                                                           'n_mes': n_mes,
                                                           'n_comm': n_comm})


@login_required
def friendship_request(request):

    friendships = Friend.get_pending_request(request.user)
    n_mes = Message.n_new_messages(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)

    musicians = MusicianProfile.objects.all()
    profile_list = []

    if friendships:
        for friendship in friendships:
            if musicians.filter(Q(user__username=friendship.sender.username)):
                profile_list += list(musicians.filter(Q(user__username=friendship.sender.username)))
                friendship.seen = True
                friendship.save()

    n_req = Friend.n_req_friendship(request.user)
    return render(request, 'portal/friendship_request.html', {'profile_list': profile_list,
                                                              'n_req': n_req,
                                                              'n_mes': n_mes,
                                                              'n_comm': n_comm})


@login_required
def comment_notifications(request):
    n_mes = Message.n_new_messages(request.user)
    n_req = Friend.n_req_friendship(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)

    new_comments = Comment.objects.filter(post__musician_profile=request.user.musicianprofile, seen=False)

    return render(request, 'portal/comment_notifications.html', {'n_req': n_req,
                                                                 'n_mes': n_mes,
                                                                 'n_comm': n_comm,
                                                                 'new_comments': new_comments})


@login_required
def post(request, post_id):
    p = get_object_or_404(Post, pk=post_id)

    n_mes = Message.n_new_messages(request.user)
    n_req = Friend.n_req_friendship(request.user)

    for comment in p.comment_set.all():
        comment.seen = True
        comment.save()

    n_comm = Post.n_new_comments(request.user.musicianprofile)

    if request.POST.get('comment_' + str(p.id)):
        print(request.POST['comment_' + str(p.id)])
        p.comment_set.create(comment_text=request.POST['comment_' + str(p.id)],
                             musician_profile=request.user.musicianprofile,
                             seen=(True if p.musician_profile == request.user.musicianprofile else False))

    return render(request, 'portal/post.html', {'n_req': n_req,
                                                'n_mes': n_mes,
                                                'n_comm': n_comm,
                                                'p': p})

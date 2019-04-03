from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.db.models import Q
from django.http import HttpResponseRedirect

from musician.models import MusicianProfile, Friend, Message, Skill, HasSkill, Post, Comment, Tag, Preference
from musician_project.forms import MusicianProfileForm
from itertools import chain
from django.http import JsonResponse
import json


@login_required
def portal_welcome(request):
    user = get_object_or_404(User, pk=request.user.id)
    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)
    n_first_neigh = len(Friend.get_user_friends(request.user))

    user_friends = Friend.get_user_friends(user)
    home_posts = Post.objects.filter(Q(musician_profile__in=user_friends) | Q(musician_profile=user.musicianprofile))

    voted_posts = Preference.objects.filter(musician_profile=request.user.musicianprofile)

    for p in home_posts:
        if request.POST.get('comment_' + str(p.id)):
            p.comment_set.create(comment_text=request.POST['comment_' + str(p.id)],
                                 musician_profile=request.user.musicianprofile,
                                 seen=(True if p.musician_profile == request.user.musicianprofile else False))

            comment = p.comment_set.filter(comment_text=request.POST['comment_' + str(p.id)],
                                           musician_profile=request.user.musicianprofile)[0]
            comment.checkForTagsInComment()

    for p in user.musicianprofile.user_post.all():
        if request.POST.get('del_' + str(p.id)):
            p.delete()
            return HttpResponseRedirect('/portal/')

    return render(request, 'portal/home.html', {'user': user,
                                                'home_posts': home_posts,
                                                'n_req': n_req,
                                                'n_mes': n_mes,
                                                'n_comm': n_comm,
                                                'n_first_neigh': n_first_neigh,
                                                'voted_posts': voted_posts,
                                                })


@login_required
def search_musician(request):
    profile_list = []
    checked_skills = []
    query = ""
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
            # piu scalabile
            if query:
                for skill in checked_skills:
                    for single_profile in profile_list:
                        has_skills = HasSkill.objects.filter(
                            skill__name_skill=skill,
                            musicianprofile=single_profile)
                        if has_skills:
                            profiles += [single_profile]
            else:
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

        comment = p.comment_set.filter(comment_text=request.POST['comment_' + str(p.id)],
                                       musician_profile=request.user.musicianprofile)[0]
        comment.checkForTagsInComment()

    return render(request, 'portal/post.html', {'n_req': n_req,
                                                'n_mes': n_mes,
                                                'n_comm': n_comm,
                                                'p': p})


@login_required
def newpost_post(request, user_id):
    user = get_object_or_404(User, pk=user_id)

    if request.POST.get('message'):
        user.musicianprofile.user_post.create(post_text=request.POST['message'])
        post = user.musicianprofile.user_post.filter(post_text=request.POST['message'])[0]

        post.checkForTagsInPost()

    return JsonResponse({'usr_id': user.id})


@login_required
def newpost_get(request):
    user_friends = Friend.get_user_friends(request.user)
    home_post = Post.objects.filter(
        Q(musician_profile__in=user_friends) | Q(musician_profile=request.user.musicianprofile)).__getitem__(0)

    post_data = {}

    post_data['request_user_img_url'] = request.user.musicianprofile.img.url
    post_data['user_image_url'] = home_post.musician_profile.img.url
    post_data['user_firstname'] = home_post.musician_profile.user.first_name
    post_data['user_lastname'] = home_post.musician_profile.user.last_name
    post_data['user_post_id'] = home_post.musician_profile.user.id
    post_data['post_id'] = home_post.id
    post_data['post_n_like'] = home_post.n_like
    post_data['post_n_dislike'] = home_post.n_dislike
    post_data['text'] = home_post.post_text
    post_data['pub_date'] = str(home_post.pub_date.strftime("%Y-%m-%d %H:%M"))
    post_data['comm'] = []

    for comm in home_post.comment_set.all():
        comment_data = {}
        comment_data['user_id'] = comm.musician_profile.user.id
        comment_data['user_firstname'] = comm.musician_profile.user.first_name
        comment_data['user_lastname'] = comm.musician_profile.user.last_name
        comment_data['user_image_url'] = comm.musician_profile.img.url
        comment_data['pub_date'] = str(comm.pub_date.strftime("%Y-%m-%d %H:%M"))
        comment_data['text'] = comm.comment_text
        post_data['comm'].append(comment_data)

    response = {'home_posts': post_data}
    r = json.dumps(response, False)
    return JsonResponse(r, safe=False)


@login_required
def tag_post(request, tag_text):
    posts = Tag.posts_and_comments_with_tag(tag_text)

    user = get_object_or_404(User, pk=request.user.id)
    n_req = Friend.n_req_friendship(request.user)
    n_mes = Message.n_new_messages(request.user)
    n_comm = Post.n_new_comments(request.user.musicianprofile)
    n_first_neigh = len(Friend.get_user_friends(request.user))

    user_friends = Friend.get_user_friends(user)

    for p in posts:
        if request.POST.get('comment_' + str(p.id)):
            p.comment_set.create(comment_text=request.POST['comment_' + str(p.id)],
                                 musician_profile=request.user.musicianprofile,
                                 seen=(True if p.musician_profile == request.user.musicianprofile else False))

            comment = p.comment_set.filter(comment_text=request.POST['comment_' + str(p.id)],
                                           musician_profile=request.user.musicianprofile)[0]
            comment.checkForTagsInComment()

    return render(request, 'portal/tagged_post.html', {'user': user,
                                                       'home_posts': posts,
                                                       'n_req': n_req,
                                                       'n_mes': n_mes,
                                                       'n_comm': n_comm,
                                                       'n_first_neigh': n_first_neigh,
                                                       'tag_text': tag_text
                                                       })


def set_vote(vote, past_vote, post_id):
    vote = int(vote)
    post = Post.objects.get(pk=post_id)
    # unrated-like / unrated-dislike
    if past_vote == 0 and vote == 1:
        post.n_like += 1
    elif past_vote == 0 and vote == 2:
        post.n_dislike += 1

    # like-like / dislike-dislike
    if past_vote == 1 and vote == 1:
        post.n_like -= 1
    elif past_vote == 2 and vote == 2:
        post.n_dislike -= 1

    # dislike-like / like-dislike
    if past_vote == 2 and vote == 1:
        post.n_like += 1
        post.n_dislike -= 1
    elif past_vote == 1 and vote == 2:
        post.n_like -= 1
        post.n_dislike += 1

    post.save()


@login_required
def like_post_get(request, vote, post_id):
    post = get_object_or_404(Post, pk=post_id)

    if not Preference.exist(request.user, post):
        Preference.create(user=request.user, post=post, vote=vote)
        set_vote(vote, 0, post_id)

        response = {'actual_vote': vote,
                    'nlike': post.get_nlikes(post_id),
                    'ndislike': post.get_ndislikes(post_id)
                    }
    else:
        preference = Preference.get_preference(post, request.user).__getitem__(0)
        set_vote(vote, int(preference.vote), post_id)

        if preference.vote == int(vote):
            preference.vote = 0
        else:
            preference.vote = int(vote)

        preference.save()
        response = {'actual_vote': preference.vote,
                    'nlike': post.get_nlikes(post_id),
                    'ndislike': post.get_ndislikes(post_id)
                    }

    r = json.dumps(response, False)
    return JsonResponse(r, safe=False)
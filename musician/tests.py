from django.test import TestCase
from django.test.client import Client
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.core.urlresolvers import reverse
from musician.models import *


class MusicianProfileViewTests(TestCase):

    # test della view info su un utente  se l'utente non e' loggato
    def test_view_profile_user_not_exist_no_log(self):
        client = Client()
        # mi aspetto un 302
        response = client.get("/musician/345/")
        self.assertEquals(response.status_code, 302)

    # test della view info su un utente  se l'utente e' loggato
    def test_view_profile_user_not_exist_log(self):
        user = User.objects.create_user(username='test', password='test')
        MusicianProfile.objects.create(user=user)
        client = Client()
        client.login(username='test', password='test')
        # mi aspetto un 404 page not found
        response = client.get("/musician/234/")
        self.assertEquals(response.status_code, 404)


class MusicianProfileModelTests(TestCase):

    # test della view info su un utente  se l'utente e' loggato
    def test_musician_distance(self):
        user1 = User.objects.create_user(username='test1', password='test')
        user2 = User.objects.create_user(username='test2', password='test')
        user3 = User.objects.create_user(username='test3', password='test')
        user4 = User.objects.create_user(username='test4', password='test')
        user5 = User.objects.create_user(username='test5', password='test')
        user6 = User.objects.create_user(username='test6', password='test')

        mp1 = MusicianProfile.objects.create(user=user1)
        mp2 = MusicianProfile.objects.create(user=user2)
        mp3 = MusicianProfile.objects.create(user=user3)
        mp4 = MusicianProfile.objects.create(user=user4)
        mp5 = MusicianProfile.objects.create(user=user5)
        mp6 = MusicianProfile.objects.create(user=user6)

        Friend.objects.create(sender=user1, reciver=user2, status=2)
        Friend.objects.create(sender=user2, reciver=user3, status=2)
        Friend.objects.create(sender=user3, reciver=user4, status=2)
        Friend.objects.create(sender=user4, reciver=user5, status=2)

        # grado di vicinanza tra user1 e user2 mi aspetto sia 1
        self.assertEquals(mp1.musician_distance(mp2), 1)

        # grado di vicinanza tra user1 e user3 mi aspetto sia 2
        self.assertEquals(mp1.musician_distance(mp3), 2)
        # grado di vicinanza tra user2 e user3 mi aspetto sia 1
        self.assertEquals(mp2.musician_distance(mp3), 1)

        # grado di vicinanza tra user1 e user4 mi aspetto sia 3
        self.assertEquals(mp1.musician_distance(mp4), 3)
        # grado di vicinanza tra user2 e user4 mi aspetto sia 2
        self.assertEquals(mp2.musician_distance(mp4), 2)
        # grado di vicinanza tra user3 e user4 mi aspetto sia 1
        self.assertEquals(mp3.musician_distance(mp4), 1)

        # grado di vicinanza tra user1 e user5 mi aspetto sia 4
        self.assertEquals(mp1.musician_distance(mp5), 4)
        # grado di vicinanza tra user2 e user5 mi aspetto sia 3
        self.assertEquals(mp2.musician_distance(mp5), 3)
        # grado di vicinanza tra user3 e user5 mi aspetto sia 2
        self.assertEquals(mp3.musician_distance(mp5), 2)
        # grado di vicinanza tra user4 e user5 mi aspetto sia 1
        self.assertEquals(mp4.musician_distance(mp5), 1)

        # grado di vicinanza tra user1 e user6 mi aspetto sia 4 poiche' e' il limite massimo di distanza dei vicini
        self.assertEquals(mp1.musician_distance(mp6), 4)

        # se user1 e user5 effettuano una relazione di amicizia
        Friend.objects.create(sender=user1, reciver=user5, status=2)

        # grado di vicinanza tra user1 e user5 mi aspetto sia 1
        self.assertEquals(mp1.musician_distance(mp5), 1)
        # grado di vicinanza tra user2 e user5 mi aspetto sia 2
        self.assertEquals(mp2.musician_distance(mp5), 2)
        # grado di vicinanza tra user3 e user5 mi aspetto sia 2
        self.assertEquals(mp3.musician_distance(mp5), 2)
        # grado di vicinanza tra user4 e user5 mi aspetto sia 1
        self.assertEquals(mp4.musician_distance(mp5), 1)

        # se user1 effettua una richiesta di amicizia all'utente6
        Friend.objects.create(sender=user1, reciver=user6, status=1)

        # grado di vicinanza tra user1 e user5 mi aspetto sia 4
        self.assertEquals(mp1.musician_distance(mp6), 4)


class MusicianFriendshipRequestViewTests(TestCase):

    def test_friendship_request(self):
        user1 = User.objects.create_user(username='t1', password='test')
        user2 = User.objects.create_user(username='t2', password='test')

        MusicianProfile.objects.create(user=user1)
        MusicianProfile.objects.create(user=user2)

        f = Friend.objects.create(sender=user1, reciver=user2)

        # Mi aspetto l'attriuto 'seen' di default sia False quindi il reciver non ha ancora visto la notifica
        self.assertEquals(f.seen, False)

        client = Client()
        client.login(username='t2', password='test')

        # ora l'utente ha effettuato l'accesso entrera' nella pagina 'friendship_requests'
        client.get('/portal/friendship_requests', follow=True)
        f = Friend.objects.filter(sender=user1, reciver=user2).__getitem__(0)

        # mi aspetto che l'utente abbia visto le richieste e quindi sia stato cambiato il parametro seen
        self.assertEquals(f.seen, True)


class MusicianSkillModelTests(TestCase):

    def test_initialization_of_skills(self):
        Skill.init_skills()

        self.assertNotEqual(Skill.objects.all().count() == 4, True)
        self.assertEquals(Skill.objects.all().count() == 11, True)

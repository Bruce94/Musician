# Musician
Musician is a social nework linkedin style for musicians

#### Set up enviroment
execute the script "init.sh" or follow the coming steps

##### Dependencies
Check your mysql DBMS, then install dependencies; on Debian:
~~~bash
apt install python3.5 python3.5-dev python-pip mysql-server libmysqlclient-dev virtualenv
~~~

##### Prepare DBMS
this project uses mysql, so you have to enable all privileges
to your user.
From terminal log as admin in mysql ($myql --user=root -p --> password: "") and execute this commands
~~~mysql
DROP DATABASE IF EXISTS dbMusician; CREATE DATABASE dbMusician;
CREATE USER 'usermusician'@'localhost' IDENTIFIED BY 'bd344mx';
GRANT ALL PRIVILEGES ON dbMusician.* TO 'usermusician'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON test_dbMusician.* TO 'usermusician'@'localhost' WITH GRANT OPTION;
~~~

##### Virtualenv
For avoid version errors is recommended to use virtualenv
~~~bash
virtualenv -p python3.5 env --system-site-packages
source env/bin/activate
~~~

##### Requirements
Install python requirements for the project
~~~bash
pip3 install -U pip
pip3 install -r requirements.txt
pip3 install django-countries
~~~

##### To upload data
~~~bash
mysql -u usermusician -p --database=dbMusician < backup.sql	(password:bd344mx)
~~~

##### To dump database
~~~bash
sudo mysqldump -u root -p dbMusician > backup.sql
~~~


##### To build database
~~~bash
python3 manage.py makemigrations
python3 manage.py migrate
~~~


##### To init skills
~~~bash
python3 manage.py shell
>>> from musician.models import Skill
>>> Skill.init_skills()
~~~

##### Start server
~~~bash
python3 manage.py runserver 8000
~~~

#### Start nodejs server
~~~bash
cd nodejs
node app.js
~~~

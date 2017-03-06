trap "interrupt" 1 2 3 6 15

interrupt(){
	echo
	echo "Aborting!"
	echo
	stty echo
	exit 1
}

echo
echo "# Musician Scripting"
echo
read -p "Enter to continue"

echo "Database creation"

echo "DROP DATABASE IF EXISTS dbMusician; CREATE DATABASE dbMusician;
\nGRANT USAGE ON *.* TO 'usermusician'@'localhost';
\nDROP USER 'usermusician'@'localhost';
\nCREATE USER 'usermusician'@'localhost' IDENTIFIED BY 'bd344mx';
\nGRANT ALL PRIVILEGES ON dbMusician.* TO 'usermusician'@'localhost'
WITH GRANT OPTION;" > init.sql

echo "Insert Root mysql password"

mysql --user=root -p < init.sql
rm init.sql

echo "Database Successfully created"
echo "Database name: dbMusician;"
†echo "Database user: usermusician, pwd: bd344mx"

echo "install dependencies"
pip install -U pip
pip install -r requirements.txt
pip install django-countries


echo "make migrations"
python manage.py makemigrations
echo "migrate"
python manage.py migrate 

trap "interrupt" 1 2 3 6 15

interrupt(){
	echo
	echo "Aborting!"
	echo
	stty echo
	exit 1
}

echo
echo "# Musician init script..."
echo "please install these dependecies before init:"
echo "  python3.5"
echo "  python3.5-dev"
echo "  mysql-server"
echo "  libmysqlclient-dev"
echo "  virtualenv"
echo
read -p "Enter to continue"

echo "Database creation..."

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
echo "Database user: usermusician, pwd: bd344mx"

echo "create virtualenv"
virtualenv -p python3.5 env --system-site-packages
echo "enter virtualenv"
source env/bin/activate

echo "install pip dependencies"
pip3 install -U pip
pip3 install -r requirements.txt


echo "make migrations"
python3 manage.py makemigrations
echo "migrate"
python3 manage.py migrate 

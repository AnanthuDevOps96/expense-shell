echo Disable default version of NodeJS
dnf module disable nodejs -y

echo Enable version 18 of NodeJS
dnf module enable nodejs:18 -y

echo Installing NodeJs
dnf install nodejs -y

echo Copying Backend service file
cp backend.service /etc/systemd/system/backend.service

echo add a new user
useradd expense

echo remove the pre existing files
rm -rf /app

echo create a new directory
mkdir /app

echo download the backend content file
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app

echo extracting the bakend content file
unzip /tmp/backend.zip

echo install the dependencies
npm install


echo restart the backend
systemctl daemon-reload

echo install mysql client
dnf install mysql -y

echo load schema
mysql -h mysql.adevops96.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

echo enabling and starting device
systemctl enable backend
systemctl restart backend






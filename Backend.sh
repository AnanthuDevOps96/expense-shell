echo -e "\e[31mDisable default version of NodeJS\e[0m"
dnf module disable nodejs -y

echo -e "\e[31mEnable version 18 of NodeJS\e[0m"
dnf module enable nodejs:18 -y

echo -e "\e[31m[31m Installing NodeJs\e[0m"
dnf install nodejs -y

echo -e "\e[31m[31m Copying Backend service file\e[0m"
cp backend.service /etc/systemd/system/backend.service

echo -e "\e[31madd a new user\e[0m"
useradd expense

echo -e "\e[31mremove the pre existing file\e[0m"
rm -rf /app

echo -e "\e[31mcreate a new directory\e[0m"
mkdir /app

echo -e "\e[31mdownload the backend content file\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app

echo -e "\e[31mextracting the bakend content file\e[0m"
unzip /tmp/backend.zip

echo -e "\e[31minstall the dependencies\e[0m"
npm install


echo -e "\e[31mrestart the backend\e[0m"
systemctl daemon-reload

echo -e "\e[31minstall mysql client\e[0m"
dnf install mysql -y

echo -e "\e[31mload schema\e[0m"
mysql -h mysql.adevops96.online -uroot -pExpenseApp@1 < /app/schema/backend.sql

echo -e "\e[31menabling and starting device\e[0m"
systemctl enable backend
systemctl restart backend






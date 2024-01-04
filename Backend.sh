dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y

useradd expense
mkdir /App
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /App
unzip /tmp/backend.zip
cd /App
npm install

cd

cp backend.service /etc/systemd/system/backend.service

cd

systemctl daemon-reload
systemctl enable backend
systemctl restart backend

dnf install mysql -y
mysql -h 172.31.32.119 -uroot -pExpenseApp@1 < /app/schema/backend.sql


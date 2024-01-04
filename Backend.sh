dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y


useradd expense
rm -rf /app
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip
npm install

cd
cp backend.service /etc/systemd/system/backend.service
cd


systemctl daemon-reload

dnf install mysql -y
mysql -h 172.31.32.119 -uroot -pExpenseApp@1 < /app/schema/backend.sql

systemctl enable backend
systemctl restart backend





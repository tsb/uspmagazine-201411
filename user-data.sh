#!/bin/bash -ex
cd /var/tmp
wget https://uec.usp-lab.com/TUKUBAI/DOWNLOAD/open-usp-tukubai-2014061402.tar.bz2 --no-check-certificate
tar xvjf open-usp-tukubai-2014061402.tar.bz2
cd /var/tmp/open-usp-tukubai-2014061402
make install

cd /var/tmp
wget https://uec.usp-lab.com/TUKUBAI/DOWNLOAD/SALES_WEEKLY_REPORT.tar.bz2 --no-check-certificate
tar xvjf SALES_WEEKLY_REPORT.tar.bz2
cd /var/tmp/SALES_WEEKLY_REPORT
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/aws/bin:/root/bin
sh BUMONTREND > /var/tmp/bumontrend_result.txt

mkdir ~/.aws
echo "[default]" > ~/.aws/config
echo "aws_access_key_id = <ACCESS_KEY>" >> ~/.aws/config
echo "aws_secret_access_key = <SECRET_KEY>" >> ~/.aws/config
/usr/bin/aws s3 cp /var/tmp/bumontrend_result.txt s3://test-bucket-uspmagazine/

/usr/bin/aws ec2 terminate-instances --instance-ids `curl http://169.254.169.254/latest/meta-data/instance-id/` --region ap-northeast-1

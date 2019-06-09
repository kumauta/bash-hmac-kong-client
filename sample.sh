#!/bin/bash

secret="secret"
user="alice123"
url="http://192.168.11.111:8000/requests"

date=`LANG=en_US.UTF-8 date -u +%a,\ %d\ %b\ %Y\ %H:%M:%S\ GMT`
signing_string="date: ${date}"
signature=`echo -n "${signing_string}" | openssl dgst -sha1 -binary -hmac "${secret}" | base64 -w 0`
auth_header="Authorization: hmac username=\"${user}\", algorithm=\"hmac-sha1\", headers=\"date\", signature=\"${signature}\""

curl -v ${url} \
  -H "${auth_header}" \
  -H "date: ${date}"

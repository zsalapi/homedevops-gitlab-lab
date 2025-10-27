# 🧠 HomeDevOps GitLab Lab

Egy nyílt forrású **homelab DevOps projekt**, amely bemutatja, hogyan lehet
**GitLab CE**, **GitLab Runner**, **Nginx reverse proxy**, **CI/CD pipeline**, **backup**
és **monitoring** rendszert építeni **Docker Compose** segítségével.

> 🔧 Cél: valós céges infrastruktúrát modellezni tanuláshoz, gyakorláshoz és portfólióhoz.

---

## 🚀 Funkciók

| Funkció | Leírás |
|----------|---------|
| 🧱 GitLab CE | Saját önhosztolt GitLab szerver |
| ⚙️ GitLab Runner | CI/CD pipeline futtató |
| 🌐 Nginx reverse proxy | `gitlab.local` kiszolgálása |
| 🧪 CI/CD pipeline | Automatikus build, test és deploy lépések |
| 💾 Backup rendszer | Napi rsync alapú mentés |
| 📊 Monitoring | Netdata dashboard (CPU, RAM, Disk, Network) |

---
#Haszonos tudni:

#lehet látni mi hova van ki irányítva - portok és konténerket is
docker ps

#bad gateway lehet attól hogy a gitlab sokáig inicializál itt tudom követni:
docker logs -f gitlab

#gitlab újra konfigolás
docker compose down
docker compose up -d
docker exec -it gitlab gitlab-ctl reconfigure

#nginx restart
docker compose up -d nginx
docker compose restart nginx
docker restart nginx-proxy
docker ps | grep nginx

#teszt
curl -vk https://gitlab.local

#kellenek ezek a hálózatok
docker network create gitlab-net
docker network connect gitlab-net gitlab

#bemegyünk a proxy-ba ha kell
docker exec -it nginx-proxy sh

#bad gateway esetében érdmes megnézni a logokat
docker exec -it gitlab gitlab-ctl tail -f
#vagy csak a Puma és Workhorse logokat:
docker exec -it gitlab gitlab-ctl tail -f puma
docker exec -it gitlab gitlab-ctl tail -f gitlab-workhorse


#gitlab működik-e a gitlab.local
docker exec -it gitlab bash
cat /etc/hosts
ping -c1 gitlab.local

root@gitlab:/# ping -c1 gitlab.local
PING gitlab.local (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: seq=0 ttl=64 time=0.087 ms

--- gitlab.local ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 0.087/0.087/0.087 ms

#nginx proxy eléri-e a gitlab konténert - a konténer neve kell NEM a gitlab.local vigyázz
docker exec -it nginx-proxy sh
ping gitlab
apk add curl   # ha nincs curl
curl -v http://gitlab:80

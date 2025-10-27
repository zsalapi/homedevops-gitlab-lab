# 🧠 HomeDevOps GitLab Lab

Egy Szabad szoftveres **homelab DevOps projekt**, amely bemutatja, hogyan lehet
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

#/etc/hosts fájlba vedd fel a gépeden:<br>
127.0.0.1       gitlab.local<br>
<br>
---<br>
#Haszonos tudni:<br>
<br>
#lehet látni mi hova van ki irányítva - portok és konténerket is<br>
docker ps<br>
<br>
#bad gateway lehet attól hogy a gitlab sokáig inicializál itt tudom követni:<br>
docker logs -f gitlab<br>
<br>
#gitlab újra konfigolás<br>
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
#teszt<br>
curl -vk https://gitlab.local<br>
<br>
#kellenek ezek a hálózatok<br>
docker network create gitlab-net<br>
docker network connect gitlab-net gitlab<br>
<br>
#bemegyünk a proxy-ba ha kell<br>
docker exec -it nginx-proxy sh<br>
<br>
#bad gateway esetében érdmes megnézni a logokat<br>
docker exec -it gitlab gitlab-ctl tail -f<br>
#vagy csak a Puma és Workhorse logokat:<br>
docker exec -it gitlab gitlab-ctl tail -f puma<br>
docker exec -it gitlab gitlab-ctl tail -f gitlab-workhorse<br>
<br>
#gitlab működik-e a gitlab.local<br>
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
#nginx proxy eléri-e a gitlab konténert - a konténer neve kell NEM a gitlab.local vigyázz<br>
docker exec -it nginx-proxy sh<br>
ping gitlab<br>
apk add curl   # ha nincs curl
curl -v http://gitlab:80

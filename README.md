# Telegraf container containing prerequisites for the following scripts
- [Telegraf Importer for TP Link Smart plugs](https://github.com/djrarky/tplink-hs110-telegraf)
- [Telegraf Importer for Huawei 4G / 5G Routers](https://github.com/djrarky/huawei-lte-telegraf)
- [Telegraf Importer for Huawei HG612 Modems](https://github.com/djrarky/huawei-hg612-telegraf)

## Configure
### Run in Docker
```
docker run -d --name=telegraf \
  --network host \
  --restart=always \
  -v location/telegraf.conf:/etc/telegraf/telegraf.conf:ro \
  -v location/scripts:/opt/scripts \
  ghcr.io/djrarky/telegraf-python3
```
### Docker Compose Setup
~~~yml
services:
  telegraf:
    image: ghcr.io/djrarky/telegraf-python3
    container_name: telegraf
    restart: always
    network_mode: "host"
    volumes:
      - location/telegraf.conf:/etc/telegraf/telegraf.conf:ro
      - location/scripts:/opt/scripts
~~~
### Telegraf Setup
```
[[inputs.exec]]
  ## Commands array
  commands = [
    "python3 /opt/scripts/tplink-hs110-telegraf/telegraf-tplink-hs110.py 'plugName1' 'IPAddress1' 'plugName2' 'IPAddress2'",
    "python3 /opt/scripts/huawei-lte-telegraf/telegraf-huawei-lte.py 'http://username:password@IP Address/'"
    "python3 /opt/scripts/huawei-hg612-telegraf/dsl-stats-to-influxdb-3.py 'IPAddress' 'username' 'password'"
  ]

  ## measurement name suffix (for separating different commands)
  name_suffix = "_mycollector"

  ## Data format to consume.
  data_format = "influx"
```

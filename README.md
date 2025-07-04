[logo]: https://ci.nerv.com.au/userContent/antilax-3.png "AntilaX-3"
[![alt text][logo]](https://github.com/AntilaX-3/)

# AntilaX-3/workflowbot
[![](https://images.microbadger.com/badges/version/antilax3/workflowbot.svg)](https://microbadger.com/images/antilax3/workflowbot "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/antilax3/workflowbot.svg)](https://microbadger.com/images/antilax3/workflowbot "Get your own image badge on microbadger.com") [![Docker Pulls](https://img.shields.io/docker/pulls/antilax3/workflowbot.svg)](https://hub.docker.com/r/antilax3/workflowbot/) [![Docker Stars](https://img.shields.io/docker/stars/antilax3/workflowbot.svg)](https://hub.docker.com/r/antilax3/workflowbot/)

[workflowbot](https://github.com/bkeepers/workflow) is a GitHub App built with [probot](https://github.com/probot/probot) that enables complete workflow automation.

## Usage
```
docker create --name=workflowbot \
-v <path to config>:/config \
-p 3000:3000 \
antilax3/workflowbot
```
## Parameters
The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. For example with a volume -v external:internal - what this shows is the volume mapping from internal to external of the container. So -v /mnt/app/config:/config would map /config from inside the container to be accessible from /mnt/app/config on the host's filesystem.

- `-v /config` - local path for application private key
- `-p 3000` - HTTP port for webserver
- `-e PUID` - for UserID, see below for explanation
- `-e PGID` - for GroupID, see below for explanation
- `-e TZ` - for setting timezone information, eg Australia/Melbourne

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it workflowbot /bin/bash`.

## User / Group Identifiers
Sometimes when using data volumes (-v flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work".

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:
`$ id <dockeruser>`
    `uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)`
    
## Volumes

The container uses a single volume mounted at '/config'. This volume stores the private key associated with the GitHub App.

    config
    |-- privkey.pem

## Configuration

The bot is configured by setting the following environment variables:
 
- `APP_ID` - App ID from the GitHub App
- `PRIVATE_KEY_PATH` - Location where the private key is stored, defaults to `/config/privkey.pem`
- `WEBHOOK_SECRET` - Webhook secret from the GitHub App

## Version
- **04/07/25:** Updated to use alpine 3.22 image and s6 v3 service structure
- **14/02/20:** Initial Release
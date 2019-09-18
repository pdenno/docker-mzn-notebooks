docker run -it ^
    --log-opt max-size=50m ^
    -p 8889:8889 -p 3001:3001 -p 7001:7001 ^
    -e DOCKER_USER=$env:UserName ^
    -e DOCKER_USER_ID=1000 ^
    -e DOCKER_PASSWORD=$env:UserName ^
    -e DOCKER_GROUP_ID=1000 ^
    -v "$PSScriptRoot:/workdir" ^
    -v "$HOME:/home_host" ^
    podenno/mzn-notebook

# docker run -it --log-opt max-size=50m -p 8889:8889 -p 3001:3001 -p 7001:7001 -e DOCKER_USER=$env:UserName -e DOCKER_USER_ID=1000     -e DOCKER_PASSWORD=$env:UserName -e DOCKER_GROUP_ID=1000 -v "$PSScriptRoot:/workdir" -v "$HOME:/home_host" podenno/mzn-notebook

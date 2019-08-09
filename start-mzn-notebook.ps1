docker run -it ^
    --log-opt max-size=50m ^
    -p 8888:8888 ^
    -e DOCKER_USER=$env:UserName ^
    -e DOCKER_USER_ID=1000 ^
    -e DOCKER_PASSWORD=$env:UserName ^
    -e DOCKER_GROUP_ID=1000 ^
    -v "$PSScriptRoot:/workdir" ^
    -v "$HOME:/home_host" ^
    podenno/mzn-notebook

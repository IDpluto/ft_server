docker rm `docker ps -a -q`
docker build /Users/dohlee/goinfre/ft_server -t ft_server
docker run -it -p80:80 -p443:443 ft_server

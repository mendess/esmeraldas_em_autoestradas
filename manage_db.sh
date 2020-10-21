machine_ip() {
    IP=$(docker inspect rails-postgres |
        jq '.[0].NetworkSettings.Networks.bridge.IPAddress' -r)
    echo "$IP"
}

CONTAINER_NAME=rails-postgres

case "$1" in
    s | shell)
        docker exec -it rails-postgres \
            psql -U postgres -d esmeraldas_em_autoestradas_development
        ;;
    ip)
        machine_ip
        ;;
    *)
        if docker ps -a | grep -q "$CONTAINER_NAME"; then
            docker start "$CONTAINER_NAME"
        else
            docker run \
                --name rails-postgres \
                -e POSTGRES_PASSWORD=foo \
                -d \
                -p 5432:5432 \
                postgres
        fi
        echo "machine ip: $(machine_ip)"
        ;;
esac

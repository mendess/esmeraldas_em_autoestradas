machine_ip() {
    IP=$(docker inspect rails-postgres |
        jq '.[0].NetworkSettings.Networks.bridge.IPAddress' -r)
    echo "$IP"
}

case "$1" in
    s | shell)
        docker exec -it rails-postgres psql -U postgres
        ;;
    ip)
        machine_ip
        ;;
    *)
        docker run --name rails-postgres -e POSTGRES_PASSWORD=foo -d -p 5432:5432 postgres
        echo "machine ip: $(machine_ip)"
        ;;
esac

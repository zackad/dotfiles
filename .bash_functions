phps() {
    if [ $# -eq 1 ]; then
        php -S 0.0.0.0:8080 -t "$1"
    else
        php -S 0.0.0.0:8080
    fi
}

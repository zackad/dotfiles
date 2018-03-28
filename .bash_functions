# Run PHP built-in webserver
phps() {
    if [ $# -eq 1 ]; then
        php -S 0.0.0.0:8080 -t "$1"
    else
        php -S 0.0.0.0:8080
    fi
}

# Automatically create directory if not exist when ceating new file
# using touch command
mktouch() {
	if [ $# -lt 1 ]; then
		echo "Missing argumnet";
		return 1;
	fi

	for f in "$@"; do
		mkdir -p -- "$(dirname -- "$f")"
		touch -- "$f"
	done
}

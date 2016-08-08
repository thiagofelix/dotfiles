genpasswd() {
  grep "^[^'A-Z]\{3,7\}$" /usr/share/dict/words | shuf -n4 | tr '\n' ' ' | sed 's/\b\(.\)/\u\1/g' | sed 's/ //g'
}

p() { cd $(find ~/workspace ~/workspace/gap -type d -maxdepth 1 | selecta) }

function say {
  lang=${2:-en}
  mplayer -really-quiet "http://translate.google.com/translate_tts?tl=$lang&q=$1"
}

ip() {
  python -c 'import socket; print(socket.gethostbyname(socket.gethostname()))'
}

server() {
  python -m SimpleHTTPServer "${1:-8000}"
}

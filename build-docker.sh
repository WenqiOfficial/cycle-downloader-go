CURRENT_DIR=$(cd $(dirname $0); pwd)

go mod download

go mod tidy

read -p "tag: " tag

echo "Set tag: $tag ."

docker build -t docker-cycler:$tag .

docker tag docker-cycler:$tag wenqiofficial/go-cycle-downloader:$tag

docker push wenqiofficial/go-cycle-downloader:$tag
CURRENT_DIR=$(cd $(dirname $0); pwd)

go mod download

go mod tidy

go build -buildvcs=false -o build/linux .

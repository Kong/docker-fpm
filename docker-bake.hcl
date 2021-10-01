group "default" {
    targets = ["amd64", "arm64v8", "arm32v7"]
}

target "amd64" {
    dockerfile = "Dockerfile.amd64"
    tags = ["docker.io/hutchic/fpm:amd64"]
    platforms = ["linux/amd64"]
}

target "arm64v8" {
    dockerfile = "Dockerfile.arm64v8"
    tags = ["docker.io/hutchic/fpm:arm64v8"]
    platforms = ["linux/arm64"]
}

target "arm32v7" {
    dockerfile = "Dockerfile.arm32v7"
    tags = ["docker.io/hutchic/fpm:arm32v7"]
    platforms = ["linux/arm/v7"]
}

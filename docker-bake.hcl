group "default" {
    targets = ["amd64", "arm64v8", "arm32v7"]
}

target "amd64" {
    dockerfile = "Dockerfile.amd64"
    tags = ["docker.io/hutchic/fpm:amd64"]
    platforms = ["linux/amd64"]
}

target "arm64v8" {
    dockerfile = "Dockerfile.arm64"
    tags = ["docker.io/hutchic/fpm:arm64"]
    platforms = ["linux/arm64"]
}

target "arm32v7" {
    dockerfile = "Dockerfile.arm32"
    tags = ["docker.io/hutchic/fpm:arm32"]
    platforms = ["linux/arm/v7"]
}

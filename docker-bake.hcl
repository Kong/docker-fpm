variable "IMAGE" {
    default = "hutchic/fpm"
}

target "docker-metadata-action" {}

target "build" {
    inherits = ["docker-metadata-action", "amd64", "arm64v8", "arm32v7"]
}

target "amd64" {
    dockerfile = "Dockerfile.amd64"
    tags = ["${IMAGE}"]
    platforms = ["linux/amd64"]
}

target "arm64v8" {
    dockerfile = "Dockerfile.arm64"
    tags = ["${IMAGE}"]
    platforms = ["linux/arm64"]
}

target "arm32v7" {
    dockerfile = "Dockerfile.arm32"
    tags = ["${IMAGE}"]
    platforms = ["linux/arm/v7"]
}

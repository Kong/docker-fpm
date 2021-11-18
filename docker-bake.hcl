group "default" {
    targets = ["amd64", "arm64v8", "arm32v7"]
}

variable "IMAGE" {
    default = "hutchic/fpm"
}

target "docker-metadata-action" {}

target "amd64" {
    inherits = ["docker-metadata-action"]
    dockerfile = "Dockerfile.amd64"
    tags = ["${IMAGE}"]
    platforms = ["linux/amd64"]
}

target "arm64v8" {
    inherits = ["docker-metadata-action"]
    dockerfile = "Dockerfile.arm64"
    tags = ["${IMAGE}"]
    platforms = ["linux/arm64"]
}

target "arm32v7" {
    inherits = ["docker-metadata-action"]
    dockerfile = "Dockerfile.arm32"
    tags = ["${IMAGE}"]
    platforms = ["linux/arm/v7"]
}

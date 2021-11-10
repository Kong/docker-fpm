group "default" {
    targets = ["amd64", "arm64v8", "arm32v7"]
}

variable "IMAGE_NAME" {
    default = "docker.io/hutchic/fpm:amd64"
}

target "amd64" {
    dockerfile = "Dockerfile.amd64"
    tags = ["{IMAGE_NAME}"]
    platforms = ["linux/amd64"]
}

target "arm64v8" {
    dockerfile = "Dockerfile.arm64"
    tags = ["{IMAGE_NAME}"]
    platforms = ["linux/arm64"]
}

target "arm32v7" {
    dockerfile = "Dockerfile.arm32"
    tags = ["{IMAGE_NAME}"]
    platforms = ["linux/arm/v7"]
}

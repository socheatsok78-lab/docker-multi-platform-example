target "default" {
  platforms = [
    "linux/amd64",
    "linux/arm64", # same as "linux/arm64/v8"
    "linux/arm", # same as "linux/arm/v7"
    "linux/ppc64le",
    "linux/s390x",
  ]
}

# Docker multi-platform Example

An example Docker multi-platform builds.

#### Multiple Architectures

Each repo can specify multiple architectures for any and all tags. If no architecture is specified, images are built in Linux on `amd64` (aka x86-64). To specify more or different architectures, use the `Architectures` field (comma-delimited list, whitespace is trimmed). Valid architectures are found in [Bashbrew's `oci-platform.go` file](https://github.com/docker-library/bashbrew/blob/v0.1.2/architecture/oci-platform.go#L14-L27):

-	`amd64`
-	`arm32v6`
-	`arm32v7`
-	`arm64v8`
-	`i386`
-	`mips64le`
-	`ppc64le`
-	`riscv64`
-	`s390x`
-	`windows-amd64`

The `Architectures` of any given tag must be a strict subset of the `Architectures` of the tag it is `FROM`.

Images must have a single `Dockerfile` per entry in the library file that can be used for multiple architectures. This means that each supported architecture will have the same `FROM` line (e.g. `FROM debian:buster`). See [`golang`](https://github.com/docker-library/official-images/blob/master/library/golang), [`docker`](https://github.com/docker-library/official-images/blob/master/library/docker), [`haproxy`](https://github.com/docker-library/official-images/blob/master/library/haproxy), and [`php`](https://github.com/docker-library/official-images/blob/master/library/php) for examples of library files using one `Dockerfile` per entry and see their respective git repos for example `Dockerfile`s.

If different parts of the Dockerfile only happen in one architecture or another, use control flow (e.g.`if`/`case`) along with `dpkg --print-architecture` or `apk -print-arch` to detect the userspace architecture. Only use `uname` for architecture detection when more accurate tools cannot be installed. See [golang](https://github.com/docker-library/golang/blob/b879b60a7d94128c8fb5aea763cf31772495511d/1.16/buster/Dockerfile#L24-L68) for an example where some architectures require building binaries from the upstream source packages and some merely download the binary release.

For base images like `debian` it will be necessary to have a different `Dockerfile` and build context in order to `ADD` architecture specific binaries and this is a valid exception to the above. Since these images use the same `Tags`, they need to be in the same entry. Use the architecture specific fields for `GitRepo`, `GitFetch`, `GitCommit`, and `Directory`, which are the architecture concatenated with hyphen (`-`) and the field (e.g. `arm32v7-GitCommit`). Any architecture that does not have an architecture-specific field will use the default field (e.g. no `arm32v7-Directory` means `Directory` will be used for `arm32v7`). See the [`debian`](https://github.com/docker-library/official-images/blob/master/library/debian) or [`ubuntu`](https://github.com/docker-library/official-images/blob/master/library/ubuntu) files in the library for examples. The following is an example for [`hello-world`](https://github.com/docker-library/official-images/blob/master/library/hello-world):

```
Maintainers: Tianon Gravi <admwiggin@gmail.com> (@tianon),
             Joseph Ferguson <yosifkit@gmail.com> (@yosifkit)
GitRepo: https://github.com/docker-library/hello-world.git
GitCommit: 7d0ee592e4ed60e2da9d59331e16ecdcadc1ed87

Tags: latest
Architectures: amd64, arm32v5, arm32v7, arm64v8, ppc64le, s390x
# all the same commit; easy for us to generate this way since they could be different
amd64-GitCommit: 7d0ee592e4ed60e2da9d59331e16ecdcadc1ed87
amd64-Directory: amd64/hello-world
arm32v5-GitCommit: 7d0ee592e4ed60e2da9d59331e16ecdcadc1ed87
arm32v5-Directory: arm32v5/hello-world
arm32v7-GitCommit: 7d0ee592e4ed60e2da9d59331e16ecdcadc1ed87
arm32v7-Directory: arm32v7/hello-world
arm64v8-GitCommit: 7d0ee592e4ed60e2da9d59331e16ecdcadc1ed87
arm64v8-Directory: arm64v8/hello-world
ppc64le-GitCommit: 7d0ee592e4ed60e2da9d59331e16ecdcadc1ed87
ppc64le-Directory: ppc64le/hello-world
s390x-GitCommit: 7d0ee592e4ed60e2da9d59331e16ecdcadc1ed87
s390x-Directory: s390x/hello-world

Tags: nanoserver
Architectures: windows-amd64
# if there is only one architecture, you can use the unprefixed fields
Directory: amd64/hello-world/nanoserver
# or use the prefixed versions
windows-amd64-GitCommit: 7d0ee592e4ed60e2da9d59331e16ecdcadc1ed87
Constraints: nanoserver
```

See the [instruction format section](https://github.com/docker-library/official-images/tree/master#instruction-format) for more information on the format of the library file.

Also see the [Multiple Architectures](https://github.com/docker-library/official-images/tree/master#multiple-architectures)

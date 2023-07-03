FROM ubuntu

RUN <<EOF
  echo uname -a = $(uname -a)
  echo uname -m = $(uname -m)
  echo dpkg --print-architecture = $(dpkg --print-architecture)
  echo dpkg --print-foreign-architectures = $(dpkg --print-foreign-architectures)
EOF

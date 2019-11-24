#!/bin/sh
set -x
# 设置代理
if [[ ! -z ${http_proxy} ]]; then
    alias curl="curl -x ${http_proxy}"
fi
cat >.travis.yml.start<<EOF
language: bash
env:
  global:
    - MAINTAINER="Ryan Lieu<github-benzBrake@woai.ru>"
  matrix:
EOF
# 生成 Server 构建参数
TAG_LATEST=$(curl --silent "https://api.github.com/repos/fatedier/frp/releases/latest" | grep tag_name | awk -F'"' '{print $4}')
TAGS=$(curl --silent "https://api.github.com/repos/fatedier/frp/releases" | grep tag_name | awk -F'"' '{print $4}')
for tag in ${TAGS}; do
    echo "    - DOCKER_REPO=benzbrake/frps" >> .travis.yml.middle
    echo "      DOCKER_TAG=${tag}" >> .travis.yml.middle
    echo "      BUILD_DIRECTORY=server" >> .travis.yml.middle
    if [[ ${tag} = ${TAG_LATEST} ]]; then
        echo "      TAG_LATEST=true" >> .travis.yml.middle
    fi
done
cat >.travis.yml.end<<EOF

sudo: required
  
services:
  - docker

before_script:
  - chmod +x ./hooks/*.sh

script:
  - if [[ -z ${DOCKER_USERNAME} ]]; then exit 1; fi
  - if [[ -z ${BUILD_DIRECTORY} ]]; then exit 1; fi
  - if [[ -z ${DOCKER_REPO} ]]; then export DOCKER_REPO="${DOCKER_USERNAME}/${BUILD_DIRECTORY}"; fi
  - if [[ -f ${BUILD_DIRECTORY}/build.sh ]]; then bash ${BUILD_DIRECTORY}/build.sh; else ./hooks/build.sh; fi

after_success:
  - ./hooks/list.sh
  - if [[ "$TRAVIS_BRANCH" = "master" ]]; then ./hooks/upload.sh ; fi

notifications:
  email: false
EOF
cat .travis.yml.start .travis.yml.middle .travis.yml.end > .travis.yml
rm -f .travis.yml.start .travis.yml.middle .travis.yml.end
set +x

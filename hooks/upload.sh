#!/usr/bin/env bash
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
    set -x
fi
if [[ "${TRAVIS_BRANCH}" == "master" ]] && [[ ! -z ${DOCKER_USERNAME} ]] && [[ ! -z ${DOCKER_PASSWORD} ]]; then
    docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
    TAGS=${DOCKER_TAG-latest}
    if [[ ! -z ${TAG_FROM_TAGS} ]]; then
        cd /tmp/git &> /dev/null
        EXT_TAGS="$(echo -e $(git tag 2>/dev/null) | sed 's#\n# #g')"
        cd - &> /dev/null
        TAGS="${TAGS} ${EXT_TAGS}"
        for tag in ${TAGS} ; do
            docker push ${DOCKER_REPO}:${tag}
        done
    fi
    # 推送指定构建镜像
    if [[ ! -z ${DOCKER_TAG} ]]; then
        docker push ${DOCKER_REPO}:${DOCKER_TAG-latest}
    fi
    # Push latest 镜像
    if [[ ${TAG_LATEST} = "true" ]]; then
        docker push ${DOCKER_REPO}:latest
    fi
fi
set -x
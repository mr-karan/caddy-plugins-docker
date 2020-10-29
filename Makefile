IMAGE_NAME := mrkaran/caddy
CURRENT_BUILD_TAG := 2.2.1
LATEST_TAG:= latest

build:
	docker build \
	-t ${IMAGE_NAME}:${CURRENT_BUILD_TAG} \
	-t ${IMAGE_NAME}:${LATEST_TAG} \
	.

push:
	docker push ${IMAGE_NAME}:${CURRENT_BUILD_TAG}
	docker push ${IMAGE_NAME}:${LATEST_TAG}

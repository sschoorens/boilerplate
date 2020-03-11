DOCKER_REGISTRY ?= myregistry
PROJECT_NAME ?= new-project
DOCKER_IMG ?= ${DOCKER_REGISTRY}/${PROJECT_NAME}


check_code:
ifndef CI
	docker run -it -e CI='1' -v ${CURDIR}:/src -w /src --rm ${DOCKER_IMG} make check_code
else
	flake8 --ignore=E265,E501,W503,W505 --exclude=docs/,submodules/
endif

dead_code:
ifndef CI
	docker run -it -e CI='1' -v ${CURDIR}:/src -w /src --rm ${DOCKER_IMG} make dead_code
else
	vulture . --exclude `pwd`/tests,`pwd`/setup.py,`pwd`/docs,`pwd`/build
endif

test:
ifndef CI
	docker run -it -e CI='1' -v ${CURDIR}:/src -w /src --rm ${DOCKER_IMG} make test
else
	python3-coverage run --source ${PROJECT_NAME} -m unittest -v ${UNITTEST_OPTS} && python3-coverage report -m
endif


test_e2e:
ifndef CI
	docker run -it -e CI='1' \
	-e UNITTEST_OPTS=${UNITTEST_OPTS} \
	-v ${CURDIR}:/src -w /src --rm ${DOCKER_IMG} make test_e2e
else
	python3 -m unittest -v ${UNITTEST_OPTS} tests/e2e/e2e*
endif

shell:
	docker run -it -e CI='1' -v ${CURDIR}:/src -w /src --rm ${DOCKER_IMG} /bin/bash


build:
	docker build -t ${DOCKER_IMG} -f Dockerfile .


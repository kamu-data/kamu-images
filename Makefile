SPARK_VERSION = 3.0.1
KAMU_VERSION = 0.0.1
IMAGE_REPO = kamudata
IMAGE_SPARK_UBER_TAG = $(SPARK_VERSION)_$(KAMU_VERSION)
IMAGE_JUPYTER_UBER_TAG = $(KAMU_VERSION)


.PHONY: spark
spark:
	cd $(SPARK_HOME) && ./bin/docker-image-tool.sh \
		-r $(IMAGE_REPO) \
		-t $(SPARK_VERSION) \
		-p kubernetes/dockerfiles/spark/bindings/python/Dockerfile \
		build


.PHONY: spark-py-uber
spark-py-uber:
	docker build \
		--build-arg SPARK_VERSION=$(SPARK_VERSION) \
		-t $(IMAGE_REPO)/spark-py-uber:$(IMAGE_SPARK_UBER_TAG) \
		-f Dockerfile.spark-py-uber \
		.


.PHONY: jupyter-uber
jupyter-uber:
	docker build \
		-t $(IMAGE_REPO)/jupyter-uber:$(IMAGE_JUPYTER_UBER_TAG) \
		-f Dockerfile.jupyter-uber \
		.


.PHONY: jupyter-requirements
jupyter-requirements:
	pip-compile -v -r jupyter/requirements.jupyter.in -o jupyter/requirements.jupyter.txt

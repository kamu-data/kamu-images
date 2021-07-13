SPARK_VERSION = 3.0.1
KAMU_VERSION = 0.0.1
IMAGE_REPO = docker.io/kamudata
IMAGE_SPARK_UBER_TAG = $(SPARK_VERSION)_$(KAMU_VERSION)
IMAGE_JUPYTER_TAG = 0.1.0


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


.PHONY: jupyter
jupyter:
	docker build \
		-t $(IMAGE_REPO)/jupyter:$(IMAGE_JUPYTER_TAG) \
		jupyter/


.PHONY: jupyter-push
jupyter-push:

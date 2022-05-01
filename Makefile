
all: build network volume postgres spark jupyter

build: build_spark-postgres build_jupyter-all

build_spark-postgres:
	docker build -t ziva/spark-postgres -f Dockerfile.Spark-Postgres .

build_jupyter-all:
	docker build -t ziva/jupyter-all -f Dockerfile.Jupyter .

volume:
	cp -R src/ /tmp/

network:
	@docker network inspect sharedNetwork >/dev/null 2>&1 || docker network create sharedNetwork

postgres:
	@docker start postgres > /dev/null 2>&1 || docker run --name postgres \
		--restart unless-stopped \
		--net=sharedNetwork \
		-e POSTGRES_PASSWORD=postgres \
		-e PGDATA=/var/lib/postgresql/data/pgdata \
		-v /opt/postgres:/var/lib/postgresql/data \
		-p 5432:5432 -d postgres:11

spark:
	docker-compose up -d

jupyter:
	@docker start jupyter-all > /dev/null 2>&1 || docker run -p 9999:8888 \
		-p 4040:4040 \
		-p 4041:4041 \
		-v /tmp:/data \
		--net=sharedNetwork \
		--name jupyter-all \
		--restart unless-stopped \
		-d ziva/jupyter-all

jupyter_token:
	@docker logs jupyter-all 2>&1 | grep '\?token\=' -m 1 | cut -d '=' -f2

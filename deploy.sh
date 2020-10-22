docker build -t just4docker/multi-client:latest -t just4docker/multi-clinet:$SHA -f ./client/Dockerfile ./client
docker build -t just4docker/multi-server:latest -t just4docker/multi-server:$SHA -f ./server/Dokcerfile ./server
docker build -t just4docker/multi-worker:latest -t just4docker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push just4docker/multi-client:latest
docker push just4docker/multi-server:latest
docker push just4docker/multi-worker:latest

docker push just4docker/multi-client:$SHA
docker push just4docker/multi-server:$SHA
docker push just4docker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=just4docker/multi-server:$SHA
kubectl set image deployments/client-deployment client=just4docker/multi-client:$SHA
kubectl set image deployments/worker-deloyment worker=just4docker/multi-client:$SHA

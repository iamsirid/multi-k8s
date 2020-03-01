docker build -t iamsirid/multi-client:latest -t iamsirid/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t iamsirid/multi-server:latest -t iamsirid/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t iamsirid/multi-worker:latest -t iamsirid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push iamsirid/multi-client:latest
docker push iamsirid/multi-server:latest
docker push iamsirid/multi-worker:latest

docker push iamsirid/multi-client:$SHA
docker push iamsirid/multi-server:$SHA
docker push iamsirid/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=iamsirid/multi-client:$SHA
kubectl set image deployments/server-deployment server=iamsirid/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=iamsirid/multi-worker:$SHA

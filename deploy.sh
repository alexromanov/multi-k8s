docker build -t al8xr/multi-client:latest -t al8xr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t al8xr/multi-server:latest -t al8xr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t al8xr/multi-worker:latest -t al8xr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push al8xr/multi-client:latest
docker push al8xr/multi-server:latest
docker push al8xr/multi-worker:latest

docker push al8xr/multi-client:$SHA
docker push al8xr/multi-server:$SHA
docker push al8xr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=al8xr/multi-server:$SHA
kubectl set image deployments/client-deployment client=al8xr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=al8xr/multi-wroker:$SHA




docker build -t kmanek/multi-client:latest -t kmanek/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kmanek/multi-server -t kmanek/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kmanek/multi-worker -t kmanek/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kmanek/multi-client:latest
docker push kmanek/multi-server:latest
docker push kmanek/multi-worker:latest

docker push kmanek/multi-client:$SHA
docker push kmanek/multi-server:$SHA
docker push kmanek/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kmanek/multi-server:$SHA
kubectl set image deployments/client-deployment client=kmanek/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kmanek/multi-worker:$SHA
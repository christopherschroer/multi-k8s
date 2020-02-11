docker build -t christopherschroer/multi-client:latest -t christopherschroer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t christopherschroer/multi-server:latest -t christopherschroer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t christopherschroer/multi-worker:latest -t christopherschroer/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push christopherschroer/multi-client:latest
docker push christopherschroer/multi-server:latest
docker push christopherschroer/multi-worker:latest
docker push christopherschroer/multi-client:$SHA
docker push christopherschroer/multi-server:$SHA
docker push christopherschroer/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=christopherschroer/multi-client:$SHA
kubectl set image deployments/server-deployment server=christopherschroer/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=christopherschroer/multi-worker:$SHA
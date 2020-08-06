docker build -t tjteru/multi-client:latest -t tjteru/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tjteru/multi-server:latest -t tjteru/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tjteru/multi-worker:latest -t tjteru/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tjteru/multi-client:latest
docker push tjteru/multi-server:latest
docker push tjteru/multi-worker:latest
docker push tjteru/multi-client:$SHA
docker push tjteru/multi-server:$SHA
docker push tjteru/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tjteru/multi-server:$SHA
kubectl set image deployments/client-deployment client=tjteru/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tjteru/multi-worker:$SHA
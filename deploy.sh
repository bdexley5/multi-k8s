docker build -t bdexley5/multi-client:latest -t bdexley5/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bdexley5/multi-server:latest -t bdexley5/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bdexley5/multi-worker:latest -t bdexley5/multi-worker: $SHA -f ./worker/Dockerfile ./worker
docker push bdexley5/multi-client:latest
docker push bdexley5/multi-server:latest
docker push bdexley5/multi-worker:latest
docker push bdexley5/multi-client:$SHA
docker push bdexley5/multi-server:$SHA
docker push bdexley5/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bdexley5/multi-server:$SHA
kubectl set image deployments/client-deployment client=bdexley5/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bdexley5/multi-worker:$SHA

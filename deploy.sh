docker build -t phirani/multi-client:latest -t phirani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t phirani/multi-server:latest -t phirani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t phirani/multi-worker:latest -t phirani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push phirani/multi-client:latest
docker push phirani/multi-server:latest
docker push phirani/multi-worker:latest

docker push phirani/multi-client:$SHA
docker push phirani/multi-server:$SHA
docker push phirani/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=phirani/multi-server:$SHA
kubectl set image deployments/client-deployment client=phirani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=phirani/multi-worker:$SHA
#git rev-parse HEAD -> $GIT_SHA
docker build -t gabriellindstrom/multi-client:latest -t gabriellindstrom/multi-client:$GIT_SHA  -f ./client/Dockerfile ./client
docker build -t gabriellindstrom/multi-server:latest -t gabriellindstrom/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t gabriellindstrom/multi-worker:latest -t gabriellindstrom/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push gabriellindstrom/multi-client:latest
docker push gabriellindstrom/multi-server:latest
docker push gabriellindstrom/multi-worker:latest

docker push gabriellindstrom/multi-client:$GIT_SHA
docker push gabriellindstrom/multi-server:$GIT_SHA
docker push gabriellindstrom/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gabriellindstrom/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=gabriellindstrom/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=gabriellindstrom/multi-worker:$GIT_SHA
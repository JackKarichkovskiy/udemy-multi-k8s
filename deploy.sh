docker build -t ekarychkovsky/udemy-multi-client:latest -t ekarychkovsky/udemy-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ekarychkovsky/udemy-multi-server:latest -t ekarychkovsky/udemy-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ekarychkovsky/udemy-multi-worker:latest -t ekarychkovsky/udemy-multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ekarychkovsky/udemy-multi-client:latest
docker push ekarychkovsky/udemy-multi-server:latest
docker push ekarychkovsky/udemy-multi-worker:latest

docker push ekarychkovsky/udemy-multi-client:$SHA
docker push ekarychkovsky/udemy-multi-server:$SHA
docker push ekarychkovsky/udemy-multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ekarychkovsky/udemy-multi-server:$SHA
kubectl set image deployments/client-deployment client=ekarychkovsky/udemy-multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ekarychkovsky/udemy-multi-worker:$SHA
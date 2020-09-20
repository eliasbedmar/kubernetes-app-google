docker build -t eliasbedmar/dockerstack-client:latest -t eliasbedmar/dockerstack-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t eliasbedmar/dockerstack-server:latest -t eliasbedmar/dockerstack-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t eliasbedmar/dockerstack-worker:latest -t eliasbedmar/dockerstack-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

#Take images and push to DockerHub
docker push eliasbedmar/dockerstack-client:latest
docker push eliasbedmar/dockerstack-server:latest
docker push eliasbedmar/dockerstack-worker:latest
docker push eliasbedmar/dockerstack-client:$GIT_SHA
docker push eliasbedmar/dockerstack-server:$GIT_SHA
docker push eliasbedmar/dockerstack-worker:$GIT_SHA

#Apply K8s config files
kubectl apply -f k8s

#Imperatively set latest image for deployment
kubectl set image deployments/deployment-client client=eliasbedmar/dockerstack-client:$GIT_SHA
kubectl set image deployments/deployment-server server=eliasbedmar/dockerstack-server:$GIT_SHA
kubectl set image deployments/deployment-worker worker=eliasbedmar/dockerstack-worker:$GIT_SHA

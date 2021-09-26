#Get the hash
GIT_SHA=$(git rev-parse HEAD)

#build docker image with the recent git commit hash

docker build -t ash2200/static-website-k8s:$GIT_SHA .

#Push the image to the docker hub

docker push ash2200/static-website-k8s:$GIT_SHA

#apply k8s yaml configs to form k8s resources

kubectl apply -f k8s/namespace.yml

kubectl apply -f k8s/

#Update the image in deployment resources

kubectl set image deployment.apps/static-web-deployment -n=sample days-app-container=ash2200/static-website-k8s:$GIT_SHA




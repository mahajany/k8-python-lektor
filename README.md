
## The Hello Webapp
Deploy the code using k8s - the web-app is a lektor app.
### Refrences:
1. https://palletsprojects.com/
2. https://github.com/pallets/website
3. https://www.katacoda.com/courses/kubernetes/deploy-service-from-source
4. https://github.com/datawire/hello-webapp.git
5. Forge: https://forge.sh/?utm_source=katacoda&utm_medium=tutorial&utm_campaign=tutorial


#### Build docker image
```
docker build -t hello-lektor:v1 .
```

#### Run container
```
docker run -d -p 5000:5000 hello-lektor:v1
curl localhost:5000
```

#### Export image to registry
Katacoda registery `export REGISTRY=2886795325-5000-frugo04.environments.katacoda.com`
Tag Image - `docker tag hello-webapp:v1 $REGISTRY/hello-webapp:v1`
Then Update Registry in deployment.yaml: `sed -i -e 's@IMAGE_URL@'"$REGISTRY/hello-webapp:v1"'@' deployment-katacoda.yaml`


For Katacoda's k8 server you can create new .kube profile as well....
New .kube profile
`scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@host01:/root/.kube/config ~/.kube/`

Run service:

kubectl apply -f deployment.yaml
kubectl get services
kubectl get pods

Get port and URL:
export PORT=$(kubectl get svc hello-webapp -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}')
curl host01:$PORT


docker tag hello-lektor:v1 mahajany/hello-lektor:v1
 docker push  mahajany/hello-lektor:v1

#### Deployment steps:
1) created a container 
2) created the Kubernetes manifest 
3) pushed the container to a registry and 
4) finally told Kubernetes all about these pieces with an updated manifest.

Change

sed -i -e 's/Hello World!/Hello Hacker News!!!/' app.py
Use "Forge": Forge will automatically build your Docker container (based on your Dockerfile), push the container to your Docker registry of choice, build a deployment.yaml file for you that points to your image, and then deploy the container into Kubernetes.

forge setup
generic || 2886795325-5000-frugo04.environments.katacoda.com || root || root || root 
forege deploy
# webapp-in-wildfly-on-kubernetes

This repo shows how to deploy a WAR of a given web-app on EAP running on OCP.


## OCP commands

```
# Create the project
oc new-project eap-ocp

# Import the EAP image in the local container registry
oc import-image jboss-eap-7/eap74-openjdk17-openshift-rhel8 --from=registry.redhat.io/jboss-eap-7/eap74-openjdk17-openshift-rhel8 --confirm --namespace eap-ocp

# Create quay.io secret
oc create secret docker-registry quay --docker-server=quay.io --docker-username=your-username --docker-password="your-password"
oc secrets link default quay --for=pull
oc secrets link builder quay

# Create the build config starting from the imported builder image
oc new-build --image-stream="eap74-openjdk17-openshift-rhel8" --binary  --namespace eap-ocp --name web-app-in-eap-on-ocp --to-docker=true --to="quay.io/your-username/web-app-in-eap-on-ocp:latest"

# Apply custom resource from repo https://github.com/obryan5598/web-app-in-eap-on-ocp-manifests
# oc create -f imagestream.yaml
# oc create -f deployment.yaml
# oc create -f service.yaml
# oc create -f route.yaml

# Start a new build from the current directory of this repo
oc start-build buildconfig/web-app-in-eap-on-ocp --from-dir . --follow

# Tagging the image would trigger the deployment for the 1.0 tag (as specified by image.openshift.io/triggers annotation in deployment object)
oc tag --source=docker quay.io/your-username/web-app-in-eap-on-ocp:latest web-app-in-eap-on-ocp:1.0

# Invoke the web App via HTTPie
http http://path.to.your.ocp.cluster/web-app-in-eap-on-ocp/systemProperty
```

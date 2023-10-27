# webapp-in-wildfly-on-kubernetes

This repo shows how to deploy a WAR of a given web-app on EAP running on OCP.


## OCP commands

```
# Create the project
oc new-project eap-ocp

# Import the EAP image in the local container registry
oc import-image jboss-eap-7/eap74-openjdk11-openshift-rhel8:7.4.13-7.1698058564 --from=registry.redhat.io/jboss-eap-7/eap74-openjdk11-openshift-rhel8:7.4.13-7.1698058564 --confirm --namespace eap-ocp

# Create the build config starting from the imported builder image
oc new-build --image-stream="eap74-openjdk11-openshift-rhel8:7.4.13-7.1698058564" --binary  --namespace eap-ocp --name web-app-in-eap-on-ocp

# Start a new build from the current directory of this repo
oc start-build buildconfig/web-app-in-eap-on-ocp --from-dir .

# Create the application
oc new-app web-app-in-eap-on-ocp

# Expose the route
oc expose svc web-app-in-eap-on-ocp

# Retrieve the route
oc get route

# Invoke the web App via HTTPie
http http://path.to.your.ocp.cluster/web-app-in-eap-on-ocp/systemProperty
```

## TODOs

Following TODOs to complete:
- Import an Elytron Credential Store with given credentials
- Adding a JDBC driver as a module and configure the instance accordingly using the Elytron Credential Store

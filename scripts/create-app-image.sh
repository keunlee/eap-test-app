oc process eap-xp1-basic-s2i \
  -p APPLICATION_IMAGE=my-app \ 
  -p EAP_IMAGE=jboss-eap-xp1-openjdk8-openshift:1.0 \ 
  -p EAP_RUNTIME_IMAGE=jboss-eap-xp1-openjdk8-runtime-openshift:1.0 \ 
  -p EAP_IMAGESTREAM_NAMESPACE=$(oc project -q) \ 
  -p SOURCE_REPOSITORY_URL=https://github.com/keunlee/eap-test-app.git \ 
  -p SOURCE_REPOSITORY_REF=master \ 
  -p CONTEXT_DIR=helloworld-html5 | oc create -f - 

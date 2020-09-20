oc new-app --template=eap73-basic-s2i \
 -p IMAGE_STREAM_NAMESPACE=eap-demo \
 -p SOURCE_REPOSITORY_URL=https://github.com/keunlee/eap-test-app.git \
 -p SOURCE_REPOSITORY_REF=master \
 -p CONTEXT_DIR=helloworld-html5

podTemplate(yaml: '''
apiVersion: v1
kind: Pod
spec:
  volumes:
  - name: docker-socket
    emptyDir: {}
  serviceAccountName: jenkins-operator-jenkinscicd
  containers:
  - name: openshift
    image: openshift/origin-cli
    command: ['cat']
    tty: true
  - name: maven
    image: maven:3.6.3-openjdk-8
    command: ['cat']
    tty: true
  - name: docker
    image: docker:19.03.1
    command:
    - sleep
    args:
    - 99d
    volumeMounts:
    - name: docker-socket
      mountPath: /var/run
  - name: docker-daemon
    image: docker:19.03.1-dind
    securityContext:
      privileged: true
    volumeMounts:
    - name: docker-socket
      mountPath: /var/run
''') {
    node(POD_LABEL) {
        // stage('Check Out') {
        //     git 'https://github.com/keunlee/eap-test-app.git'
        // }

        // stage('Build + Test') {   
        //     container('maven') {
        //         sh 'mvn -f eap-demo/pom.xml clean compile package'
        //     }
        // }         

        stage('Push Artifact') {
            sh 'mkdir -p /etc/docker/certs.d/quayecosystem-quay-example-quayio-private-001.apps.okd.thekeunster.local'
            sh 'ls /etc/docker/certs.d'
            container('docker') {
                sh 'docker login -u kelee -p password quayecosystem-quay'
            }
        }

        // stage('validate maven') {
        //     container('maven') {
        //         sh 'mvn --version'
        //     }
        // }

        // stage('validate openshift') {
        //     container('openshift') {
        //         sh 'oc version'
        //         sh 'oc get nodes'
        //         sh 'oc project jboss-eap-test-001'
        //         sh 'oc start-build eap-app-build-artifacts'
        //     }
        // }
    }
}

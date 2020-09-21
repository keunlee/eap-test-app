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
    image: maven:3.3.9-jdk-8-alpine
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
        stage('Build') {
            sh 'pwd'
            sh 'ls'
            // container('maven') {
            //     sh 'mvn --version'
            // }
        }         

        // stage('validate docker') {
        //     container('docker') {
        //         sh 'docker version'
        //         sh 'docker info'
        //     }
        // }

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

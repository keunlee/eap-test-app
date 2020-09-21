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
        stage('Check Out') {
            git 'https://github.com/keunlee/eap-test-app.git'
        }

        stage('Build + Test') {   
            container('maven') {
                sh """
                cd eap-demo
                mvn clean compile test package
                """
            }
        }         

        stage('Push Artifact') {
            sh 'echo "pushing artifact"'
        }

        stage('Deploy') {
            container('openshift') {
                script {
                    try {
                        sh "oc delete wildflyservers.wildfly.org eap-demo"
                    } catch (err) {
                        echo err.getMessage()
                    }
                }

                sh """
                cd eap-demo
                oc project jboss-eap-test-001
                
                oc create -f eap-demo-instance.yaml
                """
            }
        }
    }
}

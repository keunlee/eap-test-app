def label = "docker-jenkins-${UUID.randomUUID().toString()}"

podTemplate(
        label: label,
        serviceAccountName: 'jenkins-operator-jenkinscicd',
        containers: [
                containerTemplate(name: 'jnlp', image: 'jenkins/jnlp-slave:alpine'),
                containerTemplate(name: 'docker', image: 'docker:18.06.1-ce-dind', command: 'cat', ttyEnabled: true),
        ],
        volumes: [
            hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock'),
        ]) {
    node(label) {
        stage('Docker Build') {
            container('docker') {
                echo "Building docker image..."
                sh "echo 'hello world'"
                sh "docker -v"
                sh "docker info"

            }
        }
    }
}
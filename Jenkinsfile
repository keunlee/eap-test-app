// podTemplate(yaml:'''
// spec:
//   containers:
//   - name: jnlp
//     image: jenkins/jnlp-slave:4.0.1-1
//     volumeMounts:
//     - name: home-volume
//       mountPath: /home/jenkins
//     env:
//     - name: HOME
//       value: /home/jenkins
//   - name: maven
//     image: maven:3.6.3-jdk-8
//     command: ['cat']
//     tty: true
//     volumeMounts:
//     - name: home-volume
//       mountPath: /home/jenkins
//     env:
//     - name: HOME
//       value: /home/jenkins
//     - name: MAVEN_OPTS
//       value: -Duser.home=/home/jenkins
//   volumes:
//   - name: home-volume
//     emptyDir: {}
// ''') {
//   node(POD_LABEL) {
//     stage('Build a Maven project') {
//       container('maven') {
//         git 'https://github.com/jenkinsci/kubernetes-plugin.git'
//         sh 'mvn -B clean package -DskipTests'
//       }
//     }
//   }
// }

podTemplate(yaml: """
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: jenkins-operator-jenkinscicd
  containers:
  - name: docker
    image: docker:latest
    command: ['cat']
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: /var/run/docker.sock
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
"""
  ) {

  def image = "jenkins/jnlp-slave"
  node(POD_LABEL) {
    stage('Build Docker image') {
    //   git 'https://github.com/jenkinsci/docker-jnlp-slave.git'
      container('docker') {
        // sh "docker build -t ${image} ."
        sh "docker login -u user -p test quayecosystem-quay"
      }
    }
  }
}
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


pipeline {
  agent {
    kubernetes {
      label 'spring-petclinic-demo'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  serviceAccountName: jenkins-operator-jenkinscicd
  containers:
  - name: maven
    image: maven:latest
    command:
    - cat
    tty: true
    volumeMounts:
      - mountPath: "/root/.m2"
        name: m2
  - name: docker
    image: docker:latest
    command:
    - cat
    tty: true
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
  volumes:
    - name: docker-sock
      hostPath:
        path: /var/run/docker.sock
    - name: m2
      persistentVolumeClaim:
        claimName: m2

"""
}
   }
  stages {
    stage('Test Docker') {
      steps {
        container('docker') {
          sh """
            docker build -t spring-petclinic-demo:$BUILD_NUMBER .
          """
        }
      }
    }
  }
}
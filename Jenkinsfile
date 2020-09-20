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
    options {
        disableConcurrentBuilds()
    }
    agent {
        kubernetes {
            label 'docker-in-docker-maven'
            yaml """
apiVersion: v1
kind: Pod
spec:
containers:
- name: docker-client
  image: docker:19.03.1
  command: ['sleep', '99d']
  env:
    - name: DOCKER_HOST
      value: tcp://localhost:2375
- name: docker-daemon
  image: docker:19.03.1-dind
  env:
    - name: DOCKER_TLS_CERTDIR
      value: ""
  securityContext:
    privileged: true
  volumeMounts:
      - name: cache
        mountPath: /var/lib/docker
volumes:
  - name: cache
    hostPath:
      path: /tmp
      type: Directory
"""
        }
    }
    stages {
        stage('Docker Build') {
            steps {
                container('docker-client') {
                    sh 'docker version'
                }
            }
        }
    }
}
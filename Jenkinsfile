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
spec:
  containers:
  - env:
    - name: "JENKINS_SECRET"
      value: "********"
    - name: "JENKINS_TUNNEL"
      value: "jenkins-operator-slave-jenkinscicd:50000"
    - name: "JENKINS_AGENT_NAME"
      value: "docker-jenkins-94f5a455-a578-4e25-abdc-4d606237d0b9-zkj5m-1nv7l"
    - name: "JENKINS_NAME"
      value: "docker-jenkins-94f5a455-a578-4e25-abdc-4d606237d0b9-zkj5m-1nv7l"
    - name: "JENKINS_AGENT_WORKDIR"
      value: "/home/jenkins/agent"
    - name: "JENKINS_URL"
      value: "http://jenkins-operator-http-jenkinscicd:8080/"
    image: "jenkins/jnlp-slave:alpine"
    imagePullPolicy: "IfNotPresent"
    name: "jnlp"
    resources:
      limits: {}
      requests: {}
    tty: false
    volumeMounts:
    - mountPath: "/var/run/docker.sock"
      name: "volume-0"
      readOnly: false
    - mountPath: "/home/jenkins/agent"
      name: "workspace-volume"
      readOnly: false
  - command:
    - "cat"
    image: "docker:18.06.1-ce-dind"
    imagePullPolicy: "IfNotPresent"
    name: "docker"
    resources:
      limits: {}
      requests: {}
    tty: true
    volumeMounts:
    - mountPath: "/var/run/docker.sock"
      name: "volume-0"
      readOnly: false
    - mountPath: "/home/jenkins/agent"
      name: "workspace-volume"
      readOnly: false
  nodeSelector:
    kubernetes.io/os: "linux"
  restartPolicy: "Never"
  volumes:
  - hostPath:
      path: "/var/run/docker.sock"
    name: "volume-0"
  - emptyDir:
      medium: ""
    name: "workspace-volume"
"""
  ) {

  def image = "jenkins/jnlp-slave"
  node(POD_LABEL) {
    stage('Build Docker image') {
    //   git 'https://github.com/jenkinsci/docker-jnlp-slave.git'
      container('docker') {
        // sh "docker build -t ${image} ."
        sh "newgrp docker"
        sh "docker version"
      }
    }
  }
}
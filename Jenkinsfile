node('master') {

    currentBuild.result = "SUCCESS"

    try {

       stage('Checkout'){

          checkout scm
       }

       stage('Test'){
         sh 'echo "testing"'
       }

    }
    catch (err) {
        throw err
    }
}

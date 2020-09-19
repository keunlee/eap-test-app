de('node') {

    currentBuild.result = "SUCCESS"

    try {

       stage('Checkout'){

          checkout scm
       }

    }
    catch (err) {
        throw err
    }
}

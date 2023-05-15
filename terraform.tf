pipeline {
agent any
tools {
 
  java "myjava"
  maven "mymaven" 

}
stages{
 stage('gitcheckout & compile'){
  steps{
   git 'https://github.com/devops-trainer/addressbook.git'
   sh "mvn compile"
   
 }
}

   stage ('CodeReview'){
   steps {
    sh "mvn pmd:pmd"
    }
 }
    

stage ('UnitTest'){
   steps {
    sh "mvn test"
   }
   post {
    always {
        Junit 'target/surefire/reports/*.xml'
    }
  }
 }

stage ('MetricCheck'){
   steps {
    sh "mvn cobertura:cobertura -Dcobetura.report.fomat=xml"
    }
   post {
    always {
       cobertura coberturaReportFile: 'target/site/cobertura/coverage.xml'
    }
  }

pipeline {
	agent { label 'JDK17' } 
        options { 
		timeout(time: 1, unit: 'HOURS')   
		retry(2)
	} 
   	triggers {
		cron('0 * * * *')
	}
	stages {
		stage('Source Code') {
			steps {
			   git url: 'https://github.com/techleads23/spring-petclinic.git',
 			   branch: 'main'
		}
	}
 		stage('Build the code') {
			steps {
			   sh script: '/opt/apache-maven-3.8.7/bin/mvn clean package'
		}

	}
		stage('Junit Reporting') {
			steps {
			  junit testResults: 'target/surefire-reports/*.xml'
		}

	}
   }
	post {
		success {
			echo "Success"
		}
		unsuccessful {
			echo "Failure"
		}
	}
}

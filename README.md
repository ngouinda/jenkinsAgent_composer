Documentation of the base image : https://hub.docker.com/r/jenkins/inbound-agent

docker build . -t jenkins_agent_symfony

docker run --name jenkins_agent_symfony_container --init jenkins_agent_symfony -url http://172.17.0.2:8080 aaad88ec9631410972d803fc5aef84d442c4e46e54c3429325b2b18c47b1c219 jenkinsAgent_composer

To get the <IPAdresse_of_jenkins_master>, make this command :
docker inspect jenkins_master_container

<password> and <node_name> are given by the jenkins_master when you create a node
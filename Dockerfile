FROM jenkins:2.60.3-alpine
RUN jenkins-plugin-cli --plugins kubernetes 


FROM jenkins/jenkins
USER root
RUN apt-get update && apt-get install -y gnupg wget software-properties-common && \
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list && \
    apt update && apt-get install terraform && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install
RUN apt-get install curl  && \
    apt-get install gnupg  && \
    apt-get install ca-certificates  && \
    apt-get install lsb-release 
RUN apt-get update && \
    apt-get install ca-certificates curl gnupg lsb-release -y  && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null 
RUN apt-get update && \
    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
USER jenkins
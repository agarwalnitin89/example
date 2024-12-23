# Start with the AWS Lambda Python runtime as the base image
FROM amazonlinux:2

# Update the package manager and install necessary tools
RUN yum update -y && \
    yum install -y \
    aws-cli \
    docker \
    tar \
    gzip \
    zip \
    java-17-amazon-corretto \
    && yum clean all

# Install Node.js (LTS version)
# RUN curl -fsSL https://rpm.nodesource.com/setup_20.x | bash - && \
#     yum install -y nodejs && \
#     yum clean all
RUN touch ~/.bashrc && chmod +x ~/.bashrc
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN . ~/.nvm/nvm.sh && source ~/.bashrc && nvm install node
# Install Docker CLI (for building Docker images inside the environment)
# RUN curl -fsSL https://get.docker.com/ | sh

# # Install Docker CLI manually
# RUN yum update -y && \
#     yum install -y docker && \
#     yum clean all

RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
RUN yum install docker-ce docker-ce-cli containerd.io
RUN systemctl start docker && systemctl enable docker
# Verify installations
RUN java -version && \
    node -v && \
    npm -v && \
    python3 --version && \
    aws --version && \
    docker --version

# Add buildspec.yml or other optional files if needed (example)
# ADD buildspec.yml /codebuild/buildspec.yml

# Set environment variables
ENV PATH=/var/lang/bin:$PATH

# Set a default command for Lambda (replace `app.lambda_handler` with your handler function)
CMD ["app.lambda_handler"]

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
RUN yum install https://rpm.nodesource.com/pub_18.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
RUN yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1
# Install Docker CLI (for building Docker images inside the environment)
RUN curl -fsSL https://get.docker.com/ | sh

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

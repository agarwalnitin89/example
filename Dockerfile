# Use an official Node.js image as the base
FROM node:20-bullseye

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools and Maven
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    git \
    openjdk-11-jdk \
    maven \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Twistcli (replace with the appropriate URL for your environment)
# RUN curl -L -o /usr/local/bin/twistcli "https://downloads.twistlock.com/cli/latest/twistcli" \
#     && chmod +x /usr/local/bin/twistcli

# Verify installations
RUN node -v && npm -v && mvn -v && java -version

# Set working directory (optional)
WORKDIR /app

# Add additional tools or configurations here if needed

# Default command (can be overridden)
CMD ["node"]

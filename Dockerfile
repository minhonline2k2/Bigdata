FROM ubuntu:22.04

# Tránh hỏi tương tác khi cài gói
ENV DEBIAN_FRONTEND=noninteractive

# Cài Java 8 (Hadoop chạy ổn định nhất với JDK 8) + công cụ cần thiết
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk wget ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Tải và giải nén Hadoop
ENV HADOOP_VERSION=3.3.6
RUN wget -q https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz -C /opt && \
    mv /opt/hadoop-${HADOOP_VERSION} /opt/hadoop && \
    rm hadoop-${HADOOP_VERSION}.tar.gz

# Set biến môi trường
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Hadoop cần JAVA_HOME khai báo trong file cấu hình của nó
RUN echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

WORKDIR /workspace
CMD ["/bin/bash"]

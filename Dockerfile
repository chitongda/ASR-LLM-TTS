# 使用基础的 Ubuntu 镜像
FROM ubuntu:22.04

# 避免 apt 安装过程中的交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统包并安装必要的工具
RUN apt-get update && apt-get install -y \
    wget \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 安装 NVIDIA 容器运行时所需的包
RUN apt-get update && apt-get install -y \
    nvidia-container-runtime \
    && rm -rf /var/lib/apt/lists/*

# 安装 Python 3 和 pip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# 安装项目所需的 Python 依赖
COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip3 install -r requirements.txt

# 复制项目文件到容器中
COPY . /app

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 暴露端口（根据项目需要）
EXPOSE 50000

# 运行命令（根据项目需要）
CMD ["python3", "server.py"]
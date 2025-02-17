# 使用 Ubuntu 22.04 作为基础镜像
FROM ubuntu:22.04

# 更新软件源并安装 gnupg 工具，用于处理 GPG 密钥
RUN apt-get update && apt-get install -y gnupg

# 导入缺失的 GPG 公钥
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 871920D1991BC93C

# 修复密钥环文件权限
RUN chmod a+r /etc/apt/trusted.gpg.d/*.gpg

# 更新软件源并安装必要的工具
RUN apt-get update && apt-get install -y \
    wget \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 后续可以添加项目的安装、配置和启动命令
# 例如，复制项目文件到工作目录
COPY . .

# 暴露端口
EXPOSE 8080

# 启动应用程序
CMD ["python", "app.py"]

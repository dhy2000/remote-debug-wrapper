# Docker SSH Wrapper

将命令行交互程序 (编程作业) 封装成 SSH 服务，方便对拍且避免了源代码泄漏。

## 系统要求

Linux 系统, 已安装 Docker。

## 使用方法

将要提供给他人对拍的程序放入 `app` 目录中, 并在 `run.c` 中修改运行命令。

运行 `./build-docker.sh` 构建 Docker 镜像, 运行 `./start-docker.sh` 启动 Docker 容器。

SSH 默认用户名: `run`, 默认密码: `123456`（写在 `Dockerfile` 中），Docker 默认监听宿主机端口: `10022`（写在 `start-docker.sh` 中）。

使用 `sshpass` 工具免去交互输入 ssh 密码, 并在 ssh 连接时不进行 `known_hosts` 验证:

```shell
sshpass -p 123456 ssh run@localhost -p 10022 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null
```

本项目仅给出基于 `openjdk:8-jdk-alpine3.9` 镜像（ alpine base, Java environment ）的示例，如需其他运行环境则需要修改 `Dockerfile`。编写 `Dockerfile` 需要含有以下要素:

- 安装 SSH Server 并启动服务
- 创建调试用户, 并指定其 login shell
  - 由于 login shell 必须是一个不带参数的可执行文件，所以用 C 语言编写了一个 `run.c` 以封装实际的运行命令。

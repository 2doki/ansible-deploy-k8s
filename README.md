### bin-install-kubernetes

* *说明*
```
- 这是一个二进制搭建的单master节点的k8s集群
- 可以用作学习使用，不能在生产环境中使用
- 使用ansible主从模式部署k8s集群
  在ansible主节点上生成k8s证书和k8s相关配置
  在ansible从节点[k8s集群节点]进行k8s集群部署 
```

* *使用*
```
- 根据实际情况调整项目目录下的hosts文件配置和group_vars/all.yaml中的配置
- 依次运行:
  ansible-playbook com.yaml
  ansible-playbook master.yaml
  ansible_playbook worker.yaml
```

* *注意*
```
- 所有服务组件的可执行文件都用upx工具进行了压缩
- 压缩示例: upx --best --ultra-brute -9 etcd
- 解压示例: upx -d etcd
- 压缩后的可执行文件可能会有性能上的损失
```

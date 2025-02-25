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

- 测试 playbook
  ansible-playbook --check com.yaml
  ansible-playbook --check master.yaml
  ansible-playbook --check worker.yaml

- 依次运行:
  ansible-playbook com.yaml
  ansible-playbook master.yaml
  ansible_playbook worker.yaml

- 在安装了kubectl的节点上运行:
  kubectl create -f others/bootstrap.secret.yaml
```

* *注意*
```
- 所有服务组件的可执行文件都用upx工具进行了压缩

- 压缩示例: upx --best --ultra-brute -9 etcd

- 解压示例: upx -d etcd

- 压缩后的可执行文件可能会有性能上的损失
```

* **以下步骤需要在安装完成后在k8s节点上执行**
```
kubectl config set-cluster kubernetes     \
--certificate-authority=/usr/local/k8s/cert//ca.pem     \
--embed-certs=true     --server=https://127.0.0.1:6443     \
--kubeconfig=/usr/local/k8s/config/bootstrap-kubelet.kubeconfig

kubectl config set-credentials tls-bootstrap-token-user     \
--token=c8ad9c.2e4d610cf3e7426e \
--kubeconfig=/usr/local/k8s/config/bootstrap-kubelet.kubeconfig


kubectl config set-context tls-bootstrap-token-user@kubernetes     \
--cluster=kubernetes     \
--user=tls-bootstrap-token-user     \
--kubeconfig=/usr/local/k8s/config/bootstrap-kubelet.kubeconfig

kubectl config use-context tls-bootstrap-token-user@kubernetes     \
--kubeconfig=/usr/local/k8s/config/bootstrap-kubelet.kubeconfig
```


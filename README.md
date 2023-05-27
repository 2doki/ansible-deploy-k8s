### bin-deploy-k8s

* *说明*
```
- 系统: Ubuntu 22.04.2 LTS
- k8s版本: v1.27.1
- 此项目是使用ansible部署k8s集群(单master节点)
- 修改hosts文件
- 此项目采用ansible进行部署,并使用pmd工具进行python的包管理
- 全局安装pdm工具([参考官网](https://github.com/pdm-project/pdm))
- 运行本项目的机器需要与部署k8s集群的集群实现免密登录
```
* *使用*
```
- 根据项目下的hosts文件node_name设置节点的主机名: hostnamectl set-hostname node_name
- 下载本项目到本地,在项目的根目录运行: pdm install 安装ansible依赖
- 在项目的根目录运行: pdm run ansible-playbook master.yaml部署k8s-master节点
- 在项目的根目录运行: pdm run ansible-playbook worker.yaml部署k8s-worker节点
- 如果需要添加k8s-worker节点,则修改hosts文件的[worker]部分的内容
```
* *注意*
```
- 所有服务组件的可执行文件都用upx工具进行了压缩
- 压缩示例: upx --best --ultra-brute -9 etcd
- 解压示例: upx -d etcd
- 压缩后的可执行文件可能会有性能上的损失
```

* *批准节点加入集群*
- for n in ($(kubectl get csr|awk '{print $1}'|grep -v 'NAME'));do kubectl certificate approve $n; done
- 查看结果: kubectl get csr
<!--
注意:
  - 部署calico.yaml时,镜像拉取失败,使用如下命令在每个节点上导入对应的镜像包(calico.yaml中所有的镜像)
    ctr -n k8s.io images import node.tar 
参考: https://www.haxi.cc/archives/setup-k8s-1-23-1-cluster-using-binary.html 
-->

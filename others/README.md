### k8s插件

* **安装cilium**
- helm repo add cilium https://helm.cilium.io
- helm pull cilium/cilium  && tar xvf cilium-*.tgz
- helm install  cilium ./cilium/ -n kube-system
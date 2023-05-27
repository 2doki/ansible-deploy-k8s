cfssl gencert -initca ca-csr.json | cfssljson -bare ca -
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes etcd-csr.json | cfssljson -bare etcd
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-apiserver-csr.json | cfssljson -bare kube-apiserver
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-proxy-csr.json | cfssljson -bare kube-proxy
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-scheduler-csr.json | cfssljson -bare kube-scheduler
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kubectl-csr.json | cfssljson -bare kubectl


# 创建文件目录
[ ! -d ../roles/etcd/files ] && mkdir -p ../roles/etcd/files
[ ! -d ../roles/master/files ] && mkdir -p ../roles/master/files
[ ! -d ../roles/worker/files ] && mkdir -p ../roles/worker/files


# 拷贝证书到指定路面
cp ca.pem etcd.pem etcd-key.pem  ../roles/etcd/files
cp ca.pem ca-key.pem etcd.pem etcd-key.pem  ../roles/master/files

cp kubectl.pem kubectl-key.pem ../roles/master/files
cp kube-apiserver.pem kube-apiserver-key.pem ../roles/master/files
cp kube-controller-manager.pem kube-controller-manager-key.pem ../roles/master/files
cp kube-scheduler.pem kube-scheduler-key.pem ../roles/master/files

cp ca.pem kube-proxy.pem kube-proxy-key.pem ../roles/worker/files


# 拷贝token.csv到指定目录
cp token.csv ../roles/master/files
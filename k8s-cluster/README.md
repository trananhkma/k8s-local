# Setting up
### Install dependency packages on host machine
``` 
$ sudo chmod +x host_install.sh
$ ./host_install.sh
```
### Launch VMs
```
$ vagrant up
```
### Apply salt state
```
salt '*' state.apply
```
### Setup k8s masters
```
$ vagrant ssh master1
$ sudo kubeadm init --control-plane-endpoint "192.168.68.5:6443" --upload-certs
```
`Note:` Save all output of above command
```
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
```
$ kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```
### Check service status and wait for all change to `running`
```
$ kubectl get pod -n kube-system
```
```
$ exit
```
### Join other master nodes (do same things with master3)
```
$ vagrant ssh master2
```
```
$ sudo kubeadm join 192.168.68.5:6443 --token s8xy3j.rubokkgevog3k10g \
    --discovery-token-ca-cert-hash sha256:d42fcc6dcff132f6a785e3d5d69f48b469433bc7f75831247b51528be78fe612 \
    --control-plane --certificate-key 871ff9de5db7d36fb941e860d295b160c1196063224c9c71778adda657f08d6c
```
### Join all worker nodes (do same thing with worker2 and worker3)
```
$ vagrant ssh worker1
```
```
$ sudo kubeadm join 192.168.68.5:6443 --token s8xy3j.rubokkgevog3k10g \
    --discovery-token-ca-cert-hash sha256:d42fcc6dcff132f6a785e3d5d69f48b469433bc7f75831247b51528be78fe612
```
### Validate on master1:
```
$ kubectl get nodes
```




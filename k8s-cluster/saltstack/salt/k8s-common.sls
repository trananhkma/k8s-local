docker_prerequisites:
  pkg.latest:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - software-properties-common
  pkgrepo.managed:
    - humanname: Docker
    - name: "deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ salt['grains.get']('oscodename') }} stable"
    - file: /etc/apt/sources.list.d/docker.list
    - gpgcheck: 1
    - key_url: https://download.docker.com/linux/ubuntu/gpg

docker-ce:
  pkg.latest: []
  require:
    - pkgrepo: docker_prerequisites
    - pkg: docker_prerequisites
  service.running:
    - name: docker
    - enable: True
    - restart: True

k8s_prerequisites:
  pkgrepo.managed:
    - humanname: Kubernetes
    - name: "deb https://apt.kubernetes.io/ kubernetes-xenial main"
    - file: /etc/apt/sources.list.d/kubernetes.list
    - gpgcheck: 1
    - key_url: https://packages.cloud.google.com/apt/doc/apt-key.gpg

k8s:
  pkg.latest:
    - pkgs:
      - kubelet
      - kubeadm
      - kubectl
  require:
    - pkgrepo: k8s_prerequisites
nginx:
  pkg.latest:
    - refresh: True
  service.running:
    - reload: True
    - enable: True
    - watch:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/tcpconf.d/kubernetes.conf

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/nginx.conf
    - require:
      - pkg: nginx
    - require_in:
      - file: /etc/nginx/tcpconf.d/kubernetes.conf

/etc/nginx/tcpconf.d/kubernetes.conf:
  file.managed:
    - source: salt://nginx/kubernetes.conf
    - makedirs: True
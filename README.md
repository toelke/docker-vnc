[![ci](https://github.com/toelke/docker-vnc/actions/workflows/build-docker.yaml/badge.svg?branch=main)](https://github.com/toelke/docker-vnc/actions/workflows/build-docker.yaml)

# Run graphical applications in docker and access them via the webbrowser

Quick demo:

```shell
docker build -t docker-firefox -f Dockerfile.firefox . && docker run --rm -p 6080:6080 docker-firefox
```

then open your browser to http://localhost:6080 and use the username `vncuser` and password `asdasd` to connect. You can change the password by passing `-e PASSWORD=mypassword` to `docker run`.

Note: Firefox might have opened on virtual screen 9...

`Dockerfile` contains everything you need as a base-image (vnc-server, window manager and webserver). `Dockerfile.firefox` shows how to add new software (including auto-starting it).

## Run in kubernetes

You can run this in kubernetes as a side-car:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-x
  namespace: pr
  labels:
    app: text-x
spec:
  nodeSelector:
    kubernetes.io/arch: amd64
  volumes:
    - name: xauth
      emptyDir: {}
  containers:
    - name: x
      image: toelke158/docker-vnc
      ports:
        - containerPort: 6080
      volumeMounts:
        - mountPath: /home/vncuser/.Xauthority
          subPath: ".Xauthority"
          name: xauth
    - name: firefox
      image: nixery.dev/shell/firefox/cacert
      command:
        - bash
        - -c
        - "DISPLAY=127.0.0.1:1 firefox"
      volumeMounts:
        - mountPath: /root/.Xauthority
          subPath: ".Xauthority"
          name: xauth
```

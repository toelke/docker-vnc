# Run graphical applications in docker and access them via the webbrowser

Quick demo:

```shell
docker build -t docker-vnc . && docker build --pull=false -t docker-firefox -f Dockerfile.firefox . && docker run --rm -p 6080:6080 docker-firefox
```

then open your browser to http://localhost:6080 and use the password `asdasd` to connect. You can change the password by passing `--build-arg PASSWORD=mypassword` to `docker build`.

`Dockerfile` contains everything you need as a base-image (vnc-server, window manager and webserver). `Dockerfile.firefox` shows how to add new software (including auto-starting it).

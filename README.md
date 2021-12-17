# Rootless Docker on Centos7

Running Docker containers and daemon rootless on a Centos7 VM via Vagrant.

## Requirements

### Vagrant

* [Download vagrant](https://www.vagrantup.com/downloads) and follow the installer's instructions.
* Install the Virtualbox Guest Additions via the following command:

  ```shell
  vagrant plugin install vagrant-vbguest
  ```

  **Note:** you will receive the mount errors described in [Vagrant No VirtualBox Guest Additions installation found](https://www.devopsroles.com/vagrant-no-virtualbox-guest-additions-installation-found-fixed/).
* Enable autocompletion:

  ```shell
  vagrant autocomplete install --bash
  ```

## Build and Run

Bring up CentOS7 virtual machine and a rootless Docker process as `docky`:

```shell
vagrant up
```

SSH into the VM and switch to the `docky` user:

```shell
vagrant ssh
```

```shell
[vagrant@centos7 ~]# sudo su - docky
```

Verify Docker is running correctly using the `hello-world` image:

```shell
-bash-4.2$ docker run hello-world
```

Try out a web server like nginx:

```shell
-bash-4.2$ docker run -p 80:80 -d nginx:1.18-alpine
```

This should fail as a non-root docker may not expose a container on a privileged port (<1024). Try a different web application like the Ghost blog:

```shell
-bash-4.2$ docker run -p 2368:2368 -d ghost
```

On your local machine open a web browser and navigate to http://localhost:2368 (made possible by an existing Vagrant `forwarded_port`).

## Teardown

Tearing down the VM is done with a single command:

```shell
vagrant destroy -f
```

See [Vagrant: Destroy](https://www.vagrantup.com/docs/cli/destroy) for additional information.

## Resources

* [Run the Docker daemon as a non-root user (Rootless mode)](https://docs.docker.com/engine/security/rootless/)
* [Isolate containers with a user namespace](https://docs.docker.com/engine/security/userns-remap/)
* [Setting up Docker with user namespaces on CentOS 7.4](https://gist.github.com/mjuric/c519d470eac60b08de5ed735ff5a2ef9)
* [Experimenting with Rootless Docker](https://medium.com/@tonistiigi/experimenting-with-rootless-docker-416c9ad8c0d6)
* [Container Security: A Look at Rootless Containers](https://medium.datadriveninvestor.com/container-security-a-look-at-rootless-containers-7c2ea6f6842)
* [Docker Running In Rootless Mode](https://itnext.io/docker-running-in-rootless-mode-bdbcfc728b3a)

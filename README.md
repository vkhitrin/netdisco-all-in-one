# Netdisco All-In-One Container

**Disclaimer**: This container is not encouraged for production usage, use it only as part of development.

**Disclaimer**: [This container will not work on k8s deployments that forbid writing to `/` or `/root`.](https://docs.bridgecrew.io/docs/bc_k8s_21)

## Info

This container is an all-in-one deployment of [Netdisco](http://netdisco.org/) application.

An alpine container is used and a PostgreSQL database will be installed on top of it.  
Database credentials:
```
DB name: netdisco
Username: netdisco
Password: netdisco
```

Netdisco binaries will be installed from CPAN.

Admin user will be created with the credentials:
```shell
Username: admin
Password: admin
```

SNMP community `public` is used by default.  
In order to modify the configuration edit `container_files/environments/deployment.yml` file. Refer to [Netdisco Documentation - Configuration](https://github.com/netdisco/netdisco/wiki/Configuration#reports).

## Building

There are no special requirements for this container.

It can be built using docker/podman/buildah.
```bash
docker build . -t <IMAGE_NAME>
```

## Usage

The container contains an init script and doesn't expect any parameter to be passed during execution.

```bash
docker run -it --rm -p 5000:5000 localhost/netdisco-all-in-one
```

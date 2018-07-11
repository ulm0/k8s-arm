# Kubernetes for ARM

This tiny script was created to easily install Docker + Kubernetes on Raspbian / [HypriotOS](#hypriotos) / Ubuntu.

It installs [kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl), one of the recommended docker versions (as mentioned in [install-kubeadm/#installing-docker](https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-docker)) and then sets on hold docker to avoid being upgraded whenever `apt-get upgrade` is executed.

## Usage

* Simply run `wget -qO - https://git.io/fNI01 | sudo bash -`

* Or download the script into your RPi.

``` sh
wget -q https://git.io/fNI01 -O k8s-arm && \
chmod +x k8s-arm && \
echo y | ./k8s-arm
```

**NOTE:** it must be run as `root` or `sudo`.

### Options

```sh
    -h            Print this help
    -v            Print version info
    -l            List available versions
    -i [version]  Specify docker version to install
```

### Installing a given version

You can specify a version to install as follows `./k8s-arm -i 17.12`.

**NOTE:** *If a version is not specified, then* `17.03` *is going to be installed.*

#### List of available versions

| **Version** | **State**|
|:-:|:-:|
| `18.03.1` | Might work |
| `18.03.0` | Might work |
| `17.12.1` | Works |
| `17.12.0` | Works |
| `17.09.1` | Works |
| `17.09.0` | Works |
| `17.06.2` | Works |
| `17.06.1` | Works |
| `17.06.0` | Works |
| `17.03.2` | **Default** |
| `17.03.1` | Recommended |
| `17.03.0` | Recommended |

## HypriotOS

It's a docker-ready raspbian-based distro for Raspberry Pi. Get it [here](https://github.com/hypriot/image-builder-rpi/releases).

You can use [flash](https://github.com/hypriot/flash) (a utility developed by the HypriotOS Team) to flash the image on the SD card.

## More info about Kubernetes and ARM

* https://github.com/luxas/kubeadm-workshop
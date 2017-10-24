# Kubernetes for ARM

This tiny script was created to easily install Docker + Kubernetes on *a fresh install* (recommended) Raspbian/HypriotOS.

It installs [kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl), one of the recommended docker versions (as mentioned in [install-kubeadm/#installing-docker](https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-docker)) and then sets on hold docker to avoid being upgraded whenever `apt-get upgrade` is executed.

## Usage

* Simply run `wget -qO - https://git.io/vdhfK | sudo bash -`

* Or clone this repo into your RPi, grant execution permission `chmod +x install.sh`. **It must run as root or sudo.**

### Options

```sh
    -h            Print this help
    -v            Print version info
    -l            List available versions
    -i [version]  Specify docker version to install
```

**NOTE:** if `-i` is not used, a default version *(1.12.6)* will be installed.

### Installing a given version

All you need to do is choose one version and use it as follows `install.sh -i 17.03.0~ce-0~raspbian-jessie`.

#### List of available versions

* `17.05.0~ce-0~raspbian-jessie` (Not tested)
* `17.04.0~ce-0~raspbian-jessie` (Not tested)
* `17.03.1~ce-0~raspbian-jessie` (Might work)
* `17.03.0~ce-0~raspbian-jessie` (Recommended)
* `1.13.1-0~raspbian-jessie` (Recommended)
* `1.13.0-0~raspbian-jessie` (Recommended)
* `1.12.6-0~raspbian-jessie` (Recommended | **Default**)
* `1.12.5-0~raspbian-jessie` (Recommended)
* `1.12.4-0~raspbian-jessie` (Recommended)
* `1.12.3-0~jessie` (Recommended)
* `1.12.2-0~jessie` (Recommended)
* `1.12.1-0~jessie` (Recommended)

## More info about Kubernetes and ARM

* https://github.com/luxas/kubeadm-workshop
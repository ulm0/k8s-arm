# Kubernetes for ARM

This tiny script was created to easily install Docker + Kubernetes on *a fresh install* (recommended) Raspbian/[HypriotOS](#hypriotos).

It installs [kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl), one of the recommended docker versions (as mentioned in [install-kubeadm/#installing-docker](https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-docker)) and then sets on hold docker to avoid being upgraded whenever `apt-get upgrade` is executed.

## Usage

* Simply run `wget -qO - https://git.io/vFLXv | sudo bash -`

* Or download the script into your RPi.

``` sh
wget -q https://git.io/vFLXv -O k8s-arm && \
chmod +x k8s-arm && \
./k8s-arm
```

**Note:** it must be run as root or sudo.

### Options

```sh
    -h            Print this help
    -v            Print version info
    -l            List available versions
    -i [version]  Specify docker version to install
```

**NOTE:** if `-i` is not used, a default version *(1.12.6)* will be installed.

### Installing a given version

All you need to do is choose one version and use it as follows `k8s-arm -i 17.03.0~ce-0~raspbian-jessie`.

#### List of available versions

* `17.05.0~ce-0~raspbian-jessie` (Not tested)
* `17.04.0~ce-0~raspbian-jessie` (Not tested)
* `17.03.1~ce-0~raspbian-jessie` (Might work)
* `17.03.0~ce-0~raspbian-jessie` (Works)
* `1.13.1-0~raspbian-jessie` (Works)
* `1.13.0-0~raspbian-jessie` (Works)
* `1.12.6-0~raspbian-jessie` (Recommended | **Default**)
* `1.12.5-0~raspbian-jessie` (Recommended)
* `1.12.4-0~raspbian-jessie` (Recommended)
* `1.12.3-0~jessie` (Recommended)
* `1.12.2-0~jessie` (Recommended)
* `1.12.1-0~jessie` (Recommended)

## HypriotOS

It's a docker-ready raspbian-based distro for Raspberry Pi. Get it [here](https://github.com/hypriot/image-builder-rpi/releases).

You can use [Flash](https://github.com/hypriot/flash) (a utility developed by the HypriotOS Team) to flash the image on the SD card.

## More info about Kubernetes and ARM

* https://github.com/luxas/kubeadm-workshop
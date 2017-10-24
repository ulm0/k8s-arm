#!/bin/sh

set -e

_echo(){
    echo ${@}
}

_tee(){
    tee ${@}
}

_curl(){
    curl ${@}
}

update(){
    _echo "Updating..."
    apt-get -qq update
}

get_keys(){
    _echo -e "\033[1mGetting key for \033[32m${1}\033[0m"
    _curl -fsSL "${1}" | apt-key add -
}

add_repo(){
    _echo -e "\033[1mAdding repo to \033[32m${1}\033[0m"
    _echo "${2}" | tee "${1}"
}

install_docker(){
    if [ -s /etc/apt/sources.list.d/docker.list ]; then
        rm -f /etc/apt/sources.list.d/docker.list
    fi
    get_keys "https://apt.dockerproject.org/gpg"
    add_repo "/etc/apt/sources.list.d/docker.list" "deb [arch=armhf] https://apt.dockerproject.org/repo raspbian-jessie main"
    update
    _echo "Installing Docker..."
    apt-get install -qq -y docker-engine=17.03.1~ce-0~raspbian-jessie
    _echo "Setting hold docker-engine..."
    apt-mark -qq hold docker-engine
}

install_kubernetes(){
    get_keys "https://packages.cloud.google.com/apt/doc/apt-key.gpg"
    add_repo "/etc/apt/sources.list.d/kubernetes.list" "deb http://apt.kubernetes.io/ kubernetes-xenial main"
    update
    apt-get install -qq -y kubelet kubeadm kubectl
}

_echo "This will install Kubernetes & D ocker on your Raspbian/HypriotOS system"
update
_echo "Installing dependencies..."
apt-get install -qq -y apt-transport-https

if [ -s $(which docker) ]; then
    _echo "Removing previous docker installation..."
    apt-get -qq -y remove docker-ce docker.io docker-engine
fi
install_docker
install_kubernetes
_echo "Done"
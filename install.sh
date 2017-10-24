#!/usr/bin/env bash

set -e

function print_version(){
    echo "Kubernetes for ARM v1.0"
    exit 1
}

function print_help() {
    echo "Usage: $0"
    echo "    -h            Print this help"
    echo "    -v            Print version info"
    echo "    -l            List available versions"
    echo "    -i [version]  Specify docker version to install"
    echo
    echo "You must specify a docker version. See:"
    echo "https://github.com/untalpierre/k8s-arm#installing-a-given-version"
    exit 1
}

function docker_versions(){
    info "Docker" "List of available versions"
    echo "  - 17.05.0~ce-0~raspbian-jessie      | Not tested"
    echo "  - 17.04.0~ce-0~raspbian-jessie      | Not tested"
    echo "  - 17.03.1~ce-0~raspbian-jessie      | Might work"
    echo "  - 17.03.0~ce-0~raspbian-jessie      | Recommended"
    echo "  - 1.13.1-0~raspbian-jessie          | Recommended"
    echo "  - 1.13.0-0~raspbian-jessie          | Recommended"
    echo "  - 1.12.6-0~raspbian-jessie          | Recommended | Default"
    echo "  - 1.12.5-0~raspbian-jessie          | Recommended"
    echo "  - 1.12.4-0~raspbian-jessie          | Recommended"
    echo "  - 1.12.3-0~jessie                   | Recommended"
    echo "  - 1.12.2-0~jessie                   | Recommended"
    echo "  - 1.12.1-0~jessie                   | Recommended"
    exit 1
}

# Display an error message and quit
function bail() {
    FG="1;31m"
    BG="40m"
    echo -en "[\033[${FG}\033[${BG}Error\033[0m] "
    echo "$*"
    exit 1
}

# Display an info message
function info() {
    task="$1"
    shift
    FG="1;32m"
    BG="40m"
    echo -e "[\033[${FG}\033[${BG}${task}\033[0m] $*"
}

# Refresh repos
function update(){
    info "Updating..."
    apt-get -qq update
}

# Get GPG Keys
function get_keys(){
    info "Keys" "Getting key for ${1}"
    curl -fsSL "${1}" | apt-key add -
}

# Add a given repo
function add_repo(){
    info "Repo" "Adding to ${1}"
    echo "${2}" | tee "${1}"
}

# Install Docker
function install_docker(){
    if [[ -s $(which docker) ]]; then
        info "Docker" "Previous installation found..."
        remove_prev_docker
    fi
    get_keys "https://apt.dockerproject.org/gpg"
    add_repo "/etc/apt/sources.list.d/docker.list" "deb [arch=armhf] https://apt.dockerproject.org/repo raspbian-jessie main"
    update
    info "Docker" "Installing..."
    apt-get install -qq -y docker-engine=${1}
    info "Docker" "Setting on hold..."
    apt-mark -qq hold docker-engine
}

# Look for previous docker installation and remove it
function remove_prev_docker(){
    info "Docker" "Removing existing installation..."
    apt-get -qq -y remove docker docker-ce docker.io docker-engine
    apt-get -qq -y autoremove docker docker-ce docker.io docker-engine
    apt-get -qq -y purge docker docker-ce docker.io docker-engine
    if [[ -s /etc/apt/sources.list.d/docker.list ]]; then
        info "Docker" "Removing old source repo..."
        rm -f /etc/apt/sources.list.d/docker.list
    fi
}

# Install K8s
function install_kubernetes(){
    get_keys "https://packages.cloud.google.com/apt/doc/apt-key.gpg"
    add_repo "/etc/apt/sources.list.d/kubernetes.list" "deb http://apt.kubernetes.io/ kubernetes-xenial main"
    update
    info "Kubernetes" "Installing..."
    apt-get install -qq -y kubelet kubeadm kubectl
}

if [[ $EUID -ne 0 ]]; then
    bail "must be run as root. try: sudo install.sh"
fi

# Handle arguments:
args=$(getopt -uo 'hvli:' -- $*)
[ $? != 0 ] && print_help
set -- $args

for i
do
    case "$i"
    in
        -h)
            print_help
            ;;
        -v)
            print_version
            ;;
        -l)
            docker_versions
            ;;
        -i)
            docker_version="$2"
            echo "Docker version = ${2}"
            shift
            shift
            ;;
    esac
done

if [[ -z "$docker_version" ]]; then
    info "Start" "No docker version specified, using default"
    docker_version="1.12.6-0~raspbian-jessie"
fi

info "Start" "Will remove any docker installed on your system"
info "Start" "and install a suitable docker version for kubernetes"
read -p "Really proceed? (y)es / (n)o " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Quitting."
    exit
fi

    update
info "Deps" "Installing apt-transport-https..."
    apt-get install -qq -y apt-transport-https
    install_docker "${docker_version}"
    install_kubernetes
info "Info" "Docker and Kuberntes have been installed"
info "Info" "You might want to check:"
info "Info" "docker version"
info "Info" "kubectl version"
info "Info" "kubeadm version"
info "Info" "kubelet version"
info "Info" "Enjoy...!"
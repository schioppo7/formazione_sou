# DevOps Academy Exercises

A collection of small hands-on exercises completed during DevOps training.

The suggested path starts with Bash fundamentals and then moves to virtual
machines, containers, web services and troubleshooting. Each exercise includes a
short README with its purpose and instructions.

## Technologies

- Bash and Unix command-line tools
- Python and Go
- Vagrant and Linux virtual machines
- Docker and Podman
- Apache, `curl` and `nc`

## Roadmap

### 1. Bash foundations

- [Basic scripts](exercises/bash/basic-scripts/) - first scripts, output and system file backups.
- [Commented scripts](exercises/bash/commented-scripts/) - variables, parameters, exit codes and permissions.

### 2. Shell problem solving

- [Strings](exercises/bash/strings/) - process text with Bash, Python and Unix tools.
- [Metrics](exercises/bash/flow-control/), [process checks](exercises/bash/process-check/) and [port scanning](exercises/bash/port-scanner/) - practice flow control, system inspection and networking.

### 3. Virtual machines

- [Basic VM](exercises/vagrant/basic-vm/) - create and provision a Linux machine with Vagrant.
- [Ping-pong nodes](exercises/vagrant/ping-pong/) - work with two connected virtual machines.

### 4. Containers

- [Go server with Podman](exercises/containers/podman-golang/) - build and run a small HTTP service.
- [Container management](exercises/containers/container-management/) - practice container operations across two virtual machines.

### 5. Web and troubleshooting

- [HTTP response codes](exercises/web/http-response-codes/) - configure and test Apache responses.
- [Disk full simulation](exercises/bonus/disk-full/) - observe failures when a test system runs out of space.

## How to use the repository

Follow the roadmap in order or open the topic you want to practice. Run Vagrant
commands from the folder containing the related `Vagrantfile`, and use a
disposable virtual machine when an exercise changes system resources.

# Port scanner

Bash script that tests a range of TCP ports on an IP address.

It requires Bash and `nc`.

Example:

    ./scanner.sh 192.168.56.10 80 100

The `Vagrantfile` creates a `target` machine and a `scanner` machine.

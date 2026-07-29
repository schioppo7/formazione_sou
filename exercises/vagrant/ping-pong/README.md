# Ping-pong between two nodes

The `Vagrantfile` creates two virtual machines named `node1` and `node2`.

The script chooses a node based on the current minute and starts or stops the `ping` container.

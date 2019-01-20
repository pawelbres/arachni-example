==== Running arachni server ====

Firstly you need to run:

    wget -O ./arachni-1.5.1-0.5.12-linux-x86_64.tar.gz https://github.com/Arachni/arachni/releases/download/v1.5.1/arachni-1.5.1-0.5.12-linux-x86_64.tar.gz
    docker build --target arachni_server -t arachni/server:rc2 .
    docker build --target arachni_worker -t arachni/worker:rc3 .

Then:

     docker run --rm -d arachni/server:rc2
     docker run --rm -d arachni/worker:rc3

And then you need to login onto your first conainer on port 9292 and add dispatcher to the rpcd at port 7331. Next thing should be creation of a new scan profile and running it.

=== Hint:

You can add another dispatcher with:

    docker run --rm -d arachni/worker:rc3 --address 0.0.0.0 --neighbour=<ip_of_the_previous_dispatcher>:7331


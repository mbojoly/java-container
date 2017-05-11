docker build -t rafabene/java-container:openjdk -f Dockerfile.openjdk .
docker build -t rafabene/java-container:openjdk-env -f Dockerfile.openjdk-env .
docker build -t rafabene/java-container:fabric8 -f Dockerfile.fabric8 .
docker build -t mbojoly/java-container:openjdk-9-env -f Dockerfile.openjdk-9-env .
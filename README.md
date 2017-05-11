# java-container
Demo project for Java Applications running inside containers - Using Spring Boot


Build and Deploy java-container locally
---------------------------------------

1. Open a command prompt and navigate to the root directory of this application.
2. Type this command to build and execute the application:

        mvn clean compile spring-boot:run

3. The application will be running at the following URL: <http://localhost:8080/api/hello>
4. You can trigger the allocation of 80% of JVM memory accessing <http://localhost:8080/api/memory>


Test with Java 9
----------------
A docker image using JDK 9 has been added. The version used is `OpenJDK 64-Bit Server VM (build 9-Debian+0-9b168-1, mixed mode)`.

The same behaviour can be observed as in the initial [article](https://developers.redhat.com/blog/2017/03/14/java-inside-docker/).

```
docker run -it --rm --name mycontainer150 -p 8080:8080 -m 150M mbojoly/java-container:openjdk-9-env
```

```
Allocated more than 80% (217.5 MiB) of the max allowed JVM memory size (235.9 MiB)
```
The difference is very low compared to the article (less than 2.5%)
```
$ docker logs mycontainer150 | grep -i MaxHeapSize
   size_t MaxHeapSize                              = 255852544                                {product} {ergonomic}
```


With the new option `UseCGroupMemoryLimitForHeap` the behaviour is now much more intuitive : 62.5 MB of Heap is allocated. 
```
docker run -it --rm --name mycontainer150 -p 8080:8080 -m 150M -e JAVA_OPTIONS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap" mbojoly/java-container:openjdk-9-env
```

```
Starting to allocate memory...
Allocated more than 80% (62.5 MiB) of the max allowed JVM memory size (73.5 MiB)
```

The container limit is 150 MB. The `-m=150M` option means that 150M of RAM and 150MB of RAM can be allocated.
So the JVM with the new option see 300 MB of RAM. Maximum Heap Size is 1/4 of the physical memory: 0.25*300=75 MB
We can check it in the log: we find 76 MB.
```
$ docker logs mycontainer150 | grep -i MaxHeapSize
   size_t MaxHeapSize                              = 79691776                                 {product} {ergonomic}
```

And a bit more than 80% of this Max Heap Size (0.8*76=60.8 MB) is allocated without problem.








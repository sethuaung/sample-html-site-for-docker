# Step-by-Step

## Step 1 — Create a Directory for the Website

We’ve created a folder to store all of the resources for this demo. We can 
make our own HTML files and save them in our local directory or our can 
download the source code from my GitHub 
[repository](https://github.com/sethuaung/sample-html-site-for-docker). We 
can clone the repository using:
```
git clone https://github.com/sethuaung/sample-html-site-for-docker.git
```
  ```
cd sample-html-site-for-docker
```

## Step 2 — Create a file called Dockerfile

We will create a Dockerfile to build a custom image and add our commands 
to the file. Notice that in the directory, I have created a Dockerfile 
with below commands:
```
FROM nginx:alpine  
COPY . /usr/share/nginx/html
```
We start building our custom image by using a base image. On line 1, we 
can see we do this using the _FROM_ command to pull the _nginx:alpine_ 
image to our machine and then build our custom image on top of it.

Next, we _COPY_ the contents of the current directory into the 
_/usr/share/nginx/html_  directory inside the container provided by 
_nginx:alpine_ image.

We’ll notice that we did not add an _ENTRYPOINT_ or a _CMD_  to our 
**Dockerfile**. We will use the underlying _ENTRYPOINT_  and _CMD_ 
provided by the base **NGINX image**.

## Step 3 — Build the Docker Image for the HTML Server

To build our image, run the following command:
```
docker build -t html-server-image:v1 .
```
The build command will tell Docker to execute the commands located in our 
Dockerfile. When we build an image, by default, it just gets a hexadecimal 
ID, which we can use to refer to it later (for example, to run it). These 
IDs aren’t particularly memorable or easy to type, so Docker allows us to 
give the image a human-readable name using the _-t_ switch to _docker 
build_.

Docker build command to build our image

We can confirm that this has worked by running this command to check all 
available images:
```
docker images
```

Docker images command to list available images

## Step 4 — Run the Docker Container

Programs running in a container are isolated from other programs running 
on the same machine, which means they can’t have direct access to 
resources like network ports.

The **_demo application_** listens for connections on port 80, but this is 
the _container’s_ own _private port 80_, not a port on our computer. In 
order to connect to the container’s port 80, we need to _forward_ a port 
on our local machine to that port on the container. It could be (_almost_) 
any port, including 80, but we’ll use _8080_ instead to make it clear 
which is our port and which is the container’s.

To tell Docker to forward a port, we can use the _-p_ switch:
```
docker run -d -p 8080:80 html-server-image:v1
```
Once the container is running as a _daemon_ (_-d)_, any requests to 8080 
on the local computer will be forwarded automatically to 80 on the 
container, which is how we’re able to connect to the app with our browser.

[**Note**] Any port number below 1024 is considered a _priviliged port_, 
meaning that in order to use those ports, our process must run as a user 
with special permissions, such as _root_. Normal non-administrator users 
cannot use ports below 1024.

## Step 5 — Test the Port

We’re now running our own copy of the demo application, and we can check 
it by browsing the URL (_http://localhost:8080/_).

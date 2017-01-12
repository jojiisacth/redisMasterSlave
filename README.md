## Redis Master Slave
This is an experimental master slave set up on kubetnets
###  	Steps . 
#### 		1. Create a linux virtiual machine (if you are running a non-linux machine) 

1. Install vagrant & virtual box 
2. Run the script in terminal 
	```sh
		vagrant up
		vagrant ssh
		cd /vagrant
		
	```
#### 		2. Build the redis image 
Prereq: install docker if you are  skipping step 1  
1. Run the script in terminal 
	```sh
	
		docker build -t myredis3.2   .
	
	```
2. see whether the image is build as below . 
	```sh
		docker  images
	```
	You should see below out put 
	```
		[vagrant@redisimagebuilderv1 vagrant]$ docker  images
		REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
		myredis3            latest              9c58c6fe09bc        About a minute ago   9.399 MB
		alpine              3.5                 88e169ea8f46        2 weeks ago          3.98 MB
	```
	
#### 		3. Test the redis image 
1. Run the script in terminal 
	```sh
		docker run -e MASTER=true  myredis3
	
	```
	
	

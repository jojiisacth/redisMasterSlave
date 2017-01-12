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
	```sh
		
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
	You should see below out put 
	```sh
		
					    _.-``    `.  `_.  ''-._           Redis 3.2.5 (c72176ef/0) 64 bit
			  .-`` .-```.  ```\/    _.,_ ''-._                                   
			 (    '      ,       .-`  | `,    )     Running in standalone mode
			 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
			 |    `-._   `._    /     _.-'    |     PID: 6
			  `-._    `-._  `-./  _.-'    _.-'                                   
			 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
			 |    `-._`-._        _.-'_.-'    |           http://redis.io        
			  `-._    `-._`-.__.-'_.-'    _.-'                                                        


	```
	
#### 		4. Push the image to a docker repository .  
1. Run the script in terminal 
	```sh
	
		# tag the image .  
    		docker tag myredis3 jojiisacth/redis . 
		# push the image  
    		docker push   jojiisacth/redis
		
	```
	
	
#### 		5. Running the redis in kubernets cluster . 

Prereq: 1. You should have a running  kubernets cluster and acces to it . 
	2. kubectl  installed  
1. Open a terminal in the K8 folder where we have YAML files are ressent . 
2  Run the script in terminal 
	
	
		 kubectl create  -f masterRs.yaml 
		 kubectl create  -f masterSrv.yaml 
		 kubectl create  -f slaveRs.yaml 
		 
	
#### 		6. Testing the deployment.
1  Run the script in terminal 		
		kubectl get pods
   You should see out put as below 
 
 
 		NAME                READY     STATUS    RESTARTS   AGE
		redismaster-yrq92   1/1       Running   0          33s
		redisslave-a01ko    1/1       Running   0          14s
		redisslave-gwm1n    1/1       Running   0          14s
		
		

		


  #### 		7. Testing the redis master slave . 
  1.  Bash into master  
  
  		kubectl exec -it redismaster-yrq92 bash
		
  2. Open redis command line utility and add some data to redis 
  
		bash-4.3# 
		redis-cli
		127.0.0.1:6379> set mykey  myvalue
		OK
		127.0.0.1:6379> get mykey
		"myvalue"
		
  3.  Bash into slave  
  
  		kubectl exec -it redismaster-yrq92 bash
		
  2. Open redis command line utility and add some data to redis 
  
		kubectl exec -it redisslave-a01ko  bash
		bash-4.3#                                                                                                                                                                                               
		bash-4.3# redis-cli  
		127.0.0.1:6379> get mykey
		"myvalue"
		
		127.0.0.1:6379> set my key  chnaged
		(error) READONLY You can't write against a read only slave.
		127.0.0.1:6379> 

		
 
  

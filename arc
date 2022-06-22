Pre-requistes:
Jenkins Master is already setup and running

Steps involved:
-----------------------------------
1. Setup EC2 instance for slave
2. Create jenkins user and Install Java, Maven in Slave node
3. upload public keys from master to slave node.
4. verify ssh connection from master to slave
5. Register slave node in Jenkins master
6. Run build jobs in Jenkins slave

Slave node configuration
-------------------------------------------------------
(You need to use new micro or small Ubuntu instance for this slave)
only port 22 needs to be open

Install Java
----------------------------------------------------
sudo apt-get update
sudo apt-get install default-jdk -y

Install Maven
-----------------------------------------------
sudo apt-get install maven -y

Create User as Jenkins
---------------------------------------------
sudo useradd -m jenkins
sudo -u jenkins mkdir /home/jenkins/.ssh

Add SSH Keys from Master to Slave:

Execute the below command in Jenkins master EC2.
-----------------------------------------------
sudo cat ~/.ssh/id_rsa.pub

Copy the output of the above command:
------------------------------------------------------

Now Login to Slave node and execute the below command
------------------------------------------------------
sudo -u jenkins vi /home/jenkins/.ssh/authorized_keys

This will be empty file, now copy the public keys from master into above file.
Once you pasted the public keys in the above file in Slave, come out of the file by entering wq!

Now go into master node
ssh jenkins@slave_node_ip


this is to make sure master is able to connect slave node. once you are successfully logged into slave, type exit to come out of slave.

Now copy the SSH keys into /var/lib/jenkins/.ssh by executing below command in master(make sure you exited from slave by typing exit command:

sudo cp ~/.ssh/known_hosts  /var/lib/jenkins/.ssh

Because jenkins master will look keys from the above folder.
Register slave node in Jenkins:
Now to go Jenkins Master, manage jenkins, manage nodes.



Click on new node. give name and check permanent agent.
give name and no of executors as 1. enter /home/jenkins as remote directory.
select launch method as Launch slaves nodes via SSH.
enter Slave node ip address as Host.

click on credentials. Enter user name as jenkins. Make jenkins lowercase as it is shown.
 Kind as SSH username with private key. enter private key of master node directly by executing below command:


sudo cat ~/.ssh/id_rsa
(Make sure you copy the whole key including the below without missing anything)
-----BEGIN RSA PRIVATE KEY-----
-----
-----END RSA PRIVATE KEY-----

click Save.
select Host key verification strategy as "manually trusted key verification strategy".

Click Save.
Click on launch agent..make sure it connects to agent node.

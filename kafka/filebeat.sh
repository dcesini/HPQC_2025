################   DO THE FOLLOWING AS ROOT ###################
###############################################################


rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
vim /etc/yum.repos.d/elastic.repo

################## This repo should look like the following ######
[root@ip-172-31-90-58 ~]# cat /etc/yum.repos.d/elastic.repo

[elastic-8.x]
name=Elastic repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
autorefresh=1
type=rpm-md
##################################################

yum install filebeat
systemctl enable filebeat
vim /etc/filebeat/filebeat.yml

######################################
#### The filebeat.yml file should look like the following
######################################

filebeat.inputs:

# Each - is an input. Most options can be set at the input level, so
# you can use different inputs for various configurations.
# Below are the input-specific configurations.

# filestream is an input for collecting log messages from files.
- type: filestream

  # Unique ID among all inputs, an ID is required.
  id: my-filestream-id

  # Change to true to enable this input configuration.
  enabled: true

  # Paths that should be crawled and fetched. Glob based paths.
  paths:
    - /home/ec2-user/LogSimulator/logsimulator.log
    #- c:\programdata\elasticsearch\logs\*

# ============================== Filebeat modules ==============================

filebeat.config.modules:
  # Glob pattern for configuration loading
  path: ${path.config}/modules.d/*.yml

  # Set to true to enable config reloading
  reload.enabled: true

  # Period on which files under path should be checked for changes
  #reload.period: 10s


# ---------------------------- Elasticsearch Output ----------------------------
#output.elasticsearch:
  # Array of hosts to connect to.
  # hosts: ["localhost:9200"]

  # Performance preset - one of "balanced", "throughput", "scale",
  # "latency", or "custom".
  #preset: balanced

  # Protocol - either `http` (default) or `https`.
  #protocol: "https"

  # Authentication credentials - either API key or username/password.
  #api_key: "id:api_key"
  #username: "elastic"
  #password: "changeme"


  #output.file:
  #path: "/tmp/filebeat"
  #filename: filebeat


output.kafka:
  enabled: true
  hosts: ["localhost:29094","localhost:29095","localhost:29096"]
  topic: "MY_FIRST_TOPIC"
  partition.round_robin:
    reachable_only: false
  required_acks: 1
  compression: none


##############################################################################################################
##############################################################################################################

systemctl restart filebeat

########### filebeat logs in tail -f /var/log/filebeat/filebeat-*


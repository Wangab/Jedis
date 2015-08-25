PATH := ./redis-git/src:${PATH}

define REDIS1_CONF
daemonize yes
port 6379
requirepass foobared
pidfile /tmp/redis1.pid
logfile /tmp/redis1.log
save ""
appendonly no
client-output-buffer-limit pubsub 256k 128k 5
endef

define REDIS2_CONF
daemonize yes
port 6380
requirepass foobared
pidfile /tmp/redis2.pid
logfile /tmp/redis2.log
save ""
appendonly no
endef

define REDIS3_CONF
daemonize yes
port 6381
requirepass foobared
masterauth foobared
pidfile /tmp/redis3.pid
logfile /tmp/redis3.log
save ""
appendonly no
endef

define REDIS4_CONF
daemonize yes
port 6382
requirepass foobared
masterauth foobared
pidfile /tmp/redis4.pid
logfile /tmp/redis4.log
save ""
appendonly no
slaveof localhost 6381
endef

define REDIS5_CONF
daemonize yes
port 6383
requirepass foobared
masterauth foobared
pidfile /tmp/redis5.pid
logfile /tmp/redis5.log
save ""
appendonly no
slaveof localhost 6379
endef

define REDIS6_CONF
daemonize yes
port 6384
requirepass foobared
masterauth foobared
pidfile /tmp/redis6.pid
logfile /tmp/redis6.log
save ""
appendonly no
endef

define REDIS7_CONF
daemonize yes
port 6385
requirepass foobared
masterauth foobared
pidfile /tmp/redis7.pid
logfile /tmp/redis7.log
save ""
appendonly no
slaveof localhost 6384
endef

# SENTINELS
define REDIS_SENTINEL1
port 26379
daemonize yes
sentinel monitor mymaster 127.0.0.1 6379 1
sentinel auth-pass mymaster foobared
sentinel down-after-milliseconds mymaster 2000
sentinel failover-timeout mymaster 120000
sentinel parallel-syncs mymaster 1
pidfile /tmp/sentinel1.pid
logfile /tmp/sentinel1.log
endef

define REDIS_SENTINEL2
port 26380
daemonize yes
sentinel monitor mymaster 127.0.0.1 6381 1
sentinel auth-pass mymaster foobared
sentinel down-after-milliseconds mymaster 2000
sentinel parallel-syncs mymaster 1
sentinel failover-timeout mymaster 120000
pidfile /tmp/sentinel2.pid
logfile /tmp/sentinel2.log
endef

define REDIS_SENTINEL3
port 26381
daemonize yes
sentinel monitor mymasterfailover 127.0.0.1 6384 1
sentinel auth-pass mymasterfailover foobared
sentinel down-after-milliseconds mymasterfailover 2000
sentinel failover-timeout mymasterfailover 120000
sentinel parallel-syncs mymasterfailover 1
pidfile /tmp/sentinel3.pid
logfile /tmp/sentinel3.log
endef

define REDIS_SENTINEL4
port 26382
daemonize yes
sentinel monitor mymaster 127.0.0.1 6381 1
sentinel auth-pass mymaster foobared
sentinel down-after-milliseconds mymaster 2000
sentinel parallel-syncs mymaster 1
sentinel failover-timeout mymaster 120000
pidfile /tmp/sentinel4.pid
logfile /tmp/sentinel4.log
endef

# CLUSTER REDIS NODES
define REDIS_CLUSTER_NODE1_CONF
daemonize yes
port 7379
cluster-node-timeout 50
pidfile /tmp/redis_cluster_node1.pid
logfile /tmp/redis_cluster_node1.log
save ""
appendonly no
cluster-enabled yes
cluster-config-file /tmp/redis_cluster_node1.conf
endef

define REDIS_CLUSTER_NODE2_CONF
daemonize yes
port 7380
cluster-node-timeout 50
pidfile /tmp/redis_cluster_node2.pid
logfile /tmp/redis_cluster_node2.log
save ""
appendonly no
cluster-enabled yes
cluster-config-file /tmp/redis_cluster_node2.conf
endef

define REDIS_CLUSTER_NODE3_CONF
daemonize yes
port 7381
cluster-node-timeout 50
pidfile /tmp/redis_cluster_node3.pid
logfile /tmp/redis_cluster_node3.log
save ""
appendonly no
cluster-enabled yes
cluster-config-file /tmp/redis_cluster_node3.conf
endef

define REDIS_CLUSTER_NODE4_CONF
daemonize yes
port 7382
cluster-node-timeout 50
pidfile /tmp/redis_cluster_node4.pid
logfile /tmp/redis_cluster_node4.log
save ""
appendonly no
cluster-enabled yes
cluster-config-file /tmp/redis_cluster_node4.conf
endef

define REDIS_CLUSTER_NODE5_CONF
daemonize yes
port 7383
cluster-node-timeout 5000
pidfile /tmp/redis_cluster_node5.pid
logfile /tmp/redis_cluster_node5.log
save ""
appendonly no
cluster-enabled yes
cluster-config-file /tmp/redis_cluster_node5.conf
endef

define REDIS_CLUSTER_NODE6_CONF
daemonize yes
port 7384
cluster-node-timeout 5000
pidfile /tmp/redis_cluster_node6.pid
logfile /tmp/redis_cluster_node6.log
save ""
appendonly no
cluster-enabled yes
cluster-config-file /tmp/redis_cluster_node6.conf
endef

export REDIS1_CONF
export REDIS2_CONF
export REDIS3_CONF
export REDIS4_CONF
export REDIS5_CONF
export REDIS6_CONF
export REDIS7_CONF
export REDIS_SENTINEL1
export REDIS_SENTINEL2
export REDIS_SENTINEL3
export REDIS_SENTINEL4
export REDIS_CLUSTER_NODE1_CONF
export REDIS_CLUSTER_NODE2_CONF
export REDIS_CLUSTER_NODE3_CONF
export REDIS_CLUSTER_NODE4_CONF
export REDIS_CLUSTER_NODE5_CONF
export REDIS_CLUSTER_NODE6_CONF

start: cleanup
	echo "$$REDIS1_CONF" | redis-server -
	echo "$$REDIS2_CONF" | redis-server -
	echo "$$REDIS3_CONF" | redis-server -
	echo "$$REDIS4_CONF" | redis-server -
	echo "$$REDIS5_CONF" | redis-server -
	echo "$$REDIS6_CONF" | redis-server -
	echo "$$REDIS7_CONF" | redis-server -
	echo "$$REDIS_SENTINEL1" > /tmp/sentinel1.conf && redis-server /tmp/sentinel1.conf --sentinel
	@sleep 0.5
	echo "$$REDIS_SENTINEL2" > /tmp/sentinel2.conf && redis-server /tmp/sentinel2.conf --sentinel
	@sleep 0.5
	echo "$$REDIS_SENTINEL3" > /tmp/sentinel3.conf && redis-server /tmp/sentinel3.conf --sentinel
	@sleep 0.5
	echo "$$REDIS_SENTINEL4" > /tmp/sentinel4.conf && redis-server /tmp/sentinel4.conf --sentinel
	echo "$$REDIS_CLUSTER_NODE1_CONF" | redis-server -
	echo "$$REDIS_CLUSTER_NODE2_CONF" | redis-server -
	echo "$$REDIS_CLUSTER_NODE3_CONF" | redis-server -
	echo "$$REDIS_CLUSTER_NODE4_CONF" | redis-server -
	echo "$$REDIS_CLUSTER_NODE5_CONF" | redis-server -
	echo "$$REDIS_CLUSTER_NODE6_CONF" | redis-server -

cleanup:
	- rm -vf /tmp/redis_cluster_node*.conf 2>/dev/null
	- rm dump.rdb appendonly.aof - 2>/dev/null

stop:
	kill `cat /tmp/redis1.pid`
	kill `cat /tmp/redis2.pid`
	kill `cat /tmp/redis3.pid`
	kill `cat /tmp/redis4.pid`
	kill `cat /tmp/redis5.pid`
	kill `cat /tmp/redis6.pid`
	kill `cat /tmp/redis7.pid`
	kill `cat /tmp/sentinel1.pid`
	kill `cat /tmp/sentinel2.pid`
	kill `cat /tmp/sentinel3.pid`
	kill `cat /tmp/sentinel4.pid`
	kill `cat /tmp/redis_cluster_node1.pid` || true
	kill `cat /tmp/redis_cluster_node2.pid` || true
	kill `cat /tmp/redis_cluster_node3.pid` || true
	kill `cat /tmp/redis_cluster_node4.pid` || true
	kill `cat /tmp/redis_cluster_node5.pid` || true
	kill `cat /tmp/redis_cluster_node6.pid` || true
	rm -f /tmp/sentinel1.conf
	rm -f /tmp/sentinel2.conf
	rm -f /tmp/sentinel3.conf
	rm -f /tmp/redis_cluster_node1.conf
	rm -f /tmp/redis_cluster_node2.conf
	rm -f /tmp/redis_cluster_node3.conf
	rm -f /tmp/redis_cluster_node4.conf
	rm -f /tmp/redis_cluster_node5.conf
	rm -f /tmp/redis_cluster_node6.conf

test:
	make start
	sleep 2
	mvn -Dtest=${TEST} clean compile test
	make stop

package:
	make start
	mvn clean package
	make stop

deploy:
	make start
	mvn clean deploy
	make stop

format:
	mvn java-formatter:format

release:
	make start
	mvn release:clean
	mvn release:prepare
	mvn release:perform -DskipTests
	make stop

travis-install:
	[ ! -e redis-git ] && git clone https://github.com/antirez/redis.git redis-git || true
	make -C redis-git -j4

.PHONY: test

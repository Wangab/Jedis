[![Build Status](https://travis-ci.org/xetorthio/jedis.png?branch=master)](https://travis-ci.org/xetorthio/jedis)

# Jedis

Jedis is a blazingly small and sane [Redis](http://github.com/antirez/redis "Redis") java client.

Jedis was conceived to be EASY to use.

Jedis is fully compatible with redis 2.8.x and 3.0.x.

## Community

Meet us on IRC: ##jedis on freenode.net

Join the mailing-list at [http://groups.google.com/group/jedis_redis](http://groups.google.com/group/jedis_redis)

## So what can I do with Jedis?
All of the following redis features are supported:

- Sorting
- Connection handling
- Commands operating on any kind of values
- Commands operating on string values
- Commands operating on hashes
- Commands operating on lists
- Commands operating on sets
- Commands operating on sorted sets
- Transactions
- Pipelining
- Publish/Subscribe
- Persistence control commands
- Remote server control commands
- Connection pooling
- Sharding (MD5, MurmurHash)
- Key-tags for sharding
- Sharding with pipelining
- Scripting with pipelining
- Redis Cluster

## How do I use it?

You can download the latest build at: 
    http://github.com/xetorthio/jedis/releases

Or use it as a maven dependency:

```xml
<dependency>
    <groupId>redis.clients</groupId>
    <artifactId>jedis</artifactId>
    <version>2.7.2</version>
    <type>jar</type>
    <scope>compile</scope>
</dependency>
```

To use it just:
    
```java
Jedis jedis = new Jedis("localhost");
jedis.set("foo", "bar");
String value = jedis.get("foo");
```

For more usage examples check the tests.

Please check the [wiki](http://github.com/xetorthio/jedis/wiki "wiki"). There are lots of cool things you should know, including information about connection pooling.

And you are done!

## Jedis Cluster

Redis cluster [specification](http://redis.io/topics/cluster-spec) (still under development) is implemented

```java
Set<HostAndPort> jedisClusterNodes = new HashSet<HostAndPort>();
//Jedis Cluster will attempt to discover cluster nodes automatically
jedisClusterNodes.add(new HostAndPort("127.0.0.1", 7379));
JedisCluster jc = new JedisCluster(jedisClusterNodes);
jc.set("foo", "bar");
String value = jc.get("foo");
```

## FAQ

- Do you have strange stack traces?
- You're getting errors when running jedis in multi-threaded environments?
- Do you need further instructions about pipelining, transactions or sentinel?

Please check the [WIKI](https://github.com/xetorthio/jedis/wiki) for more useful information.


## I want to contribute!

That is great!

Please see CONTRIBUTING.md on project's root directory for follow up how to contribute to Jedis project.

Thanks for helping!

## Sponsorship

YourKit supports open source projects with its full-featured Java Profiler.
YourKit, LLC is the creator of [YourKit Java Profiler](http://www.yourkit.com/java/profiler/index.jsp) 
and [YourKit .NET Profiler](http://www.yourkit.com/.net/profiler/index.jsp),
innovative and intelligent tools for profiling Java and .NET applications.

![YourKit Logo](https://cloud.githubusercontent.com/assets/1317309/4507430/7119527c-4b0c-11e4-9245-d72e751e26ee.png)

## License

Copyright (c) 2011 Jonathan Leibiusky

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.


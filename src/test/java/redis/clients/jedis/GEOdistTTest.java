package redis.clients.jedis;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.junit.Test;

public class GEOdistTTest {
	@Test
	public void testContentionRedis() throws InterruptedException{
		GenericObjectPoolConfig config = new GenericObjectPoolConfig();
		config.setMaxTotal(10);
		config.setMaxWaitMillis(30000);
		
		// 生成多机连接信息列表
		List<JedisShardInfo> shards = new ArrayList<JedisShardInfo>();
		shards.add( new JedisShardInfo("123.57.228.78", 6379) );

//		JedisPool jedisPool = new JedisPool(config, "123.57.228.78", 6379);
		ShardedJedisPool jedisPool = new ShardedJedisPool(config, shards);
//		JedisPool jedisPool = new JedisPool(config, "192.168.1.197", 6379, 20);
		ShardedJedis jedis = jedisPool.getResource();
		
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("name", "王安邦");
//		map.put("age", "16");
//		map.put("sex", "F");
//		
//		jedis.set("wang:ab:login", "hahhahahah");
//		jedis.hmset("wang:ab:map", map);
//		jedis.expire("wang.ab.config", 10);
		
		System.out.println(jedis.get("wang:ab:login"));
		System.out.println(jedis.hmget("wang:ab:map","name","age","sex"));
		System.out.println("两点之间距离:" + jedis.geodist("Guangdong-cities", "Guangzhou", "Foshan" ,"km"));
		jedis.close();
	}
}

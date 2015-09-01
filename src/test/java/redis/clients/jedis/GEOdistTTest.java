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
        @Test
	public void testRedisGEOADD(){
		Long a = jedis.geoadd("BeiJing-cities", 116.2314232, 34.4234563, "HaiDian");
		Long b = jedis.geoadd("BeiJing-cities", 116.5314232, 34.4234563, "ChongWen");
		Long c = jedis.geoadd("BeiJing-cities", 116.1314232, 34.4234563, "Chongwu");
		Long d = jedis.geoadd("Guangdong-cities", 113.7943267, 22.9761989, "Dongguan");
		Long e = jedis.geoadd("Guangdong-cities", 114.0538788, 22.5551603, "Shenzhen");
		Long f = jedis.geoadd("Guangdong-cities", 113.2099647, 23.593675 , "Qingyuan");
		Long f1 = jedis.geoadd("Guangdong-cities", 113.2278442, 23.1255978, "Guangzhou");
		Long f2 = jedis.geoadd("Guangdong-cities", 113.106308, 23.0088312, "Foshan");
		
		System.out.println(a+","+b+","+c+","+d+","+e+","+f +","+f1+","+f2);
	}
	@Test
	public void testRdiesGEOPOS(){
		System.out.println("GPS:" + jedis.geopos("Guangdong-cities", "Guangzhou", "Foshan"));
	}
	@Test
	public void testRedisGEODIST() throws InterruptedException{
		System.out.println("两点之间距离:" + jedis.geodist("Guangdong-cities", "Guangzhou", "Dongguan" ,"km"));
	}
	@Test
	public void testRedisGEORADIUS(){
		System.out.println(jedis.geoRadius("Guangdong-cities", "113.2278442", "23.1255978", "50", "km"));
	}
	@Test
	public void testRedisGEORADIUSBYMEMBER(){
		System.out.println(jedis.geoRediusByMember("Guangdong-cities", "Guangzhou", "50", "km"));
	}
}

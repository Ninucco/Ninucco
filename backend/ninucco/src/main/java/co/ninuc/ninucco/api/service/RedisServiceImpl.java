package co.ninuc.ninucco.api.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class RedisServiceImpl implements RedisService{
    private final StringRedisTemplate stringRedisTemplate;
    public void setRedisStringValue(String key, String value){
        ValueOperations<String, String> stringStringValueOperations = stringRedisTemplate.opsForValue();
        stringStringValueOperations.set(key, value);
    }
    public String getRedisStringValue(String key){
        ValueOperations<String, String> stringStringValueOperations = stringRedisTemplate.opsForValue();
        String value = stringStringValueOperations.get(key);
        return value!=null?value:key;
    }

    public List<String> getAllRedisKeyValuePairs(){
        ValueOperations<String, String> stringStringValueOperations = stringRedisTemplate.opsForValue();
        Set<String> redisKeys = stringRedisTemplate.keys("*");
        List<String> ret = new ArrayList<>();
        Iterator<String> it = redisKeys.iterator();
        while(it.hasNext()){
            String data = it.next();
            ret.add(data+": "+stringStringValueOperations.get(data));
        }
        return ret;
    }
}

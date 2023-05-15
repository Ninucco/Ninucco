package co.ninuc.ninucco.api.service;

import java.util.List;

public interface RedisService {
    void setRedisStringValue(String key, String value);
    String getRedisStringValue(String key);
    List<String> getAllRedisKeyValuePairs();
}

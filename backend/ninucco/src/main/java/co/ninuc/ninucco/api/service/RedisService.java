package co.ninuc.ninucco.api.service;

public interface RedisService {
    void setRedisStringValue(String key, String value);
    String getRedisStringValue(String key);
}

require 'redis'
redis = Redis.new(host: "185.143.172.248", db: 1)
$level1 = {}
redis.keys.each do |key|
  $level1[key] = redis.get(key)
end
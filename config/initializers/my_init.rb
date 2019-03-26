require 'redis'
redis1 = Redis.new(host: "185.143.172.248", db: 1)
redis2 = Redis.new(host: "185.143.172.248", db: 2)
$level1 = {}
$level2={}
redis1.keys.each do |key|
  $level1[key] = redis.get(key)
redis2.keys.each do |key|
  $level2[key] = redis.get(key)
end
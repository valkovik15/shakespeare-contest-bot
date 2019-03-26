require 'redis'
$level1 = Redis.new(db: 1)
$level2 = Redis.new(db: 2)

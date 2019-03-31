require 'redis'
$level1 = Redis.new(host: ENV['DB_HOST'], port: 6379, password: ENV['DB_PASSWORD'], db: 1)
$level2 = Redis.new(host: ENV['DB_HOST'], port: 6379, password: ENV['DB_PASSWORD'], db: 2)
$level3 = Redis.new(host: ENV['DB_HOST'], port: 6379, password: ENV['DB_PASSWORD'], db: 3)
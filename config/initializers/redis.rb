$redis = Redis::Namespace.new("search-for-member", :redis => Redis.new)
$redis.flushall
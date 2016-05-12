$redis = Redis::Namespace.new("search-for-member", :redis => Redis.new)
# $redis.del('json_data')
# $redis.del('members_list')
require File.expand_path('../boot', __FILE__)

Instagram.configure do |config|
	config.client_id = CLIENT_ID
	config.access_token = ACCESS_TOKEN
end

client = Instagram.client

follows_array, followed_by_array = [], []
follows_hash, followed_by_hash = {}, {}
nc = 0
begin
	client.user_follows(:count => 100, :cursor => nc).each do |u|
		follows_array << u.id
		follows_hash[u.id] = u.username
		nc = client.next_cursor
	end
end until nc.zero?
begin
	client.user_followed_by(:count => 100, :cursor => nc).each do |u|
		followed_by_array << u.id
		followed_by_hash[u.id] = u.username
		nc = client.next_cursor
	end
end until nc.zero?

pending = followed_by_array - follows_array
pending.each do |id|
	client.follow_user(id)
	#p followed_by_hash[id]
end

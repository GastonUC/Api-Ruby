require 'json'
require 'rest-client'

# markets = Array.new

markets = RestClient.get 'https://www.buda.com/api/v2/markets'
parse = JSON.parse(markets.body)
# hash = parse[:id]

# a = parse['markets'] #LINE 10

# puts a.class == Array
# a.each do |hash|
#     puts hash['name']  #If you transform the Hash on Array like 'Line 10' you can output this.
# end

# puts parse['markets']['name']

# parse.each do | (key, value) 
#     puts value["name"]
# end

# puts parse
# puts parse.class() == Hash

# hash_values = (hash.map {|ha| [ha["id"], ha["name"], ha["base_currency"], ha["quote_currency"], ha["minimum_order_amount"], ha["disabled"], ha["illiquid"], ha["rpo_disabled"]]})
# puts hash_values


# puts parse.each_value {|'id'| puts value}
# puts hashes.any? "id"
# puts hashes.map(&:values)
# puts hashes.flat_map(&:values)

# puts hashes

# result = JSON.parse(markets) #markets.to_s

# id = result[:markets]
# puts id


#url = 'https://www.buda.com/api/v2/markets/eth-btc/volume' #This url will get the last 24hrs transactions for eth-btc
require 'httparty'

#Method to get timestamp in miliseconds.
def timestamp
    now =(Time.now.to_i - 60) * 1000 #now
    oneDay = (Time.now.to_i - 60 * 60 * 24) * 1000 #24hrs before
    return now, oneDay
end

def last_timestamp(market_id)
    response = HTTParty.get("https://www.buda.com/api/v2/markets/#{market_id}/trades")
    last_timestamp = response['trades']['last_timestamp']
    return last_timestamp
end

#Method to get an array with all the current markets
def marketsArray
    response = HTTParty.get('https://www.buda.com/api/v2/markets')
    full_hash = response['markets']
    cant = full_hash.length
    marketArray = []
    cant.times do |index|
        marketArray.append(full_hash[index]['name'])
    end
    return marketArray
end

def check_length_array(arr)
    values = arr.length
    return values
end

#Method to return the values of the last 24hrs transactions for the indicated market.
def gettingGreaterValue(market_id, timestamp)
    response = HTTParty.get("https://www.buda.com/api/v2/markets/#{market_id}/trades?limit=100")
    countTrades = response['trades']['entries']
    #Obtains the count from 'countTrades'
    valueCant = countTrades.length

    valueArray = []
    valueCant.times do |index|
        t = response['trades']['entries'][index][0].to_i
        if t >= timestamp[1]
            valueArray.append(response['trades']['entries'][index][2])
        end
    end
    return valueArray
end

def gettingMoreValues(array, market_id, last_timestamp)
    response = HTTParty.get("https://www.buda.com/api/v2/markets/#{market_id}/trades?timestamp=#{last_timestamp}&limit=100")
    valueCant = response['trades']['entries'].length
    
    valueCant.times do |index|
        t = response['trades']['entries'][index][0].to_i
        if t >= last_timestamp.to_i
            array.append(response['trades']['entries'][index][2])
        end
    end
    return array
end

# puts valueArray[]

def check_greater_100(cant, arr, market, last_timestamp)
    if cant >= 100
        valueArray2 = gettingMoreValues(arr, market, last_timestamp)
        return valueArray2
    else
        return arr
    end
end

#puts marketsArray().class == Array

markets = marketsArray()
for market in markets do
    valueArray = gettingGreaterValue(market, timestamp)
    
    cant = check_length_array(valueArray)
    # lastArray = check_greater_100(cant, valueArray, market, last_timestamp(market))
    
    puts "\n"
    puts "Market: #{market}"
    puts "max-value: #{valueArray.max}"
    #puts "Timestamp: #{timestamp[0]}"
    #puts "cant = #{cant}"

end


# for iter in arr1 do
#     puts "markets: #{iter}"
# end

#To display Array with id of Markets
# for array in arr do
#     puts "Market_id: #{array}"
# end

#puts timestamp

# Market_id = 'eth-btc'


# for ars in arr2 do
#     puts "content: #{ars}"
# end

# value = response1['trades']['entries'][1][2]
# timestampEntrie = response1['trades']['entries'][1][0]
# puts "Value of the transaction: #{value} at #{timestampEntrie}"
#Contains the count of obj in 'entries'
# puts "Objects-quant = #{valueCant}"
# hash = JSON.parse(response1.body) #To convert response into Hash
# puts hash['trades']['entries']

# puts hash.class == Hash #Just to check if it is a Hash


#To display Array with values from Entries
# for array in valueArray do
#     puts "Value: #{array}"
# end
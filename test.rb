require 'httparty'

def timestamp
    now =(Time.now.to_i - 60) * 1000 #now
    oneDay = (Time.now.to_i - 60 * 60 * 24) * 1000 #24hrs before
    return now, oneDay
end

response = HTTParty.get('https://www.buda.com/api/v2/markets/BTC-CLP/trades?limit=100')
response1 = response['trades']['entries']
responses = JSON.parse(response.body)

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
    check_greater_100(valueCant, valueArray, market_id, timestamp)
end

def check_greater_100(cant, arr, market, timestamp)
    if cant >= 100 && 
        valueArray2 = gettingMoreValues(arr, market, timestamp)
        return valueArray2
    else
        return arr
    end
end

def gettingMoreValues(array, market_id, timestamp)
    response = HTTParty.get("https://www.buda.com/api/v2/markets/#{market_id}/trades?timestamp=#{timestamp[1]}&limit=100")
    valueCant = response['trades']['entries'].length
    
    valueCant.times do |index|
        t = response['trades']['entries'][index][0].to_i
        if t >= timestamp[1].to_i
            array.append(response['trades']['entries'][index][2])
        end
    end
    return array
end

valueArray = gettingGreaterValue("BTC-CLP", timestamp)

for arr in valueArray do
    puts "eso: #{arr}"
end

# puts "Last_timestamp = #{response['trades']['last_timestamp']}"

# puts responses['trades']['entries'][0]
# valueCant = response1.length

# valueArray = []
# valueCant.times do |index|
#     t = response['trades']['entries'][index][0].to_i
#     if t >= timestamp[1]
#         valueArray.append(response['trades']['entries'][index][0])
#     end
# end


# puts "Objects array: #{valueArray.length}"

# for arr in valueArray do
#     if arr.to_i >= timestamp[1]
#         puts "Timestamp: #{arr}"
#         puts "index : #{valueArray.find_index(arr)}"
#     else
#         puts "No Timestamp."
#         valueArray.delete_at(valueArray.find_index(arr))
#     end
# end

# for arr1 in valueArray do
#     puts "Final Array: #{arr1}"
# end

# puts "Objects array: #{valueArray.length}"
# puts "24hrs Timestamp: #{timestamp[1]}"
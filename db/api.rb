require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'news-api'

meme_url = URI("https://api.imgflip.com/get_memes")
# unsplash_url= URI("https://api.unsplash.com/search/photos?page=#{rand(1..10)}&query=#{searchterm}&client_id=tiLpw6NIQBzOyXVdnNxVbVpkgLI0mCidl3M7DgbM1wc")
news_url= URI("https://newsapi.org/v2/top-headlines?country=us&apiKey=4356361c0167497ca9323489c48b461ezz")

def get_meme_Api(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
    request = Net::HTTP::Get.new(url)
    request["user-key"] = '8892e6dd302be8678337c69374af2568'
  
    response = http.request(request)
    if response.code == "200"
        result = JSON.parse(response.body)
    end
    memeImg = result["data"]["memes"]
end


def get_unsplash_api(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
    request = Net::HTTP::Get.new(url)
    # request["user-key"] = 'tiLpw6NIQBzOyXVdnNxVbVpkgLI0mCidl3M7DgbM1wc'
  
    response = http.request(request)
    if response.code == "200"
        result = JSON.parse(response.body)
    end
    result["results"].map{|seed| seed["alt_description"]}
    # picture = result["results"].map{|seed|  seed["urls"]["small"]}
end

searchterm="funny"
unsplash_url= URI("https://api.unsplash.com/search/photos?page=1&query=#{searchterm}&client_id=tiLpw6NIQBzOyXVdnNxVbVpkgLI0mCidl3M7DgbM1wc")
# p get_unsplash_api(unsplash_url)

i = 0
searchterm="funny"
unsplash_arr = []
while i < 5 do
    unsplash_url= URI("https://api.unsplash.com/search/photos?page=#{i}&query=#{searchterm}&client_id=tiLpw6NIQBzOyXVdnNxVbVpkgLI0mCidl3M7DgbM1wc")
    unsplash_arr << get_unsplash_api(unsplash_url)
    i+=1
end

# p unsplash_arr.flatten.length
# 4356361c0167497ca9323489c48b461e

def get_news_api(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
    request = Net::HTTP::Get.new(url)
    # request["user-key"] = 'tiLpw6NIQBzOyXVdnNxVbVpkgLI0mCidl3M7DgbM1wc'
  
    response = http.request(request)
    if response.code == "200"
        result = JSON.parse(response.body)
    end

    news = result
end

# p get_unsplash_api(unsplash_url)



# image_name =getApi(url).map{|image| image["name"]}
# image_url = getApi(url).map{|image| image["url"]}

# pp image_name
# pp image_url

# chenyuns_message = ["I", " ", "l", "o", "v", "e", " ", "R", "u", "b", "y"]
# def print_message(msg_array)
#   msg = ""
#   msg_array.each do |letter|
#     msg += letter
#     puts msg
#     end
# end
# print_message(chenyuns_message)

url="https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=JC0T7bCpESCb2SGJBe6axdrSFW0X03H7"

def get_nyt_Api(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    x = JSON.parse(response)

    p x["results"].length
end

get_nyt_Api(url)
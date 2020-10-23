require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'news-api'

searchterm="funny"

meme_url = URI("https://api.imgflip.com/get_memes")
unsplash_url= URI("https://api.unsplash.com/search/photos?page=1&query=#{searchterm}&client_id=tiLpw6NIQBzOyXVdnNxVbVpkgLI0mCidl3M7DgbM1wc")
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

    picture = result["results"].map{|seed|  seed["urls"]["small"]}
    picture.length
end

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


p get_news_api(news_url)

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

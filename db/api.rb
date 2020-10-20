require 'uri'
require 'net/http'
require 'openssl'
require 'json'

url = URI("https://api.imgflip.com/get_memes")

def getApi(url)
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

image_name =getApi(url).map{|image| image["name"]}
image_url = getApi(url).map{|image| image["url"]}

pp image_name
pp image_url
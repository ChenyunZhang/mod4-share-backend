Comment.destroy_all
Like.destroy_all
Relationship.destroy_all
Post.destroy_all
User.destroy_all

Comment.reset_pk_sequence
Like.reset_pk_sequence
Relationship.reset_pk_sequence
Post.reset_pk_sequence
User.reset_pk_sequence

require 'uri'
require 'net/http'
require 'openssl'
require 'json'

# url = URI("https://api.imgflip.com/get_memes")

# def getApi(url)
#     http = Net::HTTP.new(url.host, url.port)
#     http.use_ssl = true
#     http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
#     request = Net::HTTP::Get.new(url)
#     request["user-key"] = '8892e6dd302be8678337c69374af2568'
  
#     response = http.request(request)
#     if response.code == "200"
#         result = JSON.parse(response.body)
#     end
#     return result["data"]["memes"]
# end

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
end

def get_alt_api(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
    request = Net::HTTP::Get.new(url)
    # request["user-key"] = 'tiLpw6NIQBzOyXVdnNxVbVpkgLI0mCidl3M7DgbM1wc'
  
    response = http.request(request)
    if response.code == "200"
        result = JSON.parse(response.body)
    end
    description = result["results"].map{|seed| seed["alt_description"]}
end

i = 0
searchterm="funny"
unsplash_img_arr = []
unsplash_alt_arr = []

while i < 10 do
    unsplash_url= URI("https://api.unsplash.com/search/photos?page=#{i}&query=#{searchterm}&client_id=tiLpw6NIQBzOyXVdnNxVbVpkgLI0mCidl3M7DgbM1wc")
    unsplash_img_arr << get_unsplash_api(unsplash_url)
    i+=1
end

i = 0

while i < 10 do
    unsplash_url= URI("https://api.unsplash.com/search/photos?page=#{i}&query=#{searchterm}&client_id=tiLpw6NIQBzOyXVdnNxVbVpkgLI0mCidl3M7DgbM1wc")
    unsplash_alt_arr << get_alt_api(unsplash_url)
    i+=1
end

image_url = unsplash_img_arr.flatten
image_alt = unsplash_alt_arr.flatten

# image_name =getApi(url).map{|image| image["name"]}
# image_url = getApi(url).map{|image| image["url"]}

User.create(username: "Chenyun", email: "abc123@gmail.com", gender: "I prefer not to say",location: "New York" ,password: "abc123", avatar: "https://images.unsplash.com/photo-1601224503166-47e6afa2fc92?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=400&ixlib=rb-1.2.1&q=80&w=400")
User.create(username: "Micky", email: "abc1234@gmail.com", gender: "I prefer not to say", location: "New York" ,password: "abc123",avatar:"https://images.unsplash.com/photo-1603309832178-2b8956de492f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60")
Relationship.create(follower_id: 1,followed_id: 2)
Relationship.create(follower_id: 2,followed_id: 1)
Post.create(user_id: 1,content: "Cute dog", image: "https://images.unsplash.com/photo-1601224503166-47e6afa2fc92?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=400&ixlib=rb-1.2.1&q=80&w=400")
Post.create(user_id: 2,content: "What a nice day", image: "https://images.unsplash.com/photo-1601877346351-af65828f6d59?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=400&ixlib=rb-1.2.1&q=80&w=400")

50.times do
    User.create(
        username: Faker::Name.name, 
        email: Faker::Internet.email, 
        password: "abc123",
        avatar: image_url[rand(0..100)],
        location: Faker::Address.state,
        gender: "I prefer not to say"
    )
end

30.times do
    Relationship.create(
        follower_id: rand(0..50),
        followed_id: rand(0..50)
    )
end

i = 0
while i<60 do
    Post.create(
        user_id: rand(0..50),
        content: image_alt[i],
        image: image_url[i]
    )
    i+=1
end


30.times do
    Like.create(
        user_id: rand(0..50),
        post_id: rand(0..50)
    )
end

30.times do
    Comment.create(
        user_id: rand(0..50),
        post_id: rand(0..50),
        content: Faker::Quote.most_interesting_man_in_the_world
    )
end

Like.create(user_id: 1, post_id: 1)
Like.create(user_id: 1, post_id: 2)

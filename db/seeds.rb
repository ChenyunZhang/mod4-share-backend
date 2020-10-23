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
    return result["data"]["memes"]
end

image_name =getApi(url).map{|image| image["name"]}
image_url = getApi(url).map{|image| image["url"]}

User.create(username: "Chenyun", email: "abc123@gmail.com", password: "abc123", avatar: "https://images.unsplash.com/photo-1601224503166-47e6afa2fc92?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=400&ixlib=rb-1.2.1&q=80&w=400")
User.create(username: "Micky", email: "abc1234@gmail.com", password: "abc123",avatar:"https://images.unsplash.com/photo-1603309832178-2b8956de492f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60")
Relationship.create(follower_id: 1,followed_id: 2)
Relationship.create(follower_id: 2,followed_id: 1)
Post.create(user_id: 1,content: "Cute dog", image: "https://images.unsplash.com/photo-1601224503166-47e6afa2fc92?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=400&ixlib=rb-1.2.1&q=80&w=400")
Post.create(user_id: 2,content: "What a nice day", image: "https://images.unsplash.com/photo-1601877346351-af65828f6d59?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=400&ixlib=rb-1.2.1&q=80&w=400")

25.times do
    User.create(
        username: Faker::Name.name, 
        email: Faker::Internet.email, 
        password: "abc123",
        avatar: image_url[rand(0..100)]
    )
end

25.times do
    Relationship.create(
        follower_id: rand(0..27),
        followed_id: rand(0..27)
    )
end

i = 0
while i<45 do
    Post.create(
        user_id: rand(0..25),
        content: image_name[i],
        image: image_url[i]
    )
    i+=1
end


20.times do
    Like.create(
        user_id: rand(0..25),
        post_id: rand(0..25)
    )
end

30.times do
    Comment.create(
        user_id: rand(0..27),
        post_id: rand(0..27),
        content: Faker::Quote.most_interesting_man_in_the_world
    )
end

Like.create(user_id: 1, post_id: 1)
Like.create(user_id: 1, post_id: 2)

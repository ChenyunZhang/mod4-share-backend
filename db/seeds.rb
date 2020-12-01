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

require 'Dotenv'

Dotenv.load("../.env")

def get_unsplash_api(url)
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    if response.code == "200"
        result = JSON.parse(response.body)
    end
    picture = result["results"].map{|seed|  seed["urls"]["small"]}
end

def get_alt_api(url)
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    if response.code == "200"
        result = JSON.parse(response.body)
    end
    content = result["results"].map{|seed|  seed["alt_description"]}
end

i = 0
searchterm="funny"
unsplash_img_arr = []
unsplash_alt_arr = []

while i < 10 do
    unsplash_url= URI("https://api.unsplash.com/search/photos?page=#{i}&query=#{searchterm}&client_id=#{ENV["UNSPLASH_ID"]}")
    unsplash_img_arr << get_unsplash_api(unsplash_url)
    i+=1
end

i = 0

while i < 10 do
    unsplash_url= URI("https://api.unsplash.com/search/photos?page=#{i}&query=#{searchterm}&client_id=#{ENV["UNSPLASH_ID"]}")
    unsplash_alt_arr << get_alt_api(unsplash_url)
    i+=1
end

image_url = unsplash_img_arr.flatten
image_alt = unsplash_alt_arr.flatten

# image_name =getApi(url).map{|image| image["name"]}
# image_url = getApi(url).map{|image| image["url"]}

User.create(username: "Mouse", email: "abc123@gmail.com", gender: "I prefer not to say",location: "New York" ,password: "abc123", avatar: "https://images.unsplash.com/photo-1537815749002-de6a533c64db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60")
User.create(username: "Micky", email: "abc1234@gmail.com", gender: "I prefer not to say", location: "New York" ,password: "abc123",avatar:"https://images.unsplash.com/photo-1603309832178-2b8956de492f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60")
Relationship.create(follower_id: 1,followed_id: 2)
Relationship.create(follower_id: 2,followed_id: 1)
Post.create(user_id: 1,content: "Cute dog", image: image_url[rand(0..100)])
Post.create(user_id: 2,content: "What a nice day", image: image_url[rand(0..100)])


70.times do
    User.create(
        username: Faker::Name.name,
        email: Faker::Internet.email,
        password: "abc123",
        avatar: image_url[rand(0..100)],
        location: Faker::Address.state,
        gender: "I prefer not to say"
    )
end

5.times do
    Relationship.create(
        follower_id: rand(0..30),
        followed_id: rand(0..30)
    )
end

i = 0
while i<70 do
    Post.create(
        user_id: rand(0..70),
        content: image_alt[i],
        image: image_url[i]
    )
    i+=1
end


70.times do
    Like.create(
        user_id: rand(0..70),
        post_id: rand(0..70)
    )
end

70.times do
    Comment.create(
        user_id: rand(0..70),
        post_id: rand(0..70),
        content: Faker::Quote.most_interesting_man_in_the_world
    )
end

Like.create(user_id: 1, post_id: 1)
Like.create(user_id: 1, post_id: 2)

puts "😀"
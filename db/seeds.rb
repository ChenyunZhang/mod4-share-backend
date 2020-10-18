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

User.create(username: "cy", email: "abc123@gmail.com", password: "abc123")
User.create(username: "yc", email: "abc234@gmail.com", password: "abc123")
Relationship.create(follower_id: 1,followed_id: 2)
Relationship.create(follower_id: 2,followed_id: 1)
Post.create(user_id: 1,content: "Cute dog", image: "https://images.unsplash.com/photo-1601224503166-47e6afa2fc92?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=400&ixlib=rb-1.2.1&q=80&w=400")
Post.create(user_id: 2,content: "What a nice day", image: "https://images.unsplash.com/photo-1601877346351-af65828f6d59?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=400&ixlib=rb-1.2.1&q=80&w=400")

10.times do
    User.create(
        username: Faker::Name.name, 
        email: Faker::Internet.email, 
        password: "abc123"
    )
end

10.times do
    Relationship.create(
        follower_id: rand(0..12),
        followed_id: rand(0..12)
    )
end

10.times do
    Post.create(
        user_id: rand(0..12),
        content: Faker::Movies::StarWars.quote,
        image: "https://images.unsplash.com/photo-1600615614799-2cd68cb75705?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max"
    )
end

30.times do
    Like.create(
        user_id: rand(0..12),
        post_id: rand(0..12)
    )
end

10.times do
    Comment.create(
        user_id: rand(0..12),
        post_id: rand(0..12),
        content: Faker::Quote.most_interesting_man_in_the_world
    )
end

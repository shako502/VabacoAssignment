require 'faker'

(1..20).each do |id|
    Post.create!(
        id: id,
        title: Faker::TvShows::Suits.character,
        body: Faker::TvShows::Suits.quote,
        mark_for_deletion: Faker::Boolean.boolean(true_ratio: 0.2)
    )
end

(1...26).each do |id|
    Comment.create!(
        id: id,
        post_id: rand(1..20),
        body: Faker::Lorem.sentence(word_count: 3)
    )
end

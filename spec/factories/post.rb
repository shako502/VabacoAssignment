FactoryBot.define do
    factory :post do
        title { Faker::TvShows::Suits.character }
        body { Faker::TvShows::Suits.quote }
        mark_for_deletion { false }

        factory :post_with_comments do
            transient do
                comments_count { 15 }
            end

            after(:create) do |post, evaluator|
                create_list(:comment, evaluator.comments_count, post: post)
                post.reload
            end

        end
    end

    factory :comment do
        body { Faker::ChuckNorris.fact }
        post_id {[association(:post.post_id)]}
    end
end
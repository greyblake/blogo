FactoryGirl.define do
  factory :post, class: Blogo::Post do
    title "How to speak Esperanto"
    sequence(:url) { |n| "how-to-speak-esperanto-#{n}" }
    raw_content "Say Saluton!"
    html_content "<p>Say Saluton!</p>"
    published_at { Time.zone.now }
    association :user

    ignore { tags ['test'] }

    after(:build) do |post, evaluator|
      evaluator.tags.each do |tag_name|
        post.tags << Blogo::Tag.where(name: tag_name).first_or_create!
      end
    end
  end
end

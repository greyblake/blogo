FactoryGirl.define do
  factory :tag, class: Blogo::Tag do
    sequence(:name) { |n| "tag#{n}" }
  end
end

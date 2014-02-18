FactoryGirl.define do
  factory :user, class: Blogo::User do
    name "Ludoviko Zamenhofo"
    sequence(:email) { |n| "ludoviko#{n}@eo.com" }
    password              "sekreto"
    password_confirmation "sekreto"
  end
end

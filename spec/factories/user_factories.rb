FactoryGirl.define do
  factory :user, class: Blogo::User do
    name "Ludoviko Zamenhofo"
    sequence(:email) { |n| "ludoviko#{n}@eo.com" }

    transient { password 'sekreto' }

    after(:build) do |user, evaluator|
      user.password              = evaluator.password
      user.password_confirmation = evaluator.password
    end
  end
end

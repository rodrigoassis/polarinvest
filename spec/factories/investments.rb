FactoryGirl.define do
  factory :investment do |f|
    f.association :asset, factory: :asset
    f.association :user, factory: :user
  end
end
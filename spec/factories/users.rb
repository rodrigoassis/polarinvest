FactoryGirl.define do
  factory :user do |f|
    f.name 'Rodrigo'
    sequence(:email){|n| "rodrigo_#{n}@codepolaris.com" }
    f.password 'pqp2012'
  end
end
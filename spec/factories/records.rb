FactoryGirl.define do
  factory :record do |f|
    f.association :asset, factory: :asset
    f.type 'Saving'
    f.date Time.now
    f.percentage_delta 10.0
    f.value_delta 1.0
    f.value 11.0
  end
end
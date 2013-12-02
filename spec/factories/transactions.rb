FactoryGirl.define do
  factory :transaction do |f|
    f.association :investment, factory: :investment
    f.date Time.now
    f.transaction_type 'Buy'
    f.total_value nil
    f.shares_quantity 9
    f.unit_value 123.99
  end
end
FactoryGirl.define do
  factory :transaction do |f|
    f.association :investment, factory: :investment
    f.date Time.now
    f.transaction_type 'Buy'
    f.total_value 100.0
    f.shares_quantity nil
    f.unit_value nil
  end
end
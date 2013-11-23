FactoryGirl.define do
  factory :asset do |f|
    f.name 'Poupança'
    f.type 'AssetTypes::Saving'
    f.ticker ''
  end
end
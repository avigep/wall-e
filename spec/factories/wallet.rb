FactoryBot.define do
  factory :wallet do
    name { 'test wallet' }
    address { '0x0cd62a4e72e4d2f489773ffaebf687952fc65bc3' }
    trait :invalid_wallet do
      address { '' }
    end
  end
end

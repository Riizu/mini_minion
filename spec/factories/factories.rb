FactoryGirl.define do
  factory :status do
    version
  end

  sequence :vesion do |n|
    "0.0.#{n}"
  end
end

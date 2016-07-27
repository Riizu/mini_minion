FactoryGirl.define do
  factory :status do
    version
  end

  sequence :version do |n|
    "0.0.#{n}"
  end
end

FactoryGirl.define do
  factory :status do
    version
  end

  factory :user do
    name
    uid
    status 0
  end

  sequence :name do |n|
    "Name #{n}"
  end

  sequence :uid do |n|
    n
  end

  sequence :version do |n|
    "0.0.#{n}"
  end
end

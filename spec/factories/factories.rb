FactoryGirl.define do
  factory :status do
    version
  end

  factory :user do
    name
    uid
    status 0
  end

  factory :minion do
    name
    user
  end

  factory :match do
    region "MyString"
    platform_id "MyString"
    mode "MyString"
    type ""
    creation 1
    duration 1
    queue_type "MyString"
    map_id 1
    season "MyString"
    version "MyString"
    participants "MyString"
    blue_team "MyString"
    red_team "MyString"
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

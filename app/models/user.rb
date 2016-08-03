class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  validates :name, presence: true
  validates :status, presence: true
  validates :last_match_pull, presence: true

  has_one :minion
  has_one :summoner

  enum status: [ :registered, :active, :banned, :inactive ]

  def self.facebook_service
    @@fb_service ||= FacebookService.new
  end

  def summoner_service
    @@ss_service ||= SummonerService.new
  end

  def self.login_with_facebook(access_token)
    uid = facebook_service.get_uid(access_token)
    user_result = facebook_service.get_user(uid, access_token)
    user = User.find_or_create_by(uid: user_result["id"]) do |u|
      u.name = user_result["name"]
      u.last_match_pull = Time.now
    end

    return user if user.valid?
  end

  def generate_jwt
    JWT.encode({uid: self.uid, exp: 1.day.from_now.to_i},
                Rails.application.secrets.secret_key_base)
  end

  def add_summoner(summoner_name)
    hash = summoner_service.find_summoners(summoner_name).first[1]
    Summoner.create(id: hash["id"], name: hash["name"],
                    profile_icon_id: hash["profileIconId"],
                    level: hash["summonerLevel"],
                    user_id: self.id)
  end
end

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

  def match_service
    @@ms_service ||= MatchService.new
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

  def update_minion
    matches = get_matches
    minion.assign_xp(matches.count)
    minion.check_for_level_up
    minion.check_hunger
    minion.check_spectator_happiness
  end

  def get_matches
    get_ranked_matches
  end

  def get_ranked_matchlist
    match_service.find_ranked_matchlist(summoner.id, last_match_pull)
  end

  def get_ranked_matches
    matchlist = get_ranked_matchlist
    update_attributes(last_match_pull: Time.now)

    matchlist.map do |match|
      match_hash = match_service.find_ranked_match(match["matchId"])
      new_match = Match.create_from_service(match_hash, summoner)
      summoner.matches << new_match
      new_match
    end
  end

  def add_summoner(summoner_name)
    hash = summoner_service.find_summoners(summoner_name).first[1]
    Summoner.create(id: hash["id"], name: hash["name"],
                    profile_icon_id: hash["profileIconId"],
                    level: hash["summonerLevel"],
                    user_id: self.id)
  end
end

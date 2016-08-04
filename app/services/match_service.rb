class MatchService < RiotService
  def find_matchlist(summoner_id)
    response = connection.get("na/v2.2/matchlist/by-summoner/#{summoner_id}") do |req|
      req.params['rankedQueues'] = "TEAM_BUILDER_DRAFT_RANKED_5x5"
      req.params['seasons'] = "SEASON2016"
      req.params['beginTime'] = "1453248000"
    end
    parse(response)["matches"]
  end

  def find_match(match_id)
    response = connection.get("na/v2.2/match/#{match_id}")
    parse(response)
  end
end

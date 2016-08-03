class MatchService < RiotService
  def find_ranked_matchlist(summoner_id, time)
    response = connection.get("na/v2.2/matchlist/by-summoner/#{summoner_id}") do |req|
      req.params['rankedQueues'] = "TEAM_BUILDER_DRAFT_RANKED_5x5"
      req.params['seasons'] = "SEASON2016"
      req.params['beginTime'] = time.to_i
    end
    parse(response)["matches"]
  end


  def find_ranked_match(match_id)
    response = connection.get("na/v2.2/match/#{match_id}")
    parsed_response = parse(response)
    partial_parse = format_ranked_participants(parsed_response)
    format_ranked_teams(partial_parse)
  end

  def format_ranked_participants(match_hash)
    participants = match_hash["participants"].map do |participant|
      selected_hash = match_hash["participantIdentities"].find do |identity|
        participant["participantId"] == identity["participantId"]
      end
      participant.merge(selected_hash)
    end
    match_hash["participants"] = participants
    match_hash.delete("participantIdentities")
    match_hash
  end

  def format_ranked_teams(match_hash)
    blue_team = format_ranked_blue_team(match_hash)
    red_team = format_ranked_red_team(match_hash)
    match_hash["blue_team"] = blue_team
    match_hash["red_team"] = red_team
    match_hash.delete("teams")
    match_hash
  end

  def format_ranked_blue_team(match_hash)
    match_hash["teams"].find do |team|
      team["teamId"] == 100
    end
  end

  def format_ranked_red_team(match_hash)
    match_hash["teams"].find do |team|
      team["teamId"] == 200
    end
  end
end

class SummonerService < RiotService
  def find_summoners(names)
    response = connection.get("na/v1.4/summoner/by-name/#{names}")
    parse(response)
  end
end

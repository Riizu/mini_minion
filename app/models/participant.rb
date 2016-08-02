class Participant < OpenStruct
  def stats
    Stats.new(self[:stats])
  end

  def timeline
    Timeline.new(self[:timeline])
  end
end

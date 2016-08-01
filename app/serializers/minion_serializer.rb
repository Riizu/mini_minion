class MinionSerializer < ActiveModel::Serializer
  attributes :name, :level, :xp, :current_health, :current_stamina,
             :current_happiness, :total_health, :total_stamina,
             :total_happiness, :last_ate

  def last_ate
    object.last_ate.to_s
  end
end

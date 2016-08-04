class Minion < ActiveRecord::Base
  validates :name, presence: true

  validates_presence_of :user_id

  belongs_to :user

  def level_up
    new_health = calculate_new_health
    new_level = level + 1
    update_attributes(total_health: new_health, level: new_level)
  end

  def take_action(action_name)
    deplete_stamina
    if(action_name == :eat_poro_snack)
      eat_poro_snack
    end
  end

  def eat_poro_snack
    if not_full
      new_health = (self.current_health + 25)
      update_attributes(current_health: new_health, last_ate: Time.now)
    end
  end

  def check_hunger
    if hungry?
      new_happiness = current_happiness - 20
      update_attributes(current_happiness: new_happiness)
    end
  end

  def assign_xp(num_matches)
    new_xp = calculate_xp(num_matches)
    update_attributes(xp: new_xp)
  end

  def level_up?
    return true if xp == (level * 10000)
    false
  end

  def check_for_level_up
    if level_up?
      level_up
    end
  end

  private
    def calculate_xp(num_matches)
      new_xp = (num_matches * 1000) + xp
      if new_xp > (level * 10000)
        new_xp = (level * 10000)
      end
      new_xp
    end

    def not_full
      self.current_health != self.total_health
    end

    def hungry?
      return true if Time.now >= (self.last_ate + 10.minutes)
    end

    def calculate_new_health
      (self.total_health * self.level) + (self.total_happiness / 2)
    end

    def deplete_stamina
      new_stamina = self.current_stamina -
                  ((self.level * 50) -(self.current_happiness / 4))
      update_attributes(current_stamina: new_stamina)
    end
end

class Minion < ActiveRecord::Base
  validates :name, presence: true

  def level_up
    new_health = calculate_new_health
    update_attributes(total_health: new_health)
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

  private
    def not_full
      self.current_health != self.total_health
    end

    def hungry?
      return true if Time.now > self.last_ate
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

require 'rails_helper'

RSpec.describe Minion, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }

  it { should belong_to(:user) }

  it "Should have default stats" do
    minion = create(:minion)

    expect(minion.level).to eq 1
    expect(minion.xp).to eq 0
    expect(minion.last_ate).to_not eq nil
    expect(minion.current_health).to eq 150
    expect(minion.current_happiness).to eq 100
    expect(minion.current_stamina).to eq 100
    expect(minion.total_health).to eq 150
    expect(minion.total_happiness).to eq 100
    expect(minion.total_stamina).to eq 100
  end

  it "Should have total hp that increases when leveling up" do
    minion = create(:minion)
    previous_level = minion.level
    previous_total_hp = minion.total_health
    previous_total_stamina = minion.total_stamina
    previous_total_happiness = minion.total_happiness

    minion.level_up
    expected_hp = (previous_total_hp * previous_level) +
                  (previous_total_happiness / 2)

    expect(minion.total_health).to eq expected_hp
    expect(minion.total_happiness).to eq previous_total_happiness
    expect(minion.total_stamina).to eq previous_total_stamina
    expect(minion.level).to eq 2
  end

  it "Should be able to take an action" do
    minion = create(:minion, current_health: 100)

    minion.take_action(:eat_poro_snack)

    expect(minion.current_health).to eq 125
  end

  it "Should have stamina that depletes when an action is taken" do
    minion = create(:minion)
    previous_current_stamina = minion.current_stamina
    expected_stamina = previous_current_stamina - ((minion.level * 50) -
                       (minion.current_happiness / 4))

    minion.take_action(:eat_poro_snack)

    expect(minion.current_stamina).to eq expected_stamina
  end

  it "Should increase in health by 25 when eating" do
    minion = create(:minion, current_health: 80)
    expected_health = 105

    minion.take_action(:eat_poro_snack)

    expect(minion.current_health).to eq expected_health
  end

  it "Should update its last_ate time after eating" do
    minion = create(:minion, current_health: 90)
    previous_last_ate = minion.last_ate

    minion.take_action(:eat_poro_snack)

    expect(minion.last_ate).to_not eq previous_last_ate
  end

  it "Should not increase in health when eating when its health is full" do
    minion = create(:minion)
    expected_health = 150

    minion.take_action(:eat_poro_snack)

    expect(minion.current_health).to eq expected_health
  end

  it "Should decrease in happiness if it has not ate within 10 minutes" do
    minion = create(:minion, last_ate: "2016-07-31 22:48:45 -0600")

    minion.check_hunger

    expect(minion.current_happiness).to eq 80
  end

  it "Should not decrease in happiness if it has ate within 10 minutes" do
    minion = create(:minion, last_ate: (Time.now - 7.minutes))

    minion.check_hunger

    expect(minion.current_happiness).to eq 100
  end

  it "Should assign xp based on match and count current level" do
    minion = create(:minion)
    minion.assign_xp(5)

    expect(minion.xp).to eq 5000
  end

  it "Should not assign xp past 10,000 times your level" do
    minion = create(:minion)
    minion.assign_xp(11)

    expect(minion.xp).to eq 10000
  end

  it "Should not include previous xp when assigning more" do
    minion = create(:minion, xp: 1000)
    minion.assign_xp(5)

    expect(minion.xp).to eq 6000
  end

  it "Should determine if its time to level up by seeing if xp is 10,000 times your level" do
    minion = create(:minion, xp: 10000)
    result = minion.level_up?

    expect(result).to eq true
  end

  it "Should determine if its not time to level up by seeing if xp is 10,000 times your level" do
    minion = create(:minion, xp: 9000)
    result = minion.level_up?

    expect(result).to eq false
  end

  it "Should check if its time to level up, and level up if so" do
    minion = create(:minion, xp: 10000)
    minion.check_for_level_up

    expect(minion.level).to eq 2
  end

  it "Should check if its time to level up, and not level up if so" do
    minion = create(:minion, xp: 9000)
    minion.check_for_level_up

    expect(minion.level).to eq 1
  end

  it "Should check the time since it last pulled new games and return true if under 1 day" do
    minion = create(:minion)
    result = minion.valid_wait_time_since_last_match?

    expect(result).to eq true
  end

  it "Should check the time since it last pulled new games and return false if over 1 day" do
    minion = create(:minion)
    minion.user.update_attributes(last_match_pull: (Time.now - 2.days))
    result = minion.valid_wait_time_since_last_match?

    expect(result).to eq false
  end

  it "Should check spectator happiness and adjust negatively if its been too long" do
    minion = create(:minion)
    minion.user.update_attributes(last_match_pull: (Time.now - 2.days))
    minion.check_spectator_happiness

    expect(minion.current_happiness).to eq minion.total_happiness - 20
  end

  it "Should check spectator happiness and not adjust if its within the time limit" do
    minion = create(:minion)
    minion.check_spectator_happiness

    expect(minion.current_happiness).to eq minion.total_happiness
  end
end

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
    previous_total_hp = minion.total_health
    previous_total_stamina = minion.total_stamina
    previous_total_happiness = minion.total_happiness

    minion.level_up
    expected_hp = (previous_total_hp * minion.level) +
                  (previous_total_happiness / 2)

    expect(minion.total_health).to eq expected_hp
    expect(minion.total_happiness).to eq previous_total_happiness
    expect(minion.total_stamina).to eq previous_total_stamina
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
end

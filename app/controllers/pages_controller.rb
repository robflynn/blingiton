class CraftTidesprayLinenBracers
  attr_accessor :scenario

  def initialize(scenario:)
    @scenario = scenario
  end

  def run
    @scenario.buy(:nylon_thread)
  end
end

CRAFTS = {
  tidespray_linen_bracers: CraftTidesprayLinenBracers
}

class ShuffleTidesprayLinenToVeiledCrystals
  attr_accessor :inventory, :cost, :gold

  def initialize(inventory:)
    @inventory = inventory
    @cost = 0
    @gold = 0
  end

  def run(num_times: 1)
    craft(:tidespray_linen_bracers)

    return @cost
  end

  def craft(item)
    CRAFTS[item].new(scenario: self).run
  end

  def buy(item)
    @cost = @cost - 10
  end
end


class PagesController < ApplicationController
  def index
    scenario = ShuffleTidesprayLinenToVeiledCrystals.new(inventory: [])
    render json: scenario.run
  end
end

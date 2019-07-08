require 'rbattlenet'

INVENTORY_TIDESPRAY_LINEN = 1378
BUYING_TIDESPRAY_LINEN = 0
TIDESPRAY_LINEN = INVENTORY_TIDESPRAY_LINEN + BUYING_TIDESPRAY_LINEN

TIDESPRAY_TOTAL = 472.0
TIDESPRAY_BLUE_PROCS = 72.0

TIDESPRAY_BLUE_RATIO = TIDESPRAY_BLUE_PROCS / TIDESPRAY_TOTAL

def craft_bracers
  total_made = TIDESPRAY_LINEN / 10

  results = {
    blue: (total_made * TIDESPRAY_BLUE_RATIO).floor
  }

  results[:green] = total_made - results[:blue]

  return results
end

def disenchant_epics(num_epic)
  epic_de = {
    gloom: 0.0 / 134.0,
    umbra: 145.0 / 134.0,
    veiled: 172.0 / 134.0
  }

  {
    gloom_dust: (num_epic * epic_de[:gloom]).floor,
    veiled_crystals: (num_epic * epic_de[:veiled]).floor,
    umbra_shard: (num_epic * epic_de[:umbra]).floor
  }


end

def disenchant_blues(num_blue)
  tidespray_blue_de = {
    gloom: 208.0 / 143.0,
    umbra: 333.0 / 143.0,
    veiled: 43.0 / 143.0
  }

  {
    gloom_dust: (num_blue * tidespray_blue_de[:gloom]).floor,
    veiled_crystals: (num_blue * tidespray_blue_de[:veiled]).floor,
    umbra_shard: (num_blue * tidespray_blue_de[:umbra]).floor
  }
end

def scrap_greens(num_greens)
  scrap_ratio = 134.0 / 791.0

  {
    tidespray_linen: (num_greens * (10 * 0.15)).floor,
    nylon_thread: (num_greens * (5 * 0.15)).floor,
    expulsom: (num_greens * scrap_ratio).floor
  }
end



def wowify(amount)
  gold = amount / 10000

  amount %= 10000

  silver = amount / 100
  copper = amount % 100

  "#{gold}g #{silver}s #{copper}c"
end

def shimmer_scale_to_enchanting_mats
  # The cost of the linen plus the nylon thread
  num_crafted = 200

  materials_used = {
    blood_stained_bone: 4,
    shimmerscale: 6
  }

  cost = 0
  cost += (materials_used[:blood_stained_bone] * price_of(:blood_stained_bone))
  cost += (materials_used[:shimmerscale] * price_of(:shimmerscale))
  cost *= num_crafted

  # first, craft the bracers
  bracers = craft_bracers

  # disenchant the blues
  enchanting_mats = disenchant_blues(bracers[:blue])

  # scrap the greens
  scrap = scrap_greens(bracers[:green])

  # craft 310 epic leather bracers, we'll just assume we're always going to craft
  # as many as we have expulsom since that is typically the limiting factor
  leather_bracers_crafted = scrap[:expulsom]


  leather_bracer_cost = (price_of(:calcified_bone) * 8) + (price_of(:tempest_hide) * 12)

  materials_used[:calcified_bone] = leather_bracers_crafted * 8
  materials_used[:tempest_hide] = leather_bracers_crafted * 12

  total_epic_bracer_cost = leather_bracer_cost * leather_bracers_crafted

  cost += total_epic_bracer_cost

  puts "Raw Material Costs: #{wowify(cost)}"

  # disenchant the epics
  epic_de = disenchant_epics(leather_bracers_crafted)
  puts "Q"
  puts epic_de
  puts "B"
  puts enchanting_mats

  mats = {
    gloom_dust: enchanting_mats[:gloom_dust] + epic_de[:gloom_dust],
    umbra_shard: enchanting_mats[:umbra_shard] + epic_de[:umbra_shard],
    veiled_crystals: enchanting_mats[:veiled_crystals] + epic_de[:veiled_crystals]
  }

  sales = {
    gloom_dust: mats[:gloom_dust] * price_of(:gloom_dust),
    umbra_shard: mats[:umbra_shard] * price_of(:umbra_shard),
    veiled_crystal: mats[:veiled_crystals] * price_of(:veiled_crystal),
    tidespray_linen: scrap[:tidespray_linen] * price_of(:tidespray_linen),
  }

  total_sales = 0
  sales.keys.each do |k|
    sale = sales[k]

    puts "#{k}: #{wowify(sale)}"

    total_sales += sale
  end

  puts "-" * 25

  puts wowify(total_sales)

  puts ""

  puts "Profit: #{wowify(total_sales - cost)}"

  return total_sales - cost
end

def tidespray_linen_to_enchanting_mats
  # The cost of the linen plus the nylon thread
  num_crafted = (TIDESPRAY_LINEN / 10.0).floor

  materials_used = {
    tidespray_linen: TIDESPRAY_LINEN * 10,
    nylon_thread: TIDESPRAY_LINEN * 5,
    calcified_bone: 0,
    tempest_hide: 0
  }

  cost = 0
  cost += (10 * price_of(:tidespray_linen))
  cost += (5 * price_of(:nylon_thread))
  cost *= num_crafted

  # first, craft the bracers
  bracers = craft_bracers

  # disenchant the blues
  enchanting_mats = disenchant_blues(bracers[:blue])

  # scrap the greens
  scrap = scrap_greens(bracers[:green])

  # craft 310 epic leather bracers, we'll just assume we're always going to craft
  # as many as we have expulsom since that is typically the limiting factor
  leather_bracers_crafted = scrap[:expulsom]


  leather_bracer_cost = (price_of(:calcified_bone) * 8) + (price_of(:tempest_hide) * 12)

  materials_used[:calcified_bone] = leather_bracers_crafted * 8
  materials_used[:tempest_hide] = leather_bracers_crafted * 12

  total_epic_bracer_cost = leather_bracer_cost * leather_bracers_crafted

  cost += total_epic_bracer_cost

  puts "Raw Material Costs: #{wowify(cost)}"

  # disenchant the epics
  epic_de = disenchant_epics(leather_bracers_crafted)
  puts "Q"
  puts epic_de
  puts "B"
  puts enchanting_mats

  mats = {
    gloom_dust: enchanting_mats[:gloom_dust] + epic_de[:gloom_dust],
    umbra_shard: enchanting_mats[:umbra_shard] + epic_de[:umbra_shard],
    veiled_crystals: enchanting_mats[:veiled_crystals] + epic_de[:veiled_crystals]
  }

  sales = {
    gloom_dust: mats[:gloom_dust] * price_of(:gloom_dust),
    umbra_shard: mats[:umbra_shard] * price_of(:umbra_shard),
    veiled_crystal: mats[:veiled_crystals] * price_of(:veiled_crystal),
    tidespray_linen: scrap[:tidespray_linen] * price_of(:tidespray_linen),
  }

  total_sales = 0
  sales.keys.each do |k|
    sale = sales[k]

    puts "#{k}: #{wowify(sale)}"

    total_sales += sale
  end

  puts "-" * 25

  puts wowify(total_sales)

  puts ""

  puts "Profit: #{wowify(total_sales - cost)}"

  return total_sales - cost
end

def price_of(item)
  items = {
    tidespray_linen: 75000,
    nylon_thread: 6000,
    veiled_crystal: 4450000,
    calcified_bone: 23000,
    tempest_hide: 40000,
    mistscale: 125000,
    gloom_dust: 135500,
    umbra_shard: 1919999,
    blood_stained_bone: 22700,
    shimmerscale: 74000
  }

  items[item]
end

def tidespray_linen_disenchant_all
  # The cost of the linen plus the nylon thread
  num_crafted = (TIDESPRAY_LINEN / 10.0).floor

  materials_used = {
    tidespray_linen: TIDESPRAY_LINEN * 10,
    nylon_thread: TIDESPRAY_LINEN * 5,
    calcified_bone: 0,
    tempest_hide: 0
  }

  cost = 0
  cost += (10 * price_of(:tidespray_linen))
  cost += (5 * price_of(:nylon_thread))
  cost *= num_crafted

  # first, craft the bracers
  bracers = craft_bracers

  # disenchant the blues
  enchanting_mats = disenchant_blues(bracers[:blue])

  sales = {
    gloom_dust: enchanting_mats[:gloom_dust] * price_of(:gloom_dust),
    umbra_shard: enchanting_mats[:umbra_shard] * price_of(:umbra_shard),
    veiled_crystal: enchanting_mats[:veiled_crystals] * price_of(:veiled_crystal)
  }

  puts "Investment cost: #{wowify(cost)}"
  puts "Tidespray: #{wowify(price_of(:tidespray_linen))}"


  puts ""

  total_sales = 0
  sales.keys.each do |k|
    sale = sales[k]

    puts "#{k}: #{wowify(sale)}"

    total_sales += sale
  end

  puts "-" * 25

  puts wowify(total_sales)

  puts ""

  puts "Profit: #{wowify(total_sales - cost)}"

  return total_sales - cost
end

puts "Hello. I am Blingtron."
puts ""

 shuffle = tidespray_linen_to_enchanting_mats

 mail_shuffle = shimmer_scale_to_enchanting_mats

 de = tidespray_linen_disenchant_all

 puts ""
 puts ""
 puts ""
 puts ""
 puts ""
 puts ""

 puts "Shuffle: #{wowify(shuffle)}"
 puts "Disench: #{wowify(de)}"
 puts "Mail   : #{wowify(mail_shuffle)}"

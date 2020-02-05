// An item is an object in game
class Item {
  // id: Number
  // name: String
  // price: Number
  // do we need to track if vendorable or not?
  // are items even classes or do we just use an array of structs/hashes?
}

// An ingredient is an item and a count
class Ingredient {
  item: Item;
  count: Number;

  constructor(item: Item, count: Number = 0) {
    this.item = item
    this.count = count
  }
}

// A recipe (or schematic) consists of multiple ingredients
class Recipe {
  ingredients: Array<Ingredient>;

  constructor() {
    this.ingredients = []
  }
}

// FIXME: These can just be the same thing for now
class InventoryItem extends Ingredient {
}

class Simulation {
  inventory: Array<InventoryItem>;

  log(msg: String) {
    document.querySelector(".console").innerHTML += msg + "<br />"
  }

  run() {
    console.log("running simulation")
  }

  craft(recipe: Recipe, count: Number = 1) {

    // check inventory for required materials
    // if missing some materials, check the auction house
    // calculate the cost of missing materials and factor it in after calculations
    // if item is vendor purchasable, simulate the purchase
    // if not even in inventory and not enough in auction house, abort with descriptive error
    for (var n = 0; n < count; n++) {
      console.log("crafting:", recipe)
    }
  }
}

class ClothToEnchantingMatsShuffleSimulation extends Simulation {
  run() {
    let recipe = new Recipe()

    // craft the recipe N times
    this.craft(recipe, 10)
  }
}

export default Simulation
export { ClothToEnchantingMatsShuffleSimulation }

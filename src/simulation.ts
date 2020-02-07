// An item is an object in game
class Item {
  id: number
  cost: number
  // id: Number
  // name: String
  // price: Number
  // do we need to track if vendorable or not?
  // are items even classes or do we just use an array of structs/hashes?

  constructor(id: number, cost: number = 0) {
    this.id = id
    this.cost = cost
  }
}

interface ItemCollection<T> {
  [key: number]: T;
}

interface InventoryItem {
  item: Item
  count: number
}

class ItemContainer {
  items: ItemCollection<InventoryItem> = {}

  addItem(item: Item, count: number = 1) {
    let iItem = this.getOrCreateInventoryItem(item)

    console.log(iItem)

    iItem.count += count
  }

  private getOrCreateInventoryItem(item: Item): InventoryItem {
    if (item.id in this.items) {
      return this.items[item.id]
    }

    let iItem = {
      item: item,
      count: 0
    }

    this.items[item.id] = iItem

    return iItem
  }
}

type Ingredient = InventoryItem

// A recipe (or schematic) consists of multiple ingredients
class Recipe {
  ingredients: Array<Ingredient>;

  constructor() {
    this.ingredients = []
  }
}

class Simulation {
  inventory: ItemContainer
  balance: number

  constructor() {
    this.inventory = new ItemContainer()
    this.balance = 0
  }

  log(msg: String) {
    console.log(msg)
  }

  run() {
    console.log("running simulation")
  }

  purchaseItem(item: Item, count: number = 1) {
    this.inventory.addItem(item, count)
    this.balance -= item.cost * count
  }

  craft(recipe: Recipe, count: number = 1) {

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

    let item = new Item(12345)

    this.purchaseItem(item, 5)
    this.purchaseItem(item, 5)

    console.log(this.inventory)

    // craft the recipe N times
    this.craft(recipe, 10)
  }
}

export default Simulation
export { ClothToEnchantingMatsShuffleSimulation }

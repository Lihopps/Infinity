data:extend({{
        type = "item",
        name = "lihop-satellite-miner",
        icon = "__Infinity__/graphics/items/satmining.png",
        icon_size = 64,
        stack_size = 1,
        rocket_launch_product = {{type="item",name= "lihop-raw-infinity-stone", amount=1000 }},
        subgroup="space-related",
        order="n[satellite-miner]",
      },
      {
        type = "recipe",
        name = "lihop-satellite-miner",
        energy_required = 20,
        enabled = false,
        category = "advanced-crafting",
        ingredients =
        {
          { type="item",name="satellite",     amount=        1 },
          { type="item",name="productivity-module-3", amount=  5 },
          { type="item",name="electric-mining-drill", amount=  10 }
        },
        results = {{type="item",name="lihop-satellite-miner",amount=1}}
      }})
data.raw["item"]["lihop-raw-infinity-stone"].stack_size=1000
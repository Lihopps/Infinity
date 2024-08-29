------------------------------------------------------------------------
--------------------------------------- ITEM ---------------------------
------------------------------------------------------------------------
data:extend(
  {
    ---- Raw Infinity stone
    {
      type = "item",
      name = "lihop-raw-infinity-stone",
      icon = "__Infinity__/graphics/items/raw-1.png",
      pictures =
    {
      { size = 64, filename = "__Infinity__/graphics/items/raw-1.png",   scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__Infinity__/graphics/items/raw-2.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__Infinity__/graphics/items/raw-3.png", scale = 0.25, mipmap_count = 4 },
      { size = 64, filename = "__Infinity__/graphics/items/raw-4.png", scale = 0.25, mipmap_count = 4 }
    },
      icon_size = 64,icon_mipmaps = 4,
      stack_size = 1000
    },
    ---- Infinity stone
    {
      type = "item",
      name = "lihop-infinity-stone",
      icon = "__Infinity__/graphics/items/infinity-stone.png",
      icon_size = 64,
      icon_mipmaps = 4,
      subgroup="intermediate-product",
      order="s[infinity-stone]",
      stack_size = 100
    },
    
    ---- Infinity fuel cell
    {
      type = "item",
      name = "lihop-infinity-fuel-cell",
      icon = "__Infinity__/graphics/items/infinity-fuel-cell.png",
      icon_size = 64,
      icon_mipmaps = 4,
      subgroup="intermediate-product",
      order="s[infinity-stone-cell]",
      fuel_category = "lihop-solid-fuel",
      fuel_value = "16GJ",
      stack_size = 50
    },
    ----- Infinity Fuel
    {
      type = "item",
      name = "lihop-infinity-fuel",
      icon = "__Infinity__/graphics/items/infinity-fuel.png",
      icon_size = 64,
      icon_mipmaps = 4,
      fuel_category = "chemical",
      fuel_value = "3GJ",
      fuel_acceleration_multiplier = 3,
      fuel_top_speed_multiplier = 1.5,
      fuel_glow_color = { r = 1, g = 0.1, b = 0.1 },
      subgroup="intermediate-product",
      order="s[infinity-stone-fuel]",
      stack_size = 1
    },
    ---- Fusion Reactor
    {
      type = "item",
      name = "lihop-fusion-reactor-equipment",
      icon = "__Infinity__/graphics/items/fusion-reactor.png",
      icon_size = 64,
      icon_mipmaps = 4,
      placed_as_equipment_result = "lihop-fusion-reactor-equipment",
      subgroup="equipment",
      order="a[energy-source]-c[infinity-fusion-reactor]",
      default_request_amount = 1,
      stack_size = 20,
    },
  })
---- create false item for button
data:extend({
  {
    type = "item",
    name = "lihop-false-item",
    icon = "__Infinity__/graphics/items/lihop-false-item.png",
    icon_size = 64,
    flags = { "hidden" ,"hide-from-bonus-gui"},
    icon_mipmaps = 4,
    stack_size = 1
  }
})

------------------------------------------------------------------------
-------------------------- Mod Compatibilité ---------------------------
------------------------------------------------------------------------


--- Infinity stone collect depend difficulty
if mods["space-exploration"] then
  data.raw["item"]["lihop-raw-infinity-stone"].stack_size=20
else
  data:extend(
    {
      {
        type = "item",
        name = "lihop-satellite-miner",
        icon = "__Infinity__/graphics/items/satmining.png",
        icon_size = 64,
        icon_mipmaps = 4,
        stack_size = 1,
        rocket_launch_product = { "lihop-raw-infinity-stone", 1000 },
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
          { "satellite",             1 },
          { "productivity-module-3", 5 },
          { "electric-mining-drill", 10 }
        },
        result = "lihop-satellite-miner",
        result_count = 1
      }
    })
end
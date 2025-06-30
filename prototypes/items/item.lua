
local item_tints = require("__base__.prototypes.item-tints")
------------------------------------------------------------------------
--------------------------------------- ITEM ---------------------------
------------------------------------------------------------------------
data.extend(
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
      subgroup="raw-resource",
      order="g[uranium-ore]-infinity[raw-infinity-stone]",
      icon_size = 64,
      stack_size = 50
    },
    ---- Infinity stone
    {
      type = "item",
      name = "lihop-infinity-stone",
      icon = "__Infinity__/graphics/items/infinity-stone.png",
      icon_size = 64,
      subgroup="intermediate-product",
      order="s[infinity]-a[stone]",
      stack_size = 100
    },
    
    ---- Infinity fuel cell
    {
      type = "item",
      name = "lihop-infinity-fuel-cell",
      icon = "__Infinity__/graphics/items/infinity-fuel-cell.png",
      icon_size = 64,
      subgroup="intermediate-product",
      order="s[infinity]-b[stone-cell]",
      fuel_category = "lihop-solid-fuel",
      fuel_value = "64GJ",
      stack_size = 50
    },
    ----- Infinity Fuel
    {
      type = "item",
      name = "lihop-infinity-fuel",
      icon = "__Infinity__/graphics/items/infinity-fuel.png",
      icon_size = 64,
      fuel_category = "chemical",
      fuel_value = "3GJ",
      fuel_acceleration_multiplier = 3,
      fuel_top_speed_multiplier = 1.5,
      fuel_glow_color = { r = 1, g = 0.1, b = 0.1 },
      subgroup="intermediate-product",
      order="s[infinity]-c[stone-fuel]",
      stack_size = 1
    },
    ---- Fusion Reactor
    {
      type = "item",
      name = "lihop-fusion-reactor-equipment",
      icon = "__Infinity__/graphics/items/fusion-reactor.png",
      icon_size = 64,
      place_as_equipment_result = "lihop-fusion-reactor-equipment",
      subgroup="equipment",
      order="a[energy-source]-c[infinity-fusion-reactor]",
      stack_size = 1,
      weight = 1 * tons
    },
    
  })
if mods["space-age"] then
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
data.extend({
  {
    type = "item",
    name = "infinity-asteroid-chunk",
    icon = "__Infinity__/graphics/icons/infinity-asteroid-chunk.png",
    subgroup = "space-material",
    order = "ca[infinity]-e[chunk]",
    inventory_move_sound = space_age_item_sounds.rock_inventory_move,
    pick_sound = space_age_item_sounds.rock_inventory_pickup,
    drop_sound = space_age_item_sounds.rock_inventory_move,
    stack_size = 1,
    weight = 100 * kg,
    random_tint_color = item_tints.iron_rust
  },
    {
    type = "recipe",
    name = "infinity-asteroid-crushing",
    icon = "__Infinity__/graphics/icons/infinity-asteroid-crushing.png",
    category = "crushing",
    subgroup="space-crushing",
    order = "b-a-d",
    auto_recycle = false,
    enabled = true,
    ingredients =
    {
      {type = "item", name = "infinity-asteroid-chunk", amount = 1},
    },
    energy_required = 0.5,
    results =
    {
      {type = "item", name = "lihop-raw-infinity-stone", amount = 1,probability=0.85},
       {type = "item", name = "infinity-asteroid-chunk", amount = 1,probability=0.15},
    },
    allow_productivity = true,
    allow_decomposition = false
  },
})
end
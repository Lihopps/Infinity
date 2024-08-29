data:extend(
  {
    ---- Infinity fuel cell
    {
      type = "recipe",
      name = "lihop-infinity-fuel-cell",
      energy_required = 120,
      enabled = false,
      category = "chemistry",
      ingredients =
      {
        { type = "fluid", name = "sulfuric-acid",        amount = 20 },
        { type = "item",  name = "lihop-infinity-stone", amount = 2 },
        { type = "item",  name = "iron-plate",           amount = 5 },
        { type = "item",  name = "uranium-fuel-cell",    amount = 1 }
      },
      results =
      {
        { type = "item", name = "lihop-infinity-fuel-cell", amount = 1 }
      },
      crafting_machine_tint =
      {
        primary = { r = 1.000, g = 0.000, b = 0.000, a = 1.000 },    -- #fefeffff
        secondary = { r = 1.0, g = 0.0, b = 0.0, a = 1.000 },        -- #c4c4c4ff
        tertiary = { r = 1.0, g = 0.0, b = 0.0, a = 1.000 },         -- #c3a9c2ff
        quaternary = { r = 1.000, g = 0.000, b = 0.000, a = 1.000 }, -- #000000ff
      }
    },

    ----- Infinity Fuel
    {
      type = "recipe",
      name = "lihop-infinity-fuel",
      energy_required = 90,
      enabled = false,
      category = "lihop-concentrating",
      ingredients = { { "nuclear-fuel", 1 }, { "lihop-infinity-stone", 2 } },
      icon = "__Infinity__/graphics/items/infinity-fuel.png",
      icon_size = 64,
      icon_mipmaps = 4,
      result = "lihop-infinity-fuel"
    },

    ---- Fusion Reactor
    {
      type = "recipe",
      name = "lihop-fusion-reactor-equipment",
      enabled = false,
      energy_required = 10,
      category = "lihop-concentrating",
      ingredients =
      {
        { "fusion-reactor-equipment", 4 },
        { "lihop-infinity-stone",     25 }
      },
      result = "lihop-fusion-reactor-equipment",
      result_count = 1
    },
    {
      type = "recipe",
      name = "lihop-infinity-rounds-magazine",
      enabled = false,
      energy_required = 10,
      category = "lihop-concentrating",
      ingredients =
      {
        { "uranium-rounds-magazine", 5 },
        { "lihop-infinity-stone",    1 }
      },
      result = "lihop-infinity-rounds-magazine",
      result_count = 3
    },
    {
      type = "recipe",
      name = "lihop-infinity-bomb",
      enabled = false,
      category = "lihop-concentrating",
      energy_required = 50,
      ingredients =
      {
        { "atomic-bomb",          1 },
        { "lihop-infinity-stone", 30 }
      },
      result = "lihop-infinity-bomb"
    },
    {
      type = "recipe",
      name = "lihop-infinity-cannon-shell",
      enabled = false,
      category = "lihop-concentrating",
      energy_required = 12,
      ingredients =
      {
        { "uranium-cannon-shell", 1 },
        { "lihop-infinity-stone", 1 }
      },
      result = "lihop-infinity-cannon-shell"
    },
    {
      type = "recipe",
      name = "lihop-explosive-infinity-cannon-shell",
      enabled = false,
      category = "lihop-concentrating",
      energy_required = 12,
      ingredients =
      {
        { "explosive-uranium-cannon-shell", 1 },
        { "lihop-infinity-stone",           1 }
      },
      result = "lihop-explosive-infinity-cannon-shell"
    },
  })


if mods["space-exploration"] then
  --plus tard
  data:extend({
    ---- lihop-infinity-stone
    {
      type = "recipe",
      name = "lihop-raw-infinity-stone",
      energy_required = 60,
      enabled = false,
      category = "centrifuging",
      subgroup = "raw-resource",
      crafting_machine_tint =
    {
      primary = {r = 1.000, g = 0, b = 0, a = 1.000}, 
      secondary = {r = 1.000, g = 0, b = 0, a = 1.000},
      tertiary ={r = 1.000, g = 0, b = 0, a = 1.000},
      quaternary = {r = 1.000, g = 0, b = 0, a = 1.000},
    },
      ingredients =
      {
        { type = "item", name = "uranium-ore",      amount = 10 },
        { type = "item", name = "se-vulcanite",     amount = 10 },
        { type = "item", name = "se-cryonite",      amount = 10 },
        { type = "item", name = "se-beryllium-ore", amount = 10 },
        { type = "item", name = "se-holmium-ore",   amount = 10 },
        { type = "item", name = "se-iridium-ore",   amount = 10 },
        { type = "item", name = "se-vitamelange",   amount = 10 },
      },
      results =
      {
        { type = "item", name = "lihop-raw-infinity-stone", amount = 1 },
      },
    },

    ---- lihop-infinity-stone
    {
      type = "recipe",
      name = "lihop-infinity-stone",
      energy_required = 120,
      enabled = false,
      category = "lihop-concentrating",
      icon = "__Infinity__/graphics/items/infinity-stone.png",
      icon_size = 64,
      icon_mipmaps = 4,
      subgroup = "raw-resource",
      ingredients =
      {
        { type = "item", name = "lihop-raw-infinity-stone", amount = 10 },
        { type = "item", name = "uranium-235",              amount = 10 },
        { type = "item", name = "se-vitamelange-nugget",     amount = 40 },
      },
      results =
      {
        { type = "item", name = "lihop-infinity-stone", amount = 1 },
        { type = "item", name = "uranium-235", amount = 9 },
        { type = "item", name = "se-vitamelange-nugget", amount_min = 15,amount_max =30,},
        { type = "item", name = "coal", amount = 1},
      },
    },
  })
else
  data:extend({
    ---- lihop-infinity-stone
    {
      type = "recipe",
      name = "lihop-infinity-stone",
      energy_required = 120,
      enabled = false,
      category = "lihop-concentrating",
      icon = "__Infinity__/graphics/items/infinity-stone.png",
      icon_size = 64,
      icon_mipmaps = 4,
      subgroup = "raw-resource",
      ingredients =
      {
        { type = "item", name = "lihop-raw-infinity-stone", amount = 10 },
        { type = "item", name = "uranium-235",              amount = 10 },
      },
      results =
      {
        { type = "item", name = "lihop-infinity-stone", amount = 1 },
        { type = "item", name = "uranium-235",          amount = 9 },
      },
    },
  })
end

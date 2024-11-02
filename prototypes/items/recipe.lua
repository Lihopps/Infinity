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
      ingredients = { { type = "item", name = "nuclear-fuel", amount = 1 }, { type = "item", name = "lihop-infinity-stone", amount = 2 } },
      icon = "__Infinity__/graphics/items/infinity-fuel.png",
      icon_size = 64,
      icon_mipmaps = 4,
      results = { { type = "item", name = "lihop-infinity-fuel", amount = 1 } }
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
        { type = "item", name = "fusion-reactor-equipment", amount = 4 },
        { type = "item", name = "lihop-infinity-stone", amount = 25 }
      },
      results = { { type = "item", name = "lihop-fusion-reactor-equipment", amount = 1 } }

    },
    {
      type = "recipe",
      name = "lihop-infinity-rounds-magazine",
      enabled = false,
      energy_required = 10,
      category = "lihop-concentrating",
      ingredients =
      {
        { type = "item", name = "uranium-rounds-magazine", amount = 5 },
        { type = "item", name = "lihop-infinity-stone", amount = 1 }
      },
      results = { { type = "item", name = "lihop-infinity-rounds-magazine", amount = 1 } }
    },
    {
      type = "recipe",
      name = "lihop-infinity-bomb",
      enabled = false,
      category = "lihop-concentrating",
      energy_required = 50,
      ingredients =
      {
        { type = "item", name = "atomic-bomb",       amount = 1 },
        { type = "item", name = "lihop-infinity-stone", amount = 30 }
      },
      results = { { type = "item", name = "lihop-infinity-bomb", amount = 1 } }
    },
    {
      type = "recipe",
      name = "lihop-infinity-cannon-shell",
      enabled = false,
      category = "lihop-concentrating",
      energy_required = 12,
      ingredients =
      {
        { type = "item", name = "uranium-cannon-shell", amount = 1 },
        { type = "item", name = "lihop-infinity-stone", amount = 1 }
      },
      results = { { type = "item", name = "lihop-infinity-cannon-shell", amount = 1 } }
    },
    {
      type = "recipe",
      name = "lihop-explosive-infinity-cannon-shell",
      enabled = false,
      category = "lihop-concentrating",
      energy_required = 12,
      ingredients =
      {
        { type = "item", name = "explosive-uranium-cannon-shell", amount = 1 },
        { type = "item", name = "lihop-infinity-stone",       amount = 1 }
      },
      results = { { type = "item", name = "lihop-explosive-infinity-cannon-shell", amount = 1 } }
    },
    {
      type = "recipe",
      name = "lihop-infinity-stone",
      energy_required = 10,
      enabled = false,
      category = "lihop-concentrating",
      icon = "__Infinity__/graphics/items/infinity-stone.png",
      icon_size = 64,
      icon_mipmaps = 4,
      subgroup = "raw-resource",
      ingredients =
      {
        { type = "item", name = "lihop-raw-infinity-stone", amount = 5 },
        { type = "item", name = "uranium-235",              amount = 10 },
      },
      results =
      {
        { type = "item", name = "lihop-infinity-stone", amount = 4 },
        { type = "item", name = "uranium-235",          amount = 9 },
      },
    },
     {
    type = "recipe",
    name = "infinity-asteroid-crushing",
    icon = "__Infinity__/graphics/icons/infinity-asteroid-crushing.png",
    category = "crushing",
    subgroup="space-crushing",
    order = "b-a",
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

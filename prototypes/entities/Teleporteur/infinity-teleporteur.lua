local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

data:extend({
  {
    type = "recipe",
    name = "lihop-teleporteur",
    category = "lihop-concentrating",
    energy_required = 4,
    enabled = false,
    ingredients =
    {
      { "radar",                          1 },
      { "lihop-infinity-stone",           100 },
      { "lihop-fusion-reactor-equipment", 4 },
      { "low-density-structure",          100 },

    },
    result = "lihop-teleporteur"
  },
  {
    type = "item",
    name = "lihop-teleporteur",
    icon = "__Infinity__/graphics/entities/teleporteur/teleporter-icon.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "defensive-structure",
    order = "d[radar]-b[teleporter]",
    place_result = "lihop-teleporteur",
    stack_size = 50
  },
  {
    type = "accumulator",
    name = "lihop-teleporteur",
    icon = "__Infinity__/graphics/entities/teleporteur/teleporter-icon.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "placeable-neutral", "placeable-player", "player-creation", "not-rotatable" },
    max_health = 1000,
    minable = { mining_time = 1, result = "lihop-teleporteur" },
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    damaged_trigger_effect = hit_effects.entity(),
    collision_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    collision_mask = { "item-layer", "object-layer", "water-tile" },
    resistances = {
      { type = "physical", percent = 75 },
      { type = "fire",     percent = 75 },
      { type = "impact",   percent = 75 },
    },
    energy_source = {
      type = "electric",
      buffer_capacity = "400MJ",
      input_flow_limit = "20MW",
      usage_priority = "secondary-input",
      output_flow_limit = "0W",
    },
    picture =
    {
      layers =
      {
        {
          filename = "__Infinity__/graphics/entities/teleporteur/teleporter.png",
          priority = "high",
          width = 370,
          height = 357,
          frame_count = 32,
          line_length = 4,
          direction_count = 32,
          animation_speed = 1,
          shift = util.by_pixel(0, -20),
          scale = 0.3
        },
        {
          filename = "__Infinity__/graphics/entities/teleporteur/teleporter-shadow.png",
          priority = "high",
          width = 587,
          height = 357,
          frame_count = 32,
          line_length = 4,
          direction_count = 32,
          animation_speed = 1,
          draw_as_shadow = true,
          shift = util.by_pixel(30, -20),
          scale = 0.3
        }
      }
    },
    charge_cooldown = 10,
    discharge_cooldown = 10,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/nuclear-reactor-1.ogg",
          volume = 0.8
        }
      }
    },
    audible_distance_modifier = 30,
  },
})


if mods["space-exploration"] then
  data.raw["recipe"]["lihop-teleporteur"].ingredients =
  {
      { "radar",                          1 },
      { "lihop-infinity-stone",           100 },
      { "se-heat-shielding",    200 },
      { "low-density-structure",          100 },

    }
  data:extend({ 
     {
    type = "technology",
    name = "lihop-infinity-pre-teleportation",
    icon_size = 256,
    icon_mipmaps = 4,
    icons =
    {
      {
        icon = "__Infinity__/graphics/technologies/teleportation.png"
      }
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "lihop-teleporteur"
      }
    },
    unit =
    {
      count = 4000,
      ingredients =
			  {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1},
				{"se-astronomic-science-pack-1", 1},
				{"se-material-science-pack-1", 1},
				{"se-biological-science-pack-1", 1},
				{"se-energy-science-pack-1", 1},

			  },
      time = 60
    },
    prerequisites = { "lihop-infinity-stone" }
  },
    {
    type = "technology",
    name = "lihop-infinity-teleportation",
    icon_size = 256,
    icon_mipmaps = 4,
    icons =
    {
      {
        icon = "__Infinity__/graphics/technologies/teleportation.png"
      }
    },
    effects =
    {
      {
        type = "nothing",
        icon = "__Infinity__/graphics/technologies/teleportation.png",
        icon_size = 256,
        icon_mipmaps = 4,
      }
    },
    unit =
    {
      count = 4000,
      ingredients =
      {
        { "automation-science-pack",      1 },
        { "logistic-science-pack",        1 },
        { "chemical-science-pack",        1 },
        { "production-science-pack",      1 },
        { "utility-science-pack",         1 },
        { "space-science-pack",           1 },
        { "se-astronomic-science-pack-4", 1 },
        { "se-material-science-pack-4",   1 },
        { "se-energy-science-pack-4",     1 },
        { "se-deep-space-science-pack-4", 1 }

      },
      time = 60
    },
    prerequisites = { "lihop-infinity-pre-teleportation","lihop-infinity-energy2", "se-teleportation" }
  } })
else
  data:extend({ {
    type = "technology",
    name = "lihop-infinity-teleportation",
    icon_size = 256,
    icon_mipmaps = 4,
    icons =
    {
      {
        icon = "__Infinity__/graphics/technologies/teleportation.png"
      }
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "lihop-teleporteur"
      }
    },
    unit =
    {
      count = 4000,
      ingredients =
      {
        { "automation-science-pack", 1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 },
        { "production-science-pack", 1 },
        { "utility-science-pack",    1 },
        { "space-science-pack",      1 }
      },
      time = 60
    },
    prerequisites = { "lihop-infinity-energy2" }
  } })
end

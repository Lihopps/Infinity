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
      { type="item",name="radar",amount=1 },
      { type="item",name="lihop-infinity-stone",amount=100 },
      { type="item",name="lihop-fusion-reactor-equipment", amount=4 },
      { type="item",name="low-density-structure",amount= 100 },

    },
    results = {{type="item",name="lihop-teleporteur",amount=1}}
  },
  {
    type = "item",
    name = "lihop-teleporteur",
    icon = "__Infinity__/graphics/entities/teleporteur/teleporter-icon.png",
    icon_size = 64,
    subgroup = "defensive-structure",
    order = "d[radar]-b[teleporter]",
    place_result = "lihop-teleporteur",
    stack_size = 1,
    weight = 1000 * kg
  },
  {
    type = "electric-energy-interface",
    name = "lihop-teleporteur",
    icon = "__Infinity__/graphics/entities/teleporteur/teleporter-icon.png",
    icon_size = 64,
    flags = { "placeable-neutral", "placeable-player", "player-creation", "not-rotatable" },
    max_health = 1000,
    minable = { mining_time = 1, result = "lihop-teleporteur" },
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    damaged_trigger_effect = hit_effects.entity(),
    collision_mask={layers={ item=true, object=true, water_tile=true}},
    collision_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    resistances = {
      { type = "physical", percent = 75 },
      { type = "fire",     percent = 75 },
      { type = "impact",   percent = 75 },
    },
    energy_source =
        {
            type = "electric",
            usage_priority = "secondary-input",
            buffer_capacity = "400MJ",
            input_flow_limit = "20MW",
            emissions_per_minute = {pollution=4}
        },
        energy_usage = "500kW",
    continuous_animation = true,
    animation =
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
          animation_speed = 0.7,
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
          animation_speed = 0.7,
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

local ing1={}
local ing2={}

if mods["space-age"] then
  ing1={
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"military-science-pack",1},
				{"space-science-pack", 1},
        {"metallurgic-science-pack",1},
        {"electromagnetic-science-pack",1},
        {"agricultural-science-pack",1},
        {"cryogenic-science-pack",1},
			}
  ing2={
       {"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"military-science-pack",1},
				{"space-science-pack", 1},
        {"metallurgic-science-pack",1},
        {"electromagnetic-science-pack",1},
        {"agricultural-science-pack",1},
        {"cryogenic-science-pack",1},
        {"promethium-science-pack",1},
      }
else
  ing1={
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"military-science-pack",1},
				{"space-science-pack", 1},
			}
  ing2={
       {"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"military-science-pack",1},
				{"space-science-pack", 1},
      }
end



  data:extend({ 
     {
    type = "technology",
    name = "lihop-infinity-pre-teleportation",
    icon_size = 256,
    icon_mipmaps = 4,
    icon = "__Infinity__/graphics/technologies/teleportation.png",
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
      ingredients =ing1,
			time = 60
    },
    prerequisites = { "lihop-infinity-stone" }
  },
    {
    type = "technology",
    name = "lihop-infinity-teleportation",
    icon_size = 256,
    icon_mipmaps = 4,
    icon = "__Infinity__/graphics/technologies/teleportation.png",
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
      ingredients =ing2,
      time = 60
    },
    prerequisites = { "lihop-infinity-pre-teleportation","lihop-infinity-energy2" }
  } })
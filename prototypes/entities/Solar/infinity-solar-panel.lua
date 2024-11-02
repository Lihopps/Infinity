local hit_effects = require ("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

if mods["space-exploration"] then
  prod= "2MW"
else
  prod="100kW"
end

data:extend({
	{
    type = "item",
    name = "lihop-infinity-solar-panel",
    icon = "__Infinity__/graphics/entities/solar-panel/solar-panel-icon.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup="energy",
    order="d[solar-panel]-b[infinity-solar-panel]",
    place_result = "lihop-infinity-solar-panel",
    stack_size = 50,
    weight = 20 * kg
  },
  {
    type = "recipe",
    name = "lihop-infinity-solar-panel",
    energy_required = 10,
    category = "lihop-concentrating",
    enabled = false,
    ingredients =
    {
      { type="item",name="solar-panel", amount=10},
      { type="item",name="lihop-infinity-stone", amount=5},
      { type="item",name="steel-plate", amount=100},
      { type="item",name="low-density-structure", amount=20}
    
    },
    results = {{ type="item",name="lihop-infinity-solar-panel",amount=1}}
  },
  {
    type = "solar-panel",
    name = "lihop-infinity-solar-panel",
    icon = "__Infinity__/graphics/entities/solar-panel/solar-panel-icon.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "lihop-infinity-solar-panel"},
    max_health = 200,
    fast_replaceable_group = "solar-panel",
    corpse = "solar-panel-remnants",
    dying_explosion = "solar-panel-explosion",
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    energy_source =
    {
      type = "electric",
      usage_priority = "solar"
    },
    picture =
    {
      layers =
      {
        {
          filename = "__Infinity__/graphics/entities/solar-panel/solar-panel.png",
          priority = "high",
          width = 116,
          height = 112,
          shift = util.by_pixel(-3, 3),
          hr_version =
          {
            filename = "__Infinity__/graphics/entities/solar-panel/hr-solar-panel.png",
            priority = "high",
            width = 230,
            height = 224,
            shift = util.by_pixel(-3, 3.5),
            scale = 0.5
          }
        },
        {
          filename = "__Infinity__/graphics/entities/solar-panel/solar-panel-shadow.png",
          priority = "high",
          width = 112,
          height = 90,
          shift = util.by_pixel(10, 6),
          draw_as_shadow = true,
          hr_version =
          {
            filename = "__Infinity__/graphics/entities/solar-panel/hr-solar-panel-shadow.png",
            priority = "high",
            width = 220,
            height = 180,
            shift = util.by_pixel(9.5, 6),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    overlay =
    {
      layers =
      {
        {
          filename = "__Infinity__/graphics/entities/solar-panel/solar-panel-shadow-overlay.png",
          priority = "high",
          width = 108,
          height = 90,
          shift = util.by_pixel(11, 6),
          hr_version =
          {
            filename = "__Infinity__/graphics/entities/solar-panel/hr-solar-panel-shadow-overlay.png",
            priority = "high",
            width = 214,
            height = 180,
            shift = util.by_pixel(10.5, 6),
            scale = 0.5
          }
        }
      }
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    production = prod
  }
})


-- update Solar Panel
data.raw["solar-panel"]["solar-panel"]["fast_replaceable_group"] = "solar-panel"
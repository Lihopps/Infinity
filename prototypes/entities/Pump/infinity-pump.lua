local hit_effects = require ("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local layers =
{
	{
	  filename = "__Infinity__/graphics/entities/pump/base.png",
	  priority = "high",
	  width = 130,
	  height = 146,
	  frame_count = 32,
	  line_length = 4,
	  shift = util.by_pixel(0, -10),
	  scale = 0.7,
	  hr_version =
	  {
		filename = "__Infinity__/graphics/entities/pump/base.png",
		priority = "high",
		width = 130,
	    height = 146,
		frame_count = 32,
		line_length = 4,
		shift = util.by_pixel(0, -10),
		scale = 0.7
	  }
	},
	{
	  filename = "__Infinity__/graphics/entities/pump/base-shadow.png",
	  priority = "high",
	  width = 192,
	  height = 88,
	  frame_count = 32,
	  line_length = 4,
	  draw_as_shadow = true,
	  shift = util.by_pixel(30, 10),
	  scale = 0.7,
	  hr_version =
	  {
		filename = "__Infinity__/graphics/entities/pump/base-shadow.png",
		priority = "high",
		width = 192,
	    height = 88,
		frame_count = 32,
		line_length = 4,
		draw_as_shadow = true,
		shift = util.by_pixel(30, 10),
		scale = 0.7
	  }
	}
}

data:extend(
{
  {
    type = "recipe",
    name = "lihop-infinity-pump",
	category = "lihop-concentrating",
 
    enabled = false,
    energy_required = 2,
    ingredients =
    {
      { type="item",name="pump", amount=5},
      { type="item",name="lihop-infinity-stone", amount=5},
      { type="item",name="steel-plate",amount= 100},
      { type="item",name="low-density-structure",amount= 20}
    
    },
    results ={ { type="item",name="lihop-infinity-pump",amount=1}}
  },
{
    type = "item",
    name = "lihop-infinity-pump",
    icon = "__Infinity__/graphics/entities/pump/pumpicons.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup="extraction-machine",
    order="b[fluids]-aa[infinity-pump]",
	  place_result = "lihop-infinity-pump",
    stack_size = 20,
    weight = 50 * kg
  },
  {type = "assembling-machine",
    name = "lihop-infinity-pump",
    icon = "__Infinity__/graphics/entities/pump/pumpicons.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "lihop-infinity-pump"},
    max_health = 350,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(-3, -12),
	  recipe_locked=true,
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    fluid_boxes =
    {
      {
        production_type = "output",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = {{ flow_direction="output", direction = defines.direction.south, position = {0, 1.0} }},
        secondary_draw_orders = { north = -1 }
      }
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    graphics_set={animation =
    {
      layers =layers
    }},
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/assembling-machine-t2-1.ogg",
          volume = 0.45
        }
      },
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    crafting_categories = {"lihop-excavate-fluid-tile"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution=12}
    },
    energy_usage = "1000kW",
    module_slots = 2,
    allowed_effects = {"speed", "productivity", "consumption", "pollution"}
  }
 })


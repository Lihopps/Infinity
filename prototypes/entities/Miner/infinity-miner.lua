local hit_effects = require ("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local layers =
{
	{
	  filename = "__Infinity__/graphics/entities/miner/minerf.png",
	  priority = "high",
	  width = 126,
	  height = 173,
	  frame_count = 32,
	  line_length = 4,
	  shift = util.by_pixel(0, -15),
	  scale = 0.7,
	  hr_version =
	  {
		filename = "__Infinity__/graphics/entities/miner/minerf.png",
		priority = "high",
		width = 126,
	    height = 173,
		frame_count = 32,
		line_length = 4,
		shift = util.by_pixel(0, -15),
		scale = 0.7
	  }
	},
	{
	  filename = "__Infinity__/graphics/entities/miner/minerf-shadow.png",
	  priority = "high",
	  width = 240,
	  height = 174,
	  frame_count = 32,
	  line_length = 4,
	  draw_as_shadow = true,
	  shift = util.by_pixel(40, -15),
	  scale = 0.7,
	  hr_version =
	  {
		filename = "__Infinity__/graphics/entities/miner/minerf-shadow.png",
		priority = "high",
		width = 240,
	    height = 174,
		frame_count = 32,
		line_length = 4,
		draw_as_shadow = true,
		shift = util.by_pixel(40, -15),
		scale = 0.7
	  }
	}
}


data:extend(
{
  {
    type = "recipe",
    name = "lihop-infinity-miner",
	category = "lihop-concentrating",
      enabled = false,
      energy_required = 2,
      ingredients =
      {
        {"electric-mining-drill", 10},
        {"lihop-infinity-stone", 10},
        {"steel-plate", 100},
        {"low-density-structure", 20}
      
      },
      result = "lihop-infinity-miner"
  },
{
    type = "item",
    name = "lihop-infinity-miner",
    icon = "__Infinity__/graphics/entities/miner/miner.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup="extraction-machine",
    order="a[items]-c[infinity-miner]",
    place_result = "lihop-infinity-miner-fake",
    stack_size = 50
  },
 ---- The real entity, placed by script
  {
  type = "assembling-machine",
    name = "lihop-infinity-miner",
    icon = "__Infinity__/graphics/entities/miner/miner.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "lihop-infinity-miner"},
    max_health = 350,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    se_allow_in_space=true,
    alert_icon_shift = util.by_pixel(-3, -12),
	  recipe_locked=true,
	  placeable_by={item="lihop-infinity-miner",count=1},
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
        production_type = "input",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -2} }},
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {0, 2} }},
        secondary_draw_orders = { north = -1 }
      },
      off_when_no_fluid_recipe = true
    },
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = hit_effects.entity(),
    animation =
    {
      layers =layers
    },
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
    crafting_categories = {"lihop-excavate"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 12	
    },
    energy_usage = "200kW",
    module_specification =
    {
      module_slots = 0
    },
    allowed_effects = {}
  },
  
---- False entity juste use to force placement on resource fields
  {
  type = "mining-drill",
    name = "lihop-infinity-miner-fake",
    icon = "__Infinity__/graphics/entities/miner/miner.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    resource_categories = lihop.minertype,
    minable = {mining_time = 0.3, result = "lihop-infinity-miner"},
    max_health = 150,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    --damaged_trigger_effect = hit_effects.entity(),
    mining_speed = 5,
	  active=false,
	  vector_to_place_result={0,0},
	input_fluid_box =
    {
      production_type = "input-output",
      pipe_picture = assembler2pipepictures(),
      pipe_covers = pipecoverspictures(),
      base_area = 1,
      height = 2,
      base_level = -1,
      pipe_connections =
      {
        { position = {0, -2} }
      }
    },
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/burner-mining-drill.ogg",
          volume = 0.6
        },
        {
          filename = "__base__/sound/burner-mining-drill-1.ogg",
          volume = 0.6
        }
      },
      --max_sounds_per_type = 3,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    allowed_effects = {},
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 12	
    },
    energy_usage = "200kW",
    animations =
    {
      north =
      {
        layers =layers
      },
      east =
      {
        layers =layers
      },
      south =
      {
        layers =layers
      },
      west =
      {
        layers =layers
      }
	},
    monitor_visualization_tint = {r=78, g=173, b=255},
    resource_searching_radius = 1.2
  }
  })

  if mods["space-exploration"] then
    data.raw["recipe"]["lihop-infinity-miner"].ingredients =
    {
      {"se-heat-shielding", 100},
      {"electric-mining-drill", 20},
      {"low-density-structure", 20},
      {"se-heavy-girder", 5},
      {"lihop-infinity-stone", 5}
    }
  end
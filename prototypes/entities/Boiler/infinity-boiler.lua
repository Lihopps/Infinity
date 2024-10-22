local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local layers =
{
  {
    priority = "high",
    filename = "__Infinity__/graphics/entities/boiler/boiler.png",
    line_length = 4,
    width = 182,
    height = 170,
    frame_count = 32,
    animation_speed = 1,
    scale = 0.5,
    shift = util.by_pixel(0, 0)
  },
  {
    priority = "high",
    filename = "__Infinity__/graphics/entities/boiler/boiler-shadow.png",
    line_length = 4,
    width = 236,
    height = 123,
    frame_count = 32,
    animation_speed = 1,
    draw_as_shadow = true,
    scale = 0.5,
    shift = util.by_pixel(10, 10)
  }
}


data:extend({
  ---- Create specificik steam recipe
  {
    type = "recipe",
    name = "lihop-infinity-water-steam",
    category = "lihop-boiler",
    ingredients = { { type = "fluid", name = "water", amount = 100 } },
    results = { { type = "fluid", name = "steam", amount = 100, temperature = 500 } }
  },
  {
    type = "recipe",
    name = "lihop-boiler",
    energy_required = 4,
    enabled = false,
    category = "lihop-concentrating",
    ingredients =
    {
      { type = "item", name = "boiler",               amount = 10 },
      { type = "item", name = "lihop-infinity-stone", amount = 5 }
    },
    results = { { type = "item", name = "lihop-boiler", amount = 1 } }
  },
  {
    type = "item",
    name = "lihop-boiler",
    icon = "__Infinity__/graphics/entities/boiler/boiler-icon.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "energy",
    order = "b[steam-power]-a[infinity-boiler]",
    place_result = "lihop-boiler",
    stack_size = 50
  },
  {
    type = "assembling-machine",
    name = "lihop-boiler",
    icon = "__Infinity__/graphics/entities/boiler/boiler-icon.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "placeable-neutral", "player-creation" },
    minable = { mining_time = 0.2, result = "lihop-boiler" },
    max_health = 200,
    corpse = "boiler-remnants",
    dying_explosion = "boiler-explosion",
    vehicle_impact_sound = sounds.generic_impact,
    crafting_categories = { "lihop-boiler" },
    crafting_speed = 1,
    fixed_recipe = "lihop-infinity-water-steam",
    show_recipe_icon = false,
    resistances =
    {
      {
        type = "fire",
        percent = 90
      },
      {
        type = "explosion",
        percent = 30
      },
      {
        type = "impact",
        percent = 30
      }
    },
    collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = { { -1.5, -1.9 }, { 1.5, 1.5 } },
    fluid_boxes_off_when_no_fluid_recipe = true,
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = { { flow_direction = "input", direction = defines.direction.north, position = { 0, -1 } } },
        secondary_draw_orders = { north = -1 }
      },
      {
        production_type = "output",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume = 1000,
        pipe_connections = { { flow_direction = "output", direction = defines.direction.south, position = { 0, 1 } } },
        secondary_draw_orders = { north = -1 }
      },
    },
    energy_usage = "3MW",
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 6 }
    },
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/boiler.ogg",
        volume = 0.7
      },
      --max_sounds_per_type = 3,
      audible_distance_modifier = 0.3,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    graphics_set = {
      animation =
      {
        layers = layers
      },
    },
    module_slots = 0,
    allowed_effects = {}
  }
})

local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local layersV =
{
  layers =
  {
    {
      filename = "__Infinity__/graphics/entities/generator/generator-v.png",
      priority = "high",
      width = 316,
      height = 347,
      frame_count = 32,
      line_length = 4,
      shift = util.by_pixel(0, -10),
      scale = 0.9,
      hr_version =
      {
        filename = "__Infinity__/graphics/entities/generator/generator-v.png",
        priority = "high",
        width = 316,
        height = 347,
        frame_count = 32,
        line_length = 4,
        shift = util.by_pixel(0, -10),
        scale = 0.9,
      }
    },
    {
      filename = "__Infinity__/graphics/entities/generator/generator-v-shadow.png",
      priority = "high",
      width = 371,
      height = 343,
      frame_count = 32,
      line_length = 4,
      draw_as_shadow = true,
      shift = util.by_pixel(20, -15),
      scale = 0.9,
      hr_version =
      {
        filename = "__Infinity__/graphics/entities/generator/generator-v-shadow.png",
        priority = "high",
        width = 371,
        height = 343,
        frame_count = 32,
        line_length = 4,
        draw_as_shadow = true,
        shift = util.by_pixel(20, -15),
        scale = 0.9
      }
    }
  }
}

data:extend(
  {
    {
      type = "recipe",
      name = "lihop-infinity-generator",
      category = "lihop-concentrating",
      enabled = false,
      energy_required = 180,
      ingredients =
      {
        {  type="item",name="lihop-infinity-stone", amount=100 },
        {  type="item",name="nuclear-reactor",    amount=  4 },
        {  type="item",name="steam-turbine",      amount=  50 },
        {  type="item",name="steel-plate",       amount= 1000 },
        {  type="item",name="low-density-structure",    amount=    100 },

      },
      results ={ { type="item",name="lihop-infinity-generator",amount=1}}
    },
    {
      type = "item",
      name = "lihop-infinity-generator",
      icon = "__Infinity__/graphics/entities/generator/generator.png",
      icon_size = 64,
      icon_mipmaps = 4,
      subgroup="energy",
      order="f[nuclear-energy]-e[infinity-generator]",
      place_result = "lihop-infinity-generator",
      stack_size = 50
    },
    {
      type = "burner-generator",
      name = "lihop-infinity-generator",
      icon = "__Infinity__/graphics/entities/generator/generator.png",
      icon_size = 64,
      icon_mipmaps = 4,
      flags = { "placeable-neutral", "player-creation" },
      minable = { mining_time = 0.3, result = "lihop-infinity-generator" },
      max_health = 300,
      corpse = "big-remnants",
      dying_explosion = "big-explosion",
      alert_icon_shift = util.by_pixel(0, -12),
      collision_box = { { -4.40, -4.40 }, { 4.40, 4.40 } },
      selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } },
      damaged_trigger_effect = hit_effects.entity(),
      max_power_output = "1.5GW",
      animation =
      {
        north = layersV,
        east = layersV,
        south = layersV,
        west = layersV
      },
      burner =
      {
        type="burner",
        fuel_categories = {"lihop-solid-fuel"},
        effectivity = 2,
        fuel_inventory_size = 1,
        emissions_per_minute = {pollution=10},
        smoke =
        {
          {
            name = "lihop-generator-smoke",
            north_position = { 0, -5 },
            east_position = { 0, 0 },
            deviation = { 0.1, 0.1 },
            frequency = 9
          }
        }
      },
      energy_source =
      {
        type = "electric",
        usage_priority = "secondary-output"
      },
      vehicle_impact_sound = sounds.generic_impact,
      open_sound = sounds.machine_open,
      close_sound = sounds.machine_close,
      working_sound =
      {
        sound =
        {
          filename = "__base__/sound/steam-turbine.ogg",
          volume = 0.67
        },
        match_speed_to_activity = true,
        audible_distance_modifier = 0.7,
        max_sounds_per_type = 3,
        fade_in_ticks = 4,
        fade_out_ticks = 20
      }
    }
  })
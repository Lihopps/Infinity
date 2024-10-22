local hit_effects = require("__base__/prototypes/entity/hit-effects")
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
        {  type="item",name="electric-mining-drill", amount=10 },
        {  type="item",name="lihop-infinity-stone", amount= 10 },
        {  type="item",name="steel-plate",         amount=  100 },
        {  type="item",name="low-density-structure",amount= 20 }

      },
      results = {{ type="item",name="lihop-infinity-miner",amount=1}}
    },
    {
      type = "item",
      name = "lihop-infinity-miner",
      icon = "__Infinity__/graphics/entities/miner/miner.png",
      icon_size = 64,
      icon_mipmaps = 4,
      subgroup = "extraction-machine",
      order = "a[items]-c[infinity-miner]",
      place_result = "lihop-infinity-miner-fake",
      stack_size = 50
    },
    ---- The real entity, placed by script
    {
      type = "assembling-machine",
      name = "lihop-infinity-miner",
      icon = "__Infinity__/graphics/entities/miner/miner.png",
      icon_size = 64,
      icon_mipmaps = 4,
      flags = { "placeable-neutral", "placeable-player", "player-creation" },
      minable = { mining_time = 0.2, result = "lihop-infinity-miner" },
      max_health = 350,
      corpse = "medium-remnants",
      dying_explosion = "medium-explosion",
      se_allow_in_space = true,
      alert_icon_shift = util.by_pixel(-3, -12),
      recipe_locked = true,
      placeable_by = { item = "lihop-infinity-miner", count = 1 },
      resistances =
      {
        {
          type = "fire",
          percent = 70
        }
      },
      fluid_boxes_off_when_no_fluid_recipe = true,
      fluid_boxes =
      {
        {
          production_type = "input",
          pipe_picture = assembler2pipepictures(),
          pipe_covers = pipecoverspictures(),
          volume=1000,
          pipe_connections = { { flow_direction="input", direction = defines.direction.north, position = { 0, -1. } } },
          secondary_draw_orders = { north = -1 }
        },
        {
          production_type = "output",
          pipe_picture = assembler2pipepictures(),
          pipe_covers = pipecoverspictures(),
          volume=1000,
          pipe_connections = { { flow_direction="output", direction = defines.direction.south, position = { 0, 1. } } },
          secondary_draw_orders = { north = -1 }
        },
        
      },
      collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
      selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
      damaged_trigger_effect = hit_effects.entity(),
      graphics_set={animation =
      {
        layers = layers
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
      crafting_categories = { "lihop-excavate" },
      crafting_speed = 1,
      energy_source =
      {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = {pollution=12}
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
      icon_size = 64,
      icon_mipmaps = 4,
      flags = { "placeable-neutral", "player-creation" },
      resource_categories = lihop.minertype,
      minable = { mining_time = 0.3, result = "lihop-infinity-miner" },
      max_health = 150,
      corpse = "medium-remnants",
      dying_explosion = "medium-explosion",
      collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
      selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
      --damaged_trigger_effect = hit_effects.entity(),
      mining_speed = lihop.settings.oreAmount / 2,
      vector_to_place_result = { 0, 0 },
      input_fluid_box =
      {
        production_type = "input-output",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        volume=1000,
        pipe_connections =
        {
          { flow_direction="input-output", direction = defines.direction.north, position = { 0, -1.199 } }
        }
      },
      allowed_effects = {},
      energy_source =
      {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = {pollution=12}
      },
      energy_usage = "200kW",
      graphics_set={
      animation =
      {
        north =
        {
          layers = layers
        },
        east =
        {
          layers = layers
        },
        south =
        {
          layers = layers
        },
        west =
        {
          layers = layers
        }
      }},
      monitor_visualization_tint = { r = 78, g = 173, b = 255 },
      resource_searching_radius = 1.2,
      resource_drain_rate_percent=1
    }
  })



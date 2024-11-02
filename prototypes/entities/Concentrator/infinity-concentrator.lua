local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

data:extend({
  {
    type = "recipe",
    name = "lihop-concentrator",
    energy_required = 4,
    enabled = false,
    ingredients =
    {
      { type = "item", name = "concrete",     amount = 100 },
      { type = "item", name = "steel-plate",  amount = 50 },
      { type = "item", name = "advanced-circuit", amount = 100 },
      { type = "item", name = "iron-gear-wheel", amount = 100 }
    },
    results = { { type = "item", name = "lihop-concentrator", amount = 1 } },
    requester_paste_multiplier = 10
  },
  {
    type = "item",
    name = "lihop-concentrator",
    icon = "__Infinity__/graphics/entities/concentrator/concentrator-icon.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "d[concentrator]",
    place_result = "lihop-concentrator",
    stack_size = 50,
    weight = 50 * kg
  },
  {
    type = "assembling-machine",
    name = "lihop-concentrator",
    icon = "__Infinity__/graphics/entities/concentrator/concentrator-icon.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 0.2, result = "lihop-concentrator" },
    max_health = 400,
    corpse = "medium-remnants",
    se_allow_in_space = true,
    dying_explosion = "medium-explosion",
    alert_icon_shift = util.by_pixel(-3, -12),
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/assembling-machine-t3-1.ogg",
          volume = 0.7
        },
        {
          filename = "__base__/sound/assembling-machine-t3-2.ogg",
          volume = 0.7
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.3 },
      apparent_volume = 1.5,
      audible_distance_modifier = 0.7,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    },
    collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    damaged_trigger_effect = hit_effects.entity(),
    drawing_box = { { -1.5, -1.7 }, { 1.5, 1.5 } },
    fast_replaceable_group = "assembling-machine",
    graphics_set = {
      animation =
      {
        layers =
        {
          {
            filename = "__Infinity__/graphics/entities/concentrator/concentrator.png",
            priority = "high",
            width = 229,
            height = 157,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(30, -10),
            scale = 0.7,
            hr_version =
            {
              filename = "__Infinity__/graphics/entities/concentrator/concentrator.png",
              priority = "high",
              width = 229,
              height = 157,
              frame_count = 64,
              line_length = 8,
              shift = util.by_pixel(30, -10),
              scale = 0.7
            }
          }
        }
      }
    },
    working_visualisations =
    {
      {
        effect = "uranium-glow", -- changes alpha based on energy source light intensity
        light = { intensity = 2, size = 9.9, shift = { 0.0, 0.0 }, color = { r = 1.0, g = 0.0, b = 0.0 } }
      }
    },
    crafting_categories = { "lihop-concentrating" },
    crafting_speed = 1.75,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 2 },
    },
    energy_usage = "400kW",
    module_slots = 4,
    allowed_effects = { "consumption", "speed", "productivity", "pollution" },
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions["assembling-machine"],
  }
})

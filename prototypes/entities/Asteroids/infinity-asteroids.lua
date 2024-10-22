
local particle_animations = require("__space-age__/prototypes/particle-animations")
local sounds = require("__base__.prototypes.entity.sounds")
local explosion_animations = require("__space-age__.prototypes.entity.explosion-animations")
local space_age_sounds = require ("__space-age__.prototypes.entity.sounds")

local simulations={}

local shared_resistances =
{
  physical =
  {
    decrease = {0, 0, 0, 2000, 3000},
    percent = {0, 0, 10, 10, 10}
  },
  explosion =
  {
    decrease = {0, 0, 0, 0, 0},
    percent = {0, 50, 30, 10, 99}
  },
  laser =
  {
    decrease = {0, 0, 0, 0, 0},
    percent = {0, 20, 90, 95, 99}
  }
}
local shared_health = {0, 100, 400, 2000, 5000}
local shared_mass = {0, 200000, 500000, 5000000, 100000000}
local asteroid_sizes = {"chunk", "small", "medium", "big", "huge"}
local asteroids_data =
{
  infinity =
  {
    order = "d",
    mass = shared_mass,
    max_health = shared_health,
    resistances = shared_resistances,
    shading_data =
    {
      normal_strength = 1.2,
      light_width = 0,
      brightness = 0.9,
      specular_strength = 2,
      specular_power = 2,
      specular_purity = 0,
      sss_contrast = 1,
      sss_amount = 0,
      lights = {
        { color = {1,1,1}, direction = {0.75,0.22,-1} },
        { color = {0.2,0,0}, direction = {0.5, 0, 0.95} },
      },
      ambient_light = {0.0, 0.0, 0.0},
    }
  },
}

local collision_radiuses =
{
  0.4, -- chunk
  0.5, -- small
  1, -- medium
  2, -- big
  4.5  -- huge
}

local graphics_scale =
{
  0.5, -- chunk
  0.5, -- small
  0.5, -- medium
  0.6, -- big
  0.75 -- huge
}

local sizes_resolution = {
  {50,1}, -- chunk
  {128,1}, -- small
  {230,0}, -- medium
  {304,6}, -- big
  {512,0} -- huge
}

local letter = {"a","b","c","d","e"}

local function asteroid_variation(asteroid_type, suffix, scale, size)
  return
  {
    color_texture =
    {
      filename = "__Infinity__/graphics/entity/asteroid/".. asteroid_type .."/"..asteroid_sizes[size].."/".."asteroid-" .. asteroid_type .. "-" .. asteroid_sizes[size] .. "-colour-" .. suffix .. ".png",
      size =  sizes_resolution[size][1],
      scale = scale
    },

    shadow_shift = { 0.25 * size, 0.25 * size },

    normal_map =
    {
      filename = "__Infinity__/graphics/entity/asteroid/".. asteroid_type .."/"..asteroid_sizes[size].."/".."asteroid-" .. asteroid_type .. "-" .. asteroid_sizes[size] .. "-normal-" .. suffix .. ".png",
      premul_alpha = false,
      size = sizes_resolution[size][1],
      scale = scale
    },

    roughness_map =
    {
      filename = "__Infinity__/graphics/entity/asteroid/".. asteroid_type .."/"..asteroid_sizes[size].."/".."asteroid-" .. asteroid_type .. "-" .. asteroid_sizes[size] .. "-roughness-" .. suffix .. ".png",
      premul_alpha = false,
      size = sizes_resolution[size][1],
      scale = scale
    }
  }
end

local function asteroid_graphics_set(rotation_speed, shading_data, variations)
  local result = table.deepcopy(shading_data)
  result.rotation_speed = rotation_speed
  result.variations = variations
  return result
end

local make_asteroid_simulation = function(name, wait)
  return
  [[
    require("__core__/lualib/story")
    game.simulation.camera_position = {0, 0}

    for x = -8, 8, 1 do
      for y = -3, 3 do
        game.surfaces[1].set_tiles{{position = {x, y}, name = "empty-space"}}
      end
    end

    for x = -1, 0, 1 do
      for y = -1, 0 do
        game.surfaces[1].set_chunk_generated_status({x, y}, defines.chunk_generated_status.entities)
      end
    end

    local story_table =
    {
      {
        {
          name = "start",
          action = function() game.surfaces[1].create_entity{name="]]..name..[[", position = {0, 0}, velocity = {0, 0.011}} end
        },
        {
          condition = story_elapsed_check(]]..wait..[[),
          action = function() story_jump_to(storage.story, "start") end
        }
      }
    }
    tip_story_init(story_table)
  ]]
end

simulations.factoriopedia_small_infinity_asteroid = { hide_factoriopedia_gradient = true, init = make_asteroid_simulation("small-infinity-asteroid", "7") }
simulations.factoriopedia_medium_infinity_asteroid = { hide_factoriopedia_gradient = true, init = make_asteroid_simulation("medium-infinity-asteroid", "9") }
simulations.factoriopedia_big_infinity_asteroid = { hide_factoriopedia_gradient = true, init = make_asteroid_simulation("big-infinity-asteroid", "11") }
simulations.factoriopedia_huge_infinity_asteroid = { hide_factoriopedia_gradient = true, init = make_asteroid_simulation("huge-infinity-asteroid", "18") }


for asteroid_size, asteroid_size_name in pairs(asteroid_sizes) do
  for asteroid_type, asteroid_data in pairs(asteroids_data) do

    local graphics_scale = graphics_scale[asteroid_size]
    local collision_radius = collision_radiuses[asteroid_size]
    local selection_radius = collision_radius * 1.1 + 0.1
    local max_health = asteroid_data.max_health[asteroid_size] > 0 and asteroid_data.max_health[asteroid_size] or nil
    local asteroid_name, resistances, factoriopedia_sim
    local dying_trigger_effects =
    {
      {
        type = asteroid_size_name == "chunk" and "create-entity" or "create-explosion",
        entity_name = asteroid_type.."-asteroid-explosion-"..asteroid_size,
      }
    }

    if asteroid_size_name == "chunk" then
      asteroid_name = asteroid_type .. "-asteroid-chunk"
    else
      asteroid_name = asteroid_size_name .. "-"..asteroid_type.."-asteroid"
      factoriopedia_sim = simulations["factoriopedia_" .. asteroid_size_name .. "_" .. asteroid_type .. "_asteroid"]
      local spread = collision_radius * 0.5

      if asteroid_size == 2 then
        table.insert(dying_trigger_effects,
        {
          type = "create-asteroid-chunk",
          asteroid_name = asteroid_type.."-asteroid-chunk",
          offset_deviation = {{-spread, -spread}, {spread, spread}},
          offsets =
          {
            {-spread/2, -spread/4},
            {spread/2, -spread/4}
          }
        })
      else
        table.insert(dying_trigger_effects,
        {
          type = "create-entity",
          entity_name = asteroid_sizes[asteroid_size-1] .. "-"..asteroid_type.."-asteroid",
          offset_deviation = {{-spread, -spread}, {spread, spread}},
          offsets =
          {
            {-spread, -spread/4},
            {0, -spread/2},
            {spread, -spread/4}
          }
        })
      end

      resistances = {}
      for damage_name, damage_type in pairs(data.raw["damage-type"]) do
        if asteroid_data.resistances[damage_name] then
          table.insert(resistances,
          {
            type = damage_name,
            decrease = asteroid_data.resistances[damage_name].decrease[asteroid_size],
            percent = asteroid_data.resistances[damage_name].percent[asteroid_size]
          })
        else
          if damage_name ~= "impact" and damage_name ~= "poison" and damage_name ~= "acid" then
            table.insert(resistances,
            {
              type = damage_name,
              percent = 100
            })
          end
        end
      end
    end


    local variations ={}
    if (asteroid_type == "infinity") then
      if (asteroid_size_name == "chunk") then
        table.insert(variations, asteroid_variation(asteroid_type, "01", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "02", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "03", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "04", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "05", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "06", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "07", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "08", graphics_scale, asteroid_size))
      elseif (asteroid_size_name == "small") then
        table.insert(variations, asteroid_variation(asteroid_type, "01", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "02", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "03", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "04", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "05", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "06", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "07", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "08", graphics_scale, asteroid_size))
      elseif  (asteroid_size_name == "medium") then
     --   table.insert(variations, asteroid_variation("test", "00", graphics_scale, asteroid_size))
       -- table.insert(variations, asteroid_variation("test", "02", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "01", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "02", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "03", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "04", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "05", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "06", graphics_scale, asteroid_size))
      elseif (asteroid_size_name == "big") then
        table.insert(variations, asteroid_variation(asteroid_type, "01", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "02", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "03", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "04", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "05", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "06", graphics_scale, asteroid_size))
      elseif  (asteroid_size_name == "huge") then
        table.insert(variations, asteroid_variation(asteroid_type, "01", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "02", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "03", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "04", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "05", graphics_scale, asteroid_size))
        table.insert(variations, asteroid_variation(asteroid_type, "06", graphics_scale, asteroid_size))
      end
    end

    data:extend
    {
      {
        type = asteroid_size_name == "chunk" and "asteroid-chunk" or "asteroid",
        name = asteroid_name,
        overkill_fraction = asteroid_size_name ~= "chunk" and 0.01 or nil,
        localised_description = {"entity-description."..asteroid_type.."-asteroid"},
        icon = "__Infinity__/graphics/icons/"..asteroid_name..".png",
        icon_size = 64,
        selection_box = asteroid_size_name ~= "chunk" and {{-selection_radius, -selection_radius}, {selection_radius, selection_radius}} or nil,
        collision_box = {{-collision_radius, -collision_radius}, {collision_radius, collision_radius}},
        collision_mask = asteroid_size_name ~= "chunk" and {layers={object=true}, not_colliding_with_itself=true} or nil,
        graphics_set = asteroid_graphics_set(0.0003 * (6 - asteroid_size), asteroids_data[asteroid_type].shading_data, variations),
        dying_trigger_effect = dying_trigger_effects,

        subgroup = asteroid_size_name == "chunk" and "space-material" or "space-environment",
        order = asteroid_data.order .. "["..asteroid_type.."]-"..letter[asteroid_size].."["..asteroid_size_name.."]",
        factoriopedia_simulation = factoriopedia_sim,

        -- asteroid-chunk properties
        minable = asteroid_size_name == "chunk" and {mining_time = 0.2, result = asteroid_name, mining_particle = asteroid_type.."-asteroid-chunk-particle-medium" } or nil,

        -- asteroid properties
        flags = asteroid_size_name ~= "chunk" and {"placeable-enemy", "placeable-off-grid", "not-repairable", "not-on-map"} or nil,
        max_health = asteroid_size_name ~= "chunk" and asteroid_data.max_health[asteroid_size] or nil,
        mass = asteroid_size_name ~= "chunk" and asteroid_data.mass[asteroid_size] or nil,
        resistances = resistances,
      }
    }
  end
end


local default_ended_in_water_trigger_effect = function()
  return
  {

    {
      type = "create-particle",
      probability = 1,
      affects_target = false,
      show_in_tooltip = false,
      particle_name = "tintable-water-particle",
      apply_tile_tint = "secondary",
      offset_deviation = { { -0.05, -0.05 }, { 0.05, 0.05 } },
      initial_height = 0,
      initial_height_deviation = 0.02,
      initial_vertical_speed = 0.05,
      initial_vertical_speed_deviation = 0.05,
      speed_from_center = 0.01,
      speed_from_center_deviation = 0.006,
      frame_speed = 1,
      frame_speed_deviation = 0,
      tail_length = 2,
      tail_length_deviation = 1,
      tail_width = 3
    },
    {
      type = "create-particle",
      repeat_count = 10,
      repeat_count_deviation = 6,
      probability = 0.03,
      affects_target = false,
      show_in_tooltip = false,
      particle_name = "tintable-water-particle",
      apply_tile_tint = "primary",
      offsets =
      {
        { 0, 0 },
        { 0.01563, -0.09375 },
        { 0.0625, 0.09375 },
        { -0.1094, 0.0625 }
      },
      offset_deviation = { { -0.2969, -0.1992 }, { 0.2969, 0.1992 } },
      initial_height = 0,
      initial_height_deviation = 0.02,
      initial_vertical_speed = 0.053,
      initial_vertical_speed_deviation = 0.005,
      speed_from_center = 0.02,
      speed_from_center_deviation = 0.006,
      frame_speed = 1,
      frame_speed_deviation = 0,
      tail_length = 9,
      tail_length_deviation = 0,
      tail_width = 1
    },
    {
      type = "play-sound",
      sound = sounds.small_splash
    }
  }

end



local make_particle = function(params)

  if not params then error("No params given to make_particle function") end
  local name = params.name or error("No name given")

  local ended_in_water_trigger_effect = params.ended_in_water_trigger_effect or default_ended_in_water_trigger_effect()
  if params.ended_in_water_trigger_effect == false then
    ended_in_water_trigger_effect = nil
  end

  local particle =
  {

    type = "optimized-particle",
    name = name,

    life_time = params.life_time or (60 * 15),
    fade_away_duration = params.fade_away_duration,

    render_layer = params.render_layer or "projectile",
    render_layer_when_on_ground = params.render_layer_when_on_ground or "corpse",

    regular_trigger_effect_frequency = params.regular_trigger_effect_frequency or 2,
    regular_trigger_effect = params.regular_trigger_effect,
    ended_in_water_trigger_effect = ended_in_water_trigger_effect,

    pictures = params.pictures,
    shadows = params.shadows,
    draw_shadow_when_on_ground = params.draw_shadow_when_on_ground,

    movement_modifier_when_on_ground = params.movement_modifier_when_on_ground,
    movement_modifier = params.movement_modifier,
    vertical_acceleration = params.vertical_acceleration,

    mining_particle_frame_speed = params.mining_particle_frame_speed,

  }

  return particle

end

local particles =
{
make_particle
  {
    name = "infinity-asteroid-chunk-particle-small",
    life_time = 25,
    pictures = particle_animations.get_metallic_asteroid_particle_small_pictures(),
    shadows = particle_animations.get_metallic_asteroid_particle_small_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = nil,
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
    render_layer_when_on_ground = "lower-object-above-shadow"
  },
   make_particle
  {
    name = "infinity-asteroid-chunk-particle-medium",
    life_time = 45,
    pictures = particle_animations.get_metallic_asteroid_particle_medium_pictures(),
    shadows = particle_animations.get_metallic_asteroid_particle_medium_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = nil,
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
    render_layer_when_on_ground = "lower-object-above-shadow"
  },
  make_particle
  {
    name = "infinity-asteroid-particle-top-small",
    life_time = 82,
    pictures = particle_animations.get_metallic_asteroid_particle_top_small_pictures(),
    shadows = particle_animations.get_metallic_asteroid_particle_top_small_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = nil,
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
    render_layer = "air-object",
    render_layer_when_on_ground = "lower-object-above-shadow",
    movement_modifier = 0.1
  },

  make_particle
  {
    name = "infinity-asteroid-particle-top-big",
    life_time = 78,
    pictures = particle_animations.get_metallic_asteroid_particle_top_big_pictures(),
    shadows = particle_animations.get_metallic_asteroid_particle_top_big_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = nil,
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
    render_layer = "air-object",
    render_layer_when_on_ground = "lower-object-above-shadow",
    movement_modifier = 0.1
  },

  make_particle
  {
    name = "infinity-asteroid-particle-top-huge",
    life_time = 64,
    pictures = particle_animations.get_metallic_asteroid_particle_top_big_pictures({scale = 1}),
    shadows = particle_animations.get_metallic_asteroid_particle_top_big_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = nil,
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
    render_layer = "air-object",
    render_layer_when_on_ground = "lower-object-above-shadow",
    movement_modifier = 0.1
  },
    make_particle
  {
    name = "infinity-asteroid-particle-small",
    life_time = 120,
    pictures = particle_animations.get_metallic_asteroid_particle_small_pictures(),
    shadows = particle_animations.get_metallic_asteroid_particle_small_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = nil,
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
    render_layer_when_on_ground = "lower-object-above-shadow",
    movement_modifier = 0.1
  },
  make_particle
  {
    name = "infinity-asteroid-particle-medium",
    life_time = 200,
    pictures = particle_animations.get_metallic_asteroid_particle_medium_pictures(),
    shadows = particle_animations.get_metallic_asteroid_particle_medium_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = nil,
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
    render_layer_when_on_ground = "lower-object-above-shadow",
    movement_modifier = 0.1
  },
  make_particle
  {
    name = "infinity-asteroid-particle-big",
    life_time = 160,
    pictures = particle_animations.get_metallic_asteroid_particle_big_pictures(),
    shadows = particle_animations.get_metallic_asteroid_particle_big_pictures({ tint = shadowtint(), shift = util.by_pixel (1,0)}),
    regular_trigger_effect = nil,
    ended_in_water_trigger_effect = default_ended_in_water_trigger_effect(),
    render_layer_when_on_ground = "lower-object-above-shadow",
    movement_modifier = 0.1
  },
}
data:extend(particles)

data:extend({
-------------------------------------------------------------------------------
  --METALLIC-asteroid-explosionss
  -------------------------------------------------------------------------------
  --metallic-chunk
  {
    type = "explosion",
    name = "infinity-asteroid-explosion-1",
    icon = "__space-age__/graphics/icons/metallic-asteroid-chunk.png",
    flags = {"not-on-map"},
    hidden = true,
    height = 0,
    animations = explosion_animations.asteroid_explosion_chunk({tint = {0.6118, 0.4980, 0.4745, 1}}),
    sound = space_age_sounds.asteroid_collision_metallic_small,
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-trivial-smoke",
            repeat_count = 6,
            probability = 1,
            smoke_name = "asteroid-smoke-metallic-chunk",
            offset_deviation = { { -0.1, -0.1 }, { 0.1, 0.1 } },
            initial_height = -0.2,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.01
          },
          {
            type = "create-particle",
            repeat_count = 4,
            particle_name = "metallic-asteroid-chunk-particle-small",
            offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            initial_height = 0.2,
            initial_height_deviation = 0.5,
            initial_vertical_speed = 0.05,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.04,
            speed_from_center_deviation = 0.05
          },
          {
            type = "create-particle",
            repeat_count = 2,
            particle_name = "metallic-asteroid-chunk-particle-medium",
            offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            initial_height = 0.2,
            initial_height_deviation = 0.44,
            initial_vertical_speed = 0.036,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.02,
            speed_from_center_deviation = 0.046
          },
        }
      }
    }
  },
   --metallic-small
  {
    type = "explosion",
    name = "infinity-asteroid-explosion-2",
    icon = "__space-age__/graphics/icons/small-metallic-asteroid.png",
    flags = {"not-on-map"},
    hidden = true,
    height = 0,
    animations = explosion_animations.asteroid_explosion_small({tint = {0.6118, 0.4980, 0.4745, 1}}),
    sound = space_age_sounds.asteroid_damage_metallic_small,
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-trivial-smoke",
            repeat_count = 15,
            smoke_name = "asteroid-smoke-metallic-small",
            offset_deviation = { { -0.4, -0.4 }, { 0.4, 0.4 } },
            initial_height = 0,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.04
          },
          {
            type = "create-particle",
            repeat_count = 8,
            particle_name = "metallic-asteroid-particle-small",
            offset_deviation = { { -1, -1 }, { 1, 1 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.05,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 4,
            particle_name = "metallic-asteroid-particle-medium",
            offset_deviation = { { -1, -1 }, { 1, 1 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.05,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 2,
            particle_name = "metallic-asteroid-particle-big",
            offset_deviation = { { -1, -1 }, { 1, 1 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.05,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 2,
            particle_name = "metallic-asteroid-particle-top-small",
            offset_deviation = { { -0.25, -0.25 }, { 0.25, 0.25 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.02,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.01,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 1,
            particle_name = "metallic-asteroid-particle-top-big",
            offset_deviation = { { -0.15, -0.15 }, { 0.15, 0.15 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.02,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.01,
            only_when_visible = true
          }
        }
      }
    }
  },
  --metallic-medium
  {
    type = "explosion",
    name = "infinity-asteroid-explosion-3",
    icon = "__space-age__/graphics/icons/medium-metallic-asteroid.png",
    flags = {"not-on-map"},
    hidden = true,
    height = 0,
    animations = explosion_animations.asteroid_explosion_medium({tint = {0.6118, 0.4980, 0.4745, 1}}),
    sound = space_age_sounds.asteroid_damage_metallic_medium,
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-trivial-smoke",
            repeat_count = 25,
            smoke_name = "asteroid-smoke-metallic-medium",
            offset_deviation = { { -0.8, -0.8 }, { 0.8, 0.8 } },
            initial_height = 0,
            speed_from_center = 0.011,
            speed_from_center_deviation = 0.05
          },
          {
            type = "create-particle",
            repeat_count = 10,
            particle_name = "metallic-asteroid-particle-small",
            offset_deviation = { { -1.5, -1.5 }, { 1.5, 1.5 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.07,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 8,
            particle_name = "metallic-asteroid-particle-medium",
            offset_deviation = { { -1.5, -1.5 }, { 1.5, 1.5 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.07,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 4,
            particle_name = "metallic-asteroid-particle-big",
            offset_deviation = { { -1.5, -1.5 }, { 1.5, 1.5 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.07,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 4,
            particle_name = "metallic-asteroid-particle-top-small",
            offset_deviation = { { -0.45, -0.45 }, { 0.45, 0.45 } },
            initial_height = 0.1,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.02,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.01,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 2,
            particle_name = "metallic-asteroid-particle-top-big",
            offset_deviation = { { -0.3, -0.3 }, { 0.3, 0.3 } },
            initial_height = 0.1,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.02,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.01,
            only_when_visible = true
          }
        }
      }
    }
  },
  --metallic-big
  {
    type = "explosion",
    name = "infinity-asteroid-explosion-4",
    icon = "__space-age__/graphics/icons/big-metallic-asteroid.png",
    flags = {"not-on-map"},
    hidden = true,
    height = 0,
    animations = explosion_animations.asteroid_explosion_big({tint = {0.6118, 0.4980, 0.4745, 1}}),
    sound = space_age_sounds.asteroid_damage_metallic_big,
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-trivial-smoke",
            repeat_count = 50,
            smoke_name = "asteroid-smoke-metallic-big",
            offset_deviation = { { -1.3, -1.3 }, { 1.3, 1.3 } },
            initial_height = 0,
            speed_from_center = 0.014,
            speed_from_center_deviation = 0.05
          },
          {
            type = "create-trivial-smoke",
            repeat_count = 20,
            smoke_name = "asteroid-smoke-metallic-big",
            offset_deviation = { { 2.3, -1.3 }, { -1.3, -2.3 } },
            initial_height = 0,
            speed_from_center = 0.013,
            speed_from_center_deviation = 0.04
          },
          {
            type = "create-particle",
            repeat_count = 18,
            particle_name = "metallic-asteroid-particle-small",
            offset_deviation = { { -3.5, -3.5 }, { 3.5, 3.5 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.1,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 12,
            particle_name = "metallic-asteroid-particle-medium",
            offset_deviation = { { -3.5, -3.5 }, { 3.5, 3.5 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.1,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 6,
            particle_name = "metallic-asteroid-particle-big",
            offset_deviation = { { -3.5, -3.5 }, { 3.5, 3.5 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.03,
            speed_from_center_deviation = 0.1,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 6,
            particle_name = "metallic-asteroid-particle-top-small",
            offset_deviation = { { -1.2, -1.2 }, { 1.2, 1.2 } },
            initial_height = 0.2,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.02,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.01,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 3,
            particle_name = "metallic-asteroid-particle-top-big",
            offset_deviation = { { -0.8, -0.8 }, { 0.8, 0.8 } },
            initial_height = 0.2,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.02,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.01,
            only_when_visible = true
          }
        }
      }
    }
  },
  --metallic-huge
  {
    type = "explosion",
    name = "infinity-asteroid-explosion-5",
    icon = "__space-age__/graphics/icons/huge-metallic-asteroid.png",
    flags = {"not-on-map"},
    hidden = true,
    height = 0,
    animations = explosion_animations.asteroid_explosion_huge({tint = {0.6118, 0.4980, 0.4745, 1}}),
    sound = space_age_sounds.asteroid_damage_metallic_huge,
    created_effect =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-trivial-smoke",
            repeat_count = 120,
            smoke_name = "asteroid-smoke-metallic-huge",
            offset_deviation = { { -3.5, -3.5 }, { 3.5, 3.5 } },
            initial_height = 0,
            speed_from_center = 0.018,
            speed_from_center_deviation = 0.06
          },
          {
            type = "create-trivial-smoke",
            repeat_count = 60,
            smoke_name = "asteroid-smoke-metallic-big",
            offset_deviation = { { 2, 2 }, { 4, -2 } },
            initial_height = 0,
            speed_from_center = 0.012,
            speed_from_center_deviation = 0.04
          },
          {
            type = "create-particle",
            repeat_count = 48,
            particle_name = "metallic-asteroid-particle-small",
            offset_deviation = { { -5.5, -5.5 }, { 5.5, 5.5 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.05,
            speed_from_center_deviation = 0.2,
            tail_length = 2,
            tail_width = 3,
            tail_length_deviation = 4,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 34,
            particle_name = "metallic-asteroid-particle-medium",
            offset_deviation = { { -5.5, -5.5 }, { 5.5, 5.5 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.05,
            speed_from_center_deviation = 0.2,
            tail_length = 2,
            tail_width = 3,
            tail_length_deviation = 4,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 16,
            particle_name = "metallic-asteroid-particle-big",
            offset_deviation = { { -5.5, -5.5 }, { 5.5, 5.5 } },
            initial_height = 0,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.088,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.05,
            speed_from_center_deviation = 0.2,
            movement_multiplier = 1,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 10,
            particle_name = "metallic-asteroid-particle-top-small",
            offset_deviation = { { -3.1, -3.1 }, { 3.1, 3.1 } },
            initial_height = 0.6,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.02,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.01,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 5,
            particle_name = "metallic-asteroid-particle-top-big",
            offset_deviation = {{ -2.1, -2.1 }, { 2.1, 2.1 }},
            initial_height = 0.6,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.02,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.01,
            only_when_visible = true
          },
          {
            type = "create-particle",
            repeat_count = 3,
            particle_name = "metallic-asteroid-particle-top-huge",
            offset_deviation = { { -1.5, -1.5 }, { 1.5, 1.5 } },
            initial_height = 0.6,
            initial_height_deviation = 0.49,
            initial_vertical_speed = 0.02,
            initial_vertical_speed_deviation = 0.05,
            speed_from_center = 0.01,
            speed_from_center_deviation = 0.01,
            only_when_visible = true
          }
        }
      }
    }
  },

})
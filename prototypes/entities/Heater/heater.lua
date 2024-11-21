local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

data:extend(
    {
        {
            type = "recipe",
            name = "lihop-infinity-heater",
            category = "lihop-concentrating",
            enabled = false,
            energy_required = 180,
            ingredients =
            {
                { type = "item", name = "lihop-infinity-stone",  amount = 100 },
                { type = "item", name = "nuclear-reactor",       amount = 4 },
                { type = "item", name = "steam-turbine",         amount = 50 },
                { type = "item", name = "steel-plate",           amount = 1000 },
                { type = "item", name = "low-density-structure", amount = 100 },

            },
            results = { { type = "item", name = "lihop-infinity-heater", amount = 1 } }
        },
        {
            type = "item",
            name = "lihop-infinity-heater",
            icon = "__Infinity__/graphics/entities/generator/generator.png",
            icon_size = 64,
            subgroup = "energy",
            order = "f[nuclear-energy]-e[infinity-generator]",
            place_result = "lihop-infinity-heater",
            stack_size = 20,
            weight = (1000 / 20) * kg
        },
        {
            type = "reactor",
            name = "lihop-infinity-heater",
            factoriopedia_description = { "factoriopedia-description.fusion-generator" },
            icon = "__space-age__/graphics/icons/fusion-generator.png",
            flags = { "placeable-neutral", "placeable-player", "player-creation" },
            minable = { mining_time = 0.2, result = "lihop-infinity-heater" },
            max_health = 1000,
            impact_category = "metal",
            resistances =
            {
                {
                    type = "fire",
                    percent = 70
                }
            },
            collision_box = { { -2.2, -2.2 }, { 2.2, 2.2 } },
            selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
            damaged_trigger_effect = hit_effects.entity(),
            lower_layer_picture =
            {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes.png",
                width = 320,
                height = 316,
                scale = 0.5,
                shift = util.by_pixel(-1, -5)
            },
            heat_lower_layer_picture = apply_heat_pipe_glow
                {
                    filename = "__base__/graphics/entity/nuclear-reactor/reactor-pipes-heated.png",
                    width = 320,
                    height = 316,
                    scale = 0.5,
                    shift = util.by_pixel(-0.5, -4.5)
                },
            working_light_picture =
            {
                filename = "__base__/graphics/entity/nuclear-reactor/reactor-lights-color.png",
                blend_mode = "additive",
                draw_as_glow = true,
                width = 320,
                height = 320,
                scale = 0.5,
                shift = { -0.03125, -0.1875 },
            },

            picture =
            {
                layers =
                {
                    {
                        filename = "__base__/graphics/entity/nuclear-reactor/reactor.png",
                        width = 302,
                        height = 318,
                        scale = 0.5,
                        shift = util.by_pixel(-5, -7)
                    },
                    {
                        filename = "__base__/graphics/entity/nuclear-reactor/reactor-shadow.png",
                        width = 525,
                        height = 323,
                        scale = 0.5,
                        shift = { 1.625, 0 },
                        draw_as_shadow = true
                    }
                }
            },
            working_sound =
            {
                sound =
                {
                    filename = "__space-age__/sound/entity/fusion/fusion-generator.ogg",
                    volume = 0.15,
                    speed_smoothing_window_size = 60,
                    advanced_volume_control = { attenuation = "exponential" }
                },
                use_doppler_shift = false,
                match_speed_to_activity = true,
                activity_to_speed_modifiers = { multiplier = 1.2 },
                match_volume_to_activity = true,
                audible_distance_modifier = 0.8,
                max_sounds_per_type = 2,
                fade_in_ticks = 4,
                fade_out_ticks = 20
            },
            vehicle_impact_sound = sounds.generic_impact,
            open_sound = sounds.metal_large_open,
            close_sound = sounds.metal_large_close,
            consumption = "80MW",
            heat_buffer =
            {
                max_temperature = 1000,
                specific_heat = "10MJ",
                max_transfer = "10GW",
                connections =
                {
                    {
                        position = { -2, -2 },
                        direction = defines.direction.north
                    },
                    {
                        position = { 2, -2 },
                        direction = defines.direction.north
                    },
                    {
                        position = { 2, -2 },
                        direction = defines.direction.east
                    },
                    {
                        position = { 2, 2 },
                        direction = defines.direction.east
                    },
                    {
                        position = { 2, 2 },
                        direction = defines.direction.south
                    },
                    {
                        position = { -2, 2 },
                        direction = defines.direction.south
                    },
                    {
                        position = { -2, 2 },
                        direction = defines.direction.west
                    },
                    {
                        position = { -2, -2 },
                        direction = defines.direction.west
                    }
                },
            },
            energy_source =
            {
                type = "fluid",
                --fluid_usage_per_tick = 1, --1 per second
                scale_energy_usage = false,
                fluid_box =
                {
                    volume = 15,
                    production_type = "input-output",
                    pipe_connections =
                    {
                        { flow_direction = "input-output", direction = defines.direction.south, position = { 0, 2 },  connection_category = { "fusion-plasma" } },
                        { flow_direction = "input-output", direction = defines.direction.north, position = { 0, -2 }, connection_category = { "fusion-plasma" } },
                        { flow_direction = "input-output", direction = defines.direction.west,  position = { -2, 0 }, connection_category = { "fusion-plasma" } },
                        { flow_direction = "input-output", direction = defines.direction.east,  position = { 2, 0 },  connection_category = { "fusion-plasma" } },
                    },
                    filter = "fusion-plasma"
                }
            },
        },
    })

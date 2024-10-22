local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

Cnorth = {
	layers =
	{
		{
			priority = "high",
			filename = "__Infinity__/graphics/entities/pumpjack/pump-S.png",
			line_length = 4,
			width = 133,
			height = 179,
			frame_count = 32,
			animation_speed = 1,
			scale = 0.7,
			shift = util.by_pixel(0, -5)
		},
		{
			priority = "high",
			filename = "__Infinity__/graphics/entities/pumpjack/pump-S-shadow.png",
			line_length = 4,
			width = 253,
			height = 180,
			frame_count = 32,
			animation_speed = 1,
			draw_as_shadow = true,
			scale = 0.7,
			shift = util.by_pixel(40, -5)
		}
	}
}
Ceast = {
	layers =
	{
		{
			filename = "__Infinity__/graphics/entities/pumpjack/pump-W.png",
			priority = "high",
			width = 136,
			height = 179,
			frame_count = 32,
			line_length = 4,
			shift = util.by_pixel(0, -5),
			scale = 0.7
		},
		{
			priority = "high",
			filename = "__Infinity__/graphics/entities/pumpjack/pump-W-shadow.png",
			line_length = 4,
			width = 254,
			height = 180,
			frame_count = 32,
			scale = 0.7,
			draw_as_shadow = true,
			shift = util.by_pixel(40, -5)
		}
	}
}
Csouth = {
	layers =
	{
		{
			priority = "high",
			filename = "__Infinity__/graphics/entities/pumpjack/pump-S.png",
			line_length = 4,
			width = 133,
			height = 179,
			frame_count = 32,
			animation_speed = 1,
			scale = 0.7,
			shift = util.by_pixel(0, -5)
		},
		{
			priority = "high",
			filename = "__Infinity__/graphics/entities/pumpjack/pump-S-shadow.png",
			draw_as_shadow = true,
			line_length = 4,
			width = 253,
			height = 180,
			frame_count = 32,
			animation_speed = 1,
			scale = 0.7,
			shift = util.by_pixel(40, -5)
		}
	}
}
Cwest = {
	layers =
	{
		{
			filename = "__Infinity__/graphics/entities/pumpjack/pump-W.png",
			priority = "high",
			width = 136,
			height = 179,
			frame_count = 32,
			line_length = 4,
			shift = util.by_pixel(0, -5),
			scale = 0.7
		},
		{
			priority = "high",
			filename = "__Infinity__/graphics/entities/pumpjack/pump-W-shadow.png",
			draw_as_shadow = true,
			line_length = 4,
			width = 254,
			height = 180,
			frame_count = 32,
			scale = 0.7,
			shift = util.by_pixel(40, -5)
		}
	}
}

data:extend(
	{
		{
			type = "recipe",
			name = "lihop-infinity-pump-jack",
			category = "lihop-concentrating",
			enabled = false,
			energy_required = 2,
			ingredients =
			{
				{ type = "item", name = "pumpjack",          amount = 10 },
				{ type = "item", name = "lihop-infinity-stone", amount = 10 },
				{ type = "item", name = "steel-plate",       amount = 100 },
				{ type = "item", name = "low-density-structure", amount = 20 }

			},
			results = { { type = "item", name = "lihop-infinity-pump-jack", amount = 1 } }
		},
		{
			type = "item",
			name = "lihop-infinity-pump-jack",
			icon = "__Infinity__/graphics/entities/pumpjack/pumpicons.png",
			icon_size = 64,
			icon_mipmaps = 4,
			subgroup = "extraction-machine",
			order = "b[fluids]-c[infinity-pumpjack]",
			place_result = "lihop-infinity-pump-jack-fake",
			stack_size = 20
		},

		---- The real entity, placed by script
		{
			type = "assembling-machine",
			name = "lihop-infinity-pump-jack",
			icon = "__Infinity__/graphics/entities/pumpjack/pumpicons.png",
			icon_size = 64,
			icon_mipmaps = 4,
			flags = { "placeable-neutral", "placeable-player", "player-creation" },
			minable = { mining_time = 0.1, result = "lihop-infinity-pump-jack" },
			max_health = 300,
			placeable_by = { item = "lihop-infinity-pump-jack", count = 1 },
			corpse = "medium-remnants",
			dying_explosion = "medium-explosion",
			collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
			selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
			damaged_trigger_effect = hit_effects.entity(),
			drawing_box = { { -1.5, -1.9 }, { 1.5, 1.5 } },
			module_specification =
			{
				module_slots = 0
			},
			allowed_effects = {},

			graphics_set={animation =
			{
				north = Cnorth,
				east = Ceast,
				south = Csouth,
				west = Cwest

			}},
			vehicle_impact_sound = sounds.generic_impact,
			open_sound = sounds.machine_open,
			close_sound = sounds.machine_close,
			working_sound =
			{
				sound =
				{
					{
						filename = "__base__/sound/chemical-plant-1.ogg",
						volume = 0.5
					},
					{
						filename = "__base__/sound/chemical-plant-2.ogg",
						volume = 0.5
					},
					{
						filename = "__base__/sound/chemical-plant-3.ogg",
						volume = 0.5
					}
				},
				--max_sounds_per_type = 3,
				--idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.3 },
				apparent_volume = 1.5,
				fade_in_ticks = 4,
				fade_out_ticks = 20
			},
			supports_direction = true,
			crafting_speed = 1,
			energy_source =
			{
				type = "electric",
				usage_priority = "secondary-input",
				emissions_per_minute = { pollution = 4 }
			},
			energy_usage = "210kW",
			crafting_categories = { "lihop-excavate-fluid" },
			fluid_boxes_off_when_no_fluid_recipe = true,
			fluid_boxes =
			{
				{
					production_type = "input",
					pipe_covers = pipecoverspictures(),
					--pipe_picture = assembler2pipepictures(),
					volume = 1000,
					pipe_connections = { { flow_direction = "input", direction = defines.direction.south, position = { 0, 1.199 } } },
					secondary_draw_orders = { north = -1 }
				},
				{
					production_type = "output",
					pipe_covers = pipecoverspictures(),
					--pipe_picture = assembler2pipepictures(),
					volume = 1000,
					pipe_connections = { { flow_direction = "output", direction = defines.direction.north, position = { 0, -1.199 } } },
					secondary_draw_orders = { north = -1 }
				},
			}
		},

		---- false entity just use to force placement on liquid field
		{
			type = "mining-drill",
			name = "lihop-infinity-pump-jack-fake",
			icon = "__Infinity__/graphics/entities/pumpjack/pumpicons.png",
			icon_size = 64,
			icon_mipmaps = 4,
			flags = { "placeable-neutral", "player-creation" },
			minable = { mining_time = 0.5, result = "lihop-infinity-pump-jack" },
			resource_categories = lihop.pumptype,
			max_health = 200,
			corpse = "big-remnants",
			dying_explosion = "big-explosion",
			collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
			selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
			drawing_box = { { -1.6, -2.5 }, { 1.5, 1.6 } },
			energy_source =
			{
				type = "electric",
				emissions_per_minute = { pollution = 10 },
				usage_priority = "secondary-input"
			},
			output_fluid_box =
			{
				pipe_covers = pipecoverspictures(),
				volume = 1000,
				pipe_connections = { { flow_direction = "output", direction = defines.direction.north, position = { 0, -1.119 } } },
			},
			energy_usage = "90kW",
			mining_speed = lihop.settings.oreAmount / 2,
			resource_searching_radius = 0.49,
			vector_to_place_result = { 0, 0 },
			radius_visualisation_picture =
			{
				filename = "__base__/graphics/entity/pumpjack/pumpjack-radius-visualization.png",
				width = 12,
				height = 12
			},
			monitor_visualization_tint = { r = 78, g = 173, b = 255 },
			-- base_render_layer = "lower-object-above-shadow",
			-- base_picture =
			-- {
			-- 	sheets =
			-- 	{
			-- 		{
			-- 			filename = "__Infinity__/graphics/entities/pumpjack/base.png",
			-- 			priority = "extra-high",
			-- 			width = 136,
			-- 			height = 179,
			-- 			scale = 0.7,
			-- 			shift = util.by_pixel(0, -5),
			-- 		},
			-- 		{
			-- 			filename = "__Infinity__/graphics/entities/pumpjack/base-shadow.png",
			-- 			priority = "extra-high",
			-- 			width = 254,
			-- 			height = 180,
			-- 			draw_as_shadow = true,
			-- 			scale = 0.7,
			-- 			shift = util.by_pixel(40, -5),
			-- 		}
			-- 	}
			-- },
			graphics_set={animation =
			{
				north =
				{
					layers =
					{
						{
							priority = "high",
							filename = "__Infinity__/graphics/entities/pumpjack/pump-S.png",
							line_length = 4,
							width = 133,
							height = 179,
							frame_count = 32,
							animation_speed = 1,
							scale = 0.7,
							shift = util.by_pixel(0, -5)
						},
						{
							priority = "high",
							filename = "__Infinity__/graphics/entities/pumpjack/pump-S-shadow.png",
							line_length = 4,
							width = 253,
							height = 180,
							frame_count = 32,
							animation_speed = 1,
							draw_as_shadow = true,
							scale = 0.7,
							shift = util.by_pixel(40, -5)
						}
					}
				},
				east =
				{
					layers =
					{
						{
							filename = "__Infinity__/graphics/entities/pumpjack/pump-W.png",
							priority = "high",
							width = 136,
							height = 179,
							frame_count = 32,
							line_length = 4,
							shift = util.by_pixel(0, -5),
							scale = 0.7
						},
						{
							priority = "high",
							filename = "__Infinity__/graphics/entities/pumpjack/pump-W-shadow.png",
							line_length = 4,
							width = 254,
							height = 180,
							frame_count = 32,
							scale = 0.7,
							draw_as_shadow = true,
							shift = util.by_pixel(40, -5)
						}
					}
				},
				south =
				{
					layers =
					{
						{
							priority = "high",
							filename = "__Infinity__/graphics/entities/pumpjack/pump-S.png",
							line_length = 4,
							width = 133,
							height = 179,
							frame_count = 32,
							animation_speed = 1,
							scale = 0.7,
							shift = util.by_pixel(0, -5)
						},
						{
							priority = "high",
							filename = "__Infinity__/graphics/entities/pumpjack/pump-S-shadow.png",
							draw_as_shadow = true,
							line_length = 4,
							width = 253,
							height = 180,
							frame_count = 32,
							animation_speed = 1,
							scale = 0.7,
							shift = util.by_pixel(40, -5)
						}
					}
				},
				west =
				{
					layers =
					{
						{
							filename = "__Infinity__/graphics/entities/pumpjack/pump-W.png",
							priority = "high",
							width = 136,
							height = 179,
							frame_count = 32,
							line_length = 4,
							shift = util.by_pixel(0, -5),
							scale = 0.7
						},
						{
							priority = "high",
							filename = "__Infinity__/graphics/entities/pumpjack/pump-W-shadow.png",
							draw_as_shadow = true,
							line_length = 4,
							width = 254,
							height = 180,
							frame_count = 32,
							scale = 0.7,
							shift = util.by_pixel(40, -5)
						}
					}
				}
			}},
			working_sound =
			{
				sound =
				{
					{
						filename = "__base__/sound/pumpjack.ogg",
						volume = 0.7
					},
					--{
					--  filename = "__base__/sound/pumpjack-1.ogg",
					--  volume = 0.43
					--}
				},
				max_sounds_per_type = 3,
				audible_distance_modifier = 0.6,
				fade_in_ticks = 4,
				fade_out_ticks = 10
			},
			resource_drain_rate_percent = 1
		}
	})

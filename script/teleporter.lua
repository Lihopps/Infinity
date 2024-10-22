local gui = require("__flib__.gui")
local util = require("script.util")

local teleporter = {}

-- TODO: revoir le available
---- Check if teleporter have enought energy
local function isAvailable(entity)
	local percent_full =
		math.ceil((entity.energy / entity.prototype.electric_energy_source_prototype.buffer_capacity) * 100)
	local fully_charged = percent_full == 100
	if (fully_charged) then
		return true
	else
		return false
	end
end

local function update_surface_name(refs, player, entity)
	if not storage.lihop_buildings[player.force.name] then return end
	refs.frame_surface.clear()
	surfaces = {}
	for name, surf in pairs(storage.lihop_buildings[player.force.name]) do
		if surf["teleporter"] then
			table.insert(surfaces,
				{
					type = "button",
					name = "button_tel_" .. name,
					caption = name,
					style = "inf_list_box_item",
					actions = {
						on_click = {
							gui = "lihop_teleporter",
							action = "select_surface",
							name = name,
							entity = { force = entity.force.name, unit_number = entity.unit_number, surface = entity.surface.name }
						}
					}
				})
		end
	end
	gui.build(refs.frame_surface, surfaces)
end

local function update_list_teleport(refs, entity, player, surface_name)
	local list_teleport = refs.table_teleporter
	local teleport = {}
	list_teleport.clear()
	refs.surface_name_label.caption=surface_name
	if not storage.lihop_buildings[player.force.name] then return end
	if not storage.lihop_buildings[player.force.name][surface_name] then return end
	if storage.lihop_buildings[player.force.name][surface_name]["teleporter"] then
		for number, data in pairs(storage.lihop_buildings[player.force.name][surface_name]["teleporter"]) do
			local teleporter = data.ent
			-- on test si c'est pas lui meme
			if entity.unit_number ~= teleporter.unit_number then
				-- on test si il est alimenté
					table.insert(teleport,
						{
							type = "frame",
							style = "deep_frame_in_shallow_frame",
							direction="vertical",
							--style_mods = { horizontally_stretchable = true },
							{
								type = "minimap",
								position = teleporter.position,
								surface_index = teleporter.surface.index,
								zoom = 5
							},
							{
								type="button",
								caption=data.name,
								enabled=isAvailable(teleporter),
								style_mods = { horizontally_stretchable = true },
								tooltip = { "gui.lihop-rename-tooltip" },
								actions = {
									on_click = { 
										gui = "lihop_teleporter", 
										action = "teleportation",
										fromentity = { force = entity.force.name or entity.force, surface = entity.surface.name or entity.surface, number = entity.unit_number },
										entity = { force = teleporter.force.name, surface = teleporter.surface.name, unit_number = teleporter.unit_number }
									}
								}
							}
						})
			end
		end
	end
	gui.build(list_teleport, teleport)
end

------------------------------------------------------------------------------------
-------------------------------------------- GUI -----------------------------------
------------------------------------------------------------------------------------


function teleporter.create_gui(entity, player)
	local data = storage.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"][entity.unit_number]
	local refs = gui.build(player.gui.screen, {
		{
			type = "frame",
			direction = "vertical",
			name = "lihop_tel_frame",
			ref = { "lihop_tel_frame" },
			auto_center = false,
			style_mods = {minimal_width=500, height = 900 },
			actions = {
				on_closed = { gui = "lihop_teleporter", action = "close", entity = { force = entity.force.name, surface = entity.surface.name, unit_number = entity.unit_number } },
			},
			children = {
				-- bar du haut
				{
					type = "flow",
					style_mods = { horizontally_squashable = true },
					ref = { "titlebar" },
					children = {
						{
							type = "label",
							style = "subheader_caption_label",
							rich_text_setting = "enabled",
							caption = data.name,
							ref = { "name_label" },
						},
						{
							type = "textfield",
							visible = false,
							ref = { "name_textfield" },
							style_mods = {
								maximal_width = 0,
								top_margin = -3,
								right_padding = 0,
								horizontally_stretchable = true
							},
							rich_text_setting = "enabled",
							actions = {
								on_confirmed = {
									gui = "lihop_teleporter",
									action = "rename",
									entity = { force = entity.force.name, surface = entity.surface.name, unit_number = entity.unit_number }
								},
								on_text_changed = {
									gui = "lihop_teleporter", action = "update_name", entity = { force = entity.force.name, surface = entity.surface.name, unit_number = entity.unit_number }
								},
							},
						},
						{
							type = "choose-elem-button",
							style_mods = { left_padding = 0, size = { 28, 28 }, top_margin = -3 },
							elem_type = "signal",
							name = entity.force.name .. "/-" .. entity.surface.name .. "/-" .. entity.unit_number,
							ref = { "texticon_lihop_teleporter" },
							visible = false,
							actions = {
								on_gui_elem_changed = { gui = "lihop_teleporter", action = "choose", entity = { force = entity.force.name, surface = entity.surface.name, unit_number = entity.unit_number } },
							},
						},
						{
							type = "sprite-button",
							style = "frame_action_button",
							sprite = "utility/rename_icon_small_white",
							tooltip = { "gui.lihop-rename-tooltip" },
							actions = {
								on_click = { gui = "lihop_teleporter", action = "rename", entity = { force = entity.force.name, surface = entity.surface.name, unit_number = entity.unit_number } },
							},
						},
						{
							type = "empty-widget",
							style = "draggable_space_header",
							style_mods = { height = 24, horizontally_stretchable = true, right_margin = 4 },
							ignored_by_interaction = true,
						},
						{
							type = "sprite-button",
							style = "frame_action_button",
							sprite = "utility/close_white",
							ref = { "button_close" },
							hovered_sprite = "utility/close_black",
							clicked_sprite = "utility/close_black",
							tooltip = { "gui.close-instruction" },
							actions = {
								on_click = { gui = "lihop_teleporter", action = "close", entity = { force = entity.force.name, surface = entity.surface.name, unit_number = entity.unit_number } },
							},
						},
					},
				},
				-- frame principale
				{
					type = "frame",
					style = "inside_shallow_frame",
					style_mods = { vertically_stretchable = true },
					direction = "vertical",
					children =
					{
						{
							type = "frame",
							style = "deep_frame_in_shallow_frame",
							children = {
								{ type = "entity-preview", style = "wide_entity_button", elem_mods = { entity = entity } },
							},
						},
						{
							type = "frame",
							name = "fprinc",
							direction = "horizontal",
							style_mods = { vertically_stretchable = true,horizontally_squashable= true },
							{
								type = "frame",
								style_mods = { vertically_stretchable = true,minimal_width=150 },
								visible = player.force.technologies["lihop-infinity-teleportation"].researched,
								{
									type="frame",
									style_mods = { vertically_stretchable = true },
									style="deep_frame_in_shallow_frame",
									{
										type = "scroll-pane",
										style = "inf_list_box_scroll_pane",
										style_mods = { vertically_stretchable = true, },
										name = "frame_surface",
										ref = { "frame_surface" },
									}
								},
							},
							{
								type = "frame",
								name = "frame_minimap",
								style_mods = { horizontally_stretchable = true },
								direction = "vertical",
								{
									type = "label",
									caption=player.surface.name,
									ref={"surface_name_label"}
								},
								{
									type = "scroll-pane",
									horizontal_scroll_policy="never",
									--style_mods = { horizontally_stretchable = true },
									{
										type = "table",
										style = "inset_frame_container_table",
										--style_mods = { horizontally_stretchable = true },
										name = "table_teleporter",
										ref = { "table_teleporter" },
										column_count = 3
									}
								}
							}
						}
					}
				}
			}
		}
	})

	refs.titlebar.drag_target = refs.lihop_tel_frame
	refs.lihop_tel_frame.force_auto_center()
	update_surface_name(refs, player, entity)
	update_list_teleport(refs, entity, player, player.surface.name)
	refs.texticon_lihop_teleporter.elem_value = { type = "item", name = "lihop-false-item" }
	player.opened = refs.lihop_tel_frame
	storage.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"][entity.unit_number].refs[player.index] =
		refs
end

function teleporter.handle_gui_action(msg, e)
	local player = game.get_player(e.player_index)
	local entity = msg.entity
	if not player then return end
	if msg.action == "close" then
		if player.opened then
			if player.opened.name == "lihop_tel_frame" then
				local refs = player.opened
				if not refs then return end
				refs.destroy()
				player.opened = nil
			end
		else
			if storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs[e.player_index] then
				storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs[e.player_index]
					.lihop_tel_frame.destroy()
				storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs[e.player_index] = nil
			end
		end
	elseif msg.action == "rename" then
		local refs = storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs
			[e.player_index]
		local textfield = refs.name_textfield
		local texticon = refs.texticon_lihop_teleporter
		local label = refs.name_label
		if textfield.visible then
			textfield.visible = false
			texticon.visible = false
			label.caption = textfield.text --storage.teleporteur[msg.number].name
			label.visible = true
			storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].name = textfield.text
			local mess = { action = "close" }
			local ee = { player_index = e.player_index }

			teleporter.handle_gui_action(mess, ee)
			teleporter.create_gui(
				storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].ent, player)
		else
			textfield.text = storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].name or
				""
			textfield.visible = true
			texticon.visible = true
			textfield.select_all()
			textfield.focus()
			label.visible = false
		end
	elseif msg.action == "update_name" then
		storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].name = e.text ~= "" and
			e.text or nil
	elseif msg.action == "choose" then
		local refs = storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs
			[e.player_index]
		local textfield = refs.name_textfield
		local texticon = refs.texticon_lihop_teleporter
		if texticon.elem_value then
			textfield.text = textfield.text .. "[item=" .. texticon.elem_value.name .. "]"
			texticon.elem_value = { type = "item", name = "lihop-false-item" }
		end
		textfield.focus()
	elseif msg.action == "select_surface" then
		--game.print(msg.name)
		update_list_teleport(
			storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs[e.player_index],
			entity, player, msg.name)
	elseif msg.action == "teleportation" then
		local mess = { action = "close", }
		local ee = { player_index = e.player_index }
		teleporter.handle_gui_action(mess, ee)

		local fromentity = storage.lihop_buildings[msg.fromentity.force][msg.fromentity.surface]["teleporter"]
			[msg.fromentity.number].ent
		local ent = storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].ent

		if isAvailable(ent) then
			local area = fromentity.bounding_box
			local players_to_tel = fromentity.surface.find_entities_filtered { area = area, type = "character" }
			if #players_to_tel > 0 then
				for _, character in pairs(players_to_tel) do
					if character.player and character.player.valid then
						character.player.teleport(ent.position, ent.surface)
					end
				end
			else
				player.create_local_flying_text{text={"gui.no_player"},position=fromentity.position,color= { r = 255 / 255, g = 0, b = 0 }}
			end
		else
			player.create_local_flying_text{text={"gui.not_enought_power"},position=fromentity.position,color= { r = 255 / 255, g = 0, b = 0 }}
		end
		fromentity.energy = 0
		ent.energy = 0
	end
end

return teleporter

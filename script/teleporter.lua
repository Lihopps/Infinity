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

local function update_surface_name(refs,player)
	if not global.lihop_buildings[player.force.name] then return end
	local index=1
	for name,surf in pairs(global.lihop_buildings[player.force.name]) do
		if surf["teleporter"] then
			refs.surface_changer.add_item(name)
			if name==player.surface.name then
				refs.surface_changer.selected_index=index
			end
			index=index+1
		end
	end
end

local function update_list_teleport(refs, entity, player, surface_name)
	local list_teleport = refs.list_teleport
	local index = 1
	local teleport = {}
	list_teleport.clear()
	if not global.lihop_buildings[player.force.name] then return end
	if not global.lihop_buildings[player.force.name][surface_name] then return end
	if global.lihop_buildings[player.force.name][surface_name]["teleporter"] then
		for number, data in pairs(global.lihop_buildings[player.force.name][surface_name]["teleporter"]) do
			local teleporter = data.ent
			-- on test si c'est pas lui meme
			if entity.unit_number ~= teleporter.unit_number then
				-- on test si il est alimenté
				if isAvailable(teleporter) then
					table.insert(teleport,
						{
							type = "frame",
							style = "deep_frame_in_shallow_frame",
							style_mods = { horizontally_stretchable = true },
							{
								type = "button",
								caption = data.name,
								style_mods = { horizontally_stretchable = true },
								tooltip = { "gui.teleport_tip" },
								actions = {
									on_click = {
										gui = "lihop_teleporter",
										action = "teleportation",
										fromentity = { force = entity.force.name, surface = entity.surface.name, number = entity.unit_number },
										entity = { force = teleporter.force.name, surface = teleporter.surface.name, number = teleporter.unit_number }
									},
								},
							},
						})
				end
			end
		end
	end
	gui.build(list_teleport, teleport)
end

------------------------------------------------------------------------------------
-------------------------------------------- GUI -----------------------------------
------------------------------------------------------------------------------------


function teleporter.create_gui(entity, player)
	local data = global.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"][entity.unit_number]
	local refs = gui.build(player.gui.screen, {
		{
			type = "frame",
			direction = "vertical",
			name = "lihop_tel_frame",
			ref = { "lihop_tel_frame" },
			actions = {
				on_closed = { gui = "lihop_teleporter", action = "close", entity = { force = entity.force.name, surface = entity.surface.name, number = entity.unit_number } },
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
							style_mods = { maximal_width = 370 },
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
									entity = { force = entity.force.name, surface = entity.surface.name, number = entity.unit_number }
								},
								on_text_changed = {
									gui = "lihop_teleporter", action = "update_name", entity = { force = entity.force.name, surface = entity.surface.name, number = entity.unit_number }
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
								on_gui_elem_changed = { gui = "lihop_teleporter", action = "choose", entity = { force = entity.force.name, surface = entity.surface.name, number = entity.unit_number } },
							},
						},
						{
							type = "sprite-button",
							style = "frame_action_button",
							sprite = "utility/rename_icon_small_white",
							tooltip = { "gui.lihop-rename-tooltip" },
							actions = {
								on_click = { gui = "lihop_teleporter", action = "rename", entity = { force = entity.force.name, surface = entity.surface.name, number = entity.unit_number } },
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
								on_click = { gui = "lihop_teleporter", action = "close", entity = { force = entity.force.name, surface = entity.surface.name, number = entity.unit_number } },
							},
						},
					},
				},
				-- frame principale
				{
					type = "frame",
					style = "inside_shallow_frame",
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
							style = "deep_frame_in_shallow_frame",
							children = {
								{
									type = "drop-down",
									name = "surface",
									ref={"surface_changer"},
									visible=player.force.technologies["lihop-infinity-teleportation"].researched,
									actions = {
										on_selection_state_changed = { gui = "lihop_teleporter", action = "change_surface", entity = { force = entity.force.name, surface = entity.surface.name, unit_number = entity.unit_number } },
									},
								},
							},
						},
						{
							type = "scroll-pane",
							style = "scroll_pane",
							children = {
								{
									type = "frame",
									style = "frame",
									direction = "vertical",
									children = {
										{
											type = "table",
											style = "slot_table",
											column_count = 1,
											ref = { "list_teleport" }
										},
									},
								},
							},
						},
					}
				}
			}
		}
	})

	refs.titlebar.drag_target = refs.lihop_tel_frame
	refs.lihop_tel_frame.force_auto_center()
	update_surface_name(refs,player)
	update_list_teleport(refs, entity, player, player.surface.name)
	refs.texticon_lihop_teleporter.elem_value = { type = "item", name = "lihop-false-item" }
	player.opened = refs.lihop_tel_frame
	global.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"][entity.unit_number].refs[player.index] =
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
			if global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.number].refs[e.player_index] then
				global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.number].refs[e.player_index]
					.lihop_tel_frame.destroy()
				global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.number].refs[e.player_index] = nil
			end
		end
	elseif msg.action == "rename" then
		local refs = global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.number].refs[e.player_index]
		local textfield = refs.name_textfield
		local texticon = refs.texticon_lihop_teleporter
		local label = refs.name_label
		if textfield.visible then
			textfield.visible = false
			texticon.visible = false
			label.caption = textfield.text --global.teleporteur[msg.number].name
			label.visible = true
			global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.number].name = textfield.text
			local mess = { action = "close" }
			local ee = { player_index = e.player_index }

			teleporter.handle_gui_action(mess, ee)
			teleporter.create_gui(
				global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.number].ent, player)
		else
			textfield.text = global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.number].name or
				""
			textfield.visible = true
			texticon.visible = true
			textfield.select_all()
			textfield.focus()
			label.visible = false
		end
	elseif msg.action == "update_name" then
		global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.number].name = e.text ~= "" and
			e.text or nil
	elseif msg.action == "choose" then
		local refs = global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.number].refs
			[e.player_index]
		local textfield = refs.name_textfield
		local texticon = refs.texticon_lihop_teleporter
		if texticon.elem_value then
			textfield.text = textfield.text .. "[item=" .. texticon.elem_value.name .. "]"
			texticon.elem_value = { type = "item", name = "lihop-false-item" }
		end
		textfield.focus()
	elseif msg.action=="change_surface" then
		local refs = global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs[e.player_index]
		local surface = refs.surface_changer.get_item(refs.surface_changer.selected_index)
		
		local ent={force={name=entity.force},surface={name=entity.surface},unit_number=entity.unit_number}
		update_list_teleport(refs, ent, player, surface)
	elseif msg.action == "teleportation" then
		local mess = { action = "close", }
		local ee = { player_index = e.player_index }
		teleporter.handle_gui_action(mess, ee)

		local fromentity = global.lihop_buildings[msg.fromentity.force][msg.fromentity.surface]["teleporter"][msg.fromentity.number].ent
		local ent = global.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.number].ent

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
				util.entity_flying_text(player, "gui.no_player", { r = 255 / 255, g = 0, b = 0 },fromentity.position)
			end
		else
			util.entity_flying_text(player, "gui.not_enought_power", { r = 255 / 255, g = 0, b = 0 },fromentity.position)
		end
		fromentity.energy = 0
		ent.energy = 0
	end
end

return teleporter

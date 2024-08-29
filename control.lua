local gui = require("__flib__.gui")
local migration = require("__flib__.migration")

local lihop_inf_miner = require("script.miner_pump")
local lihop_teleporter = require("script.teleporter")
local migrations = require("script.migrations")
local util = require("script.util")




--BOOTSTRAP

script.on_init(function()
	-- Initialize libraries

	-- create a table to store building needed in control
	if not global.lihop_buildings then global.lihop_buildings= {} end
	

end)


script.on_configuration_changed(function(e)
	if not global.lihop_buildings then global.lihop_buildings = {} end
	migration.on_config_changed(e, migrations.versions)
end)

--------------------------------------------------------------------------------------------------------
------------------------------------------- EVENT Surface -----------------------------------------------
--------------------------------------------------------------------------------------------------------

script.on_event({
	defines.events.on_surface_cleared,
	defines.events.on_surface_deleted,
}, function(e)
	for forcename,datforce in pairs(global.lihop_buildings) do
		for surfname,datsurf in pairs(global.lihop_buildings[forcename]) do
			if game.surfaces[surfname].index==e.surface_index then
				global.lihop_buildings[forcename][surfname]=nil
			end
		end
	end
end)

script.on_event({
	defines.events.on_surface_renamed,
}, function(e)
	for forcename,datforce in pairs(global.lihop_buildings) do
		global.lihop_buildings[forcename][e.new_name]=global.lihop_buildings[forcename][e.old_name]
		global.lihop_buildings[forcename][e.old_name]=nil
	end
end)

--------------------------------------------------------------------------------------------------------
------------------------------------------- EVENT ENTITY -----------------------------------------------
--------------------------------------------------------------------------------------------------------

script.on_event({
	defines.events.on_built_entity,
	defines.events.on_robot_built_entity,
	defines.events.script_raised_built,
	defines.events.script_raised_revive,
}, function(e)
	local entity = e.entity or e.created_entity
	local constructeur = nil
	if e.player_index then
		constructeur = game.players[e.player_index]
	else
		constructeur = e.robot
	end
	if not entity or not entity.valid then
		return
	end
	if not constructeur or not constructeur.valid then
		return
	end
	local entity_name = entity.name
	if entity.name == "lihop-infinity-miner-fake" or entity.name == "lihop-infinity-miner" then
		lihop_inf_miner.definerecipesolid(entity, constructeur)
	elseif entity.name == "lihop-infinity-pump-jack" or entity.name == "lihop-infinity-pump-jack-fake" then
		lihop_inf_miner.definerecipefluid(entity, constructeur)
	elseif entity.name == "lihop-teleporteur" then
		if not global.lihop_buildings[entity.force.name] then global.lihop_buildings[entity.force.name] = {} end
		if not global.lihop_buildings[entity.force.name][entity.surface.name] then global.lihop_buildings[entity.force.name][entity.surface.name] = {} end
        if not global.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"] then global.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"] = {} end
		global.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"][entity.unit_number] = {
            ent = entity,
            name = game.backer_names[math.random(#game.backer_names)],
            refs = {}
          }
	elseif entity.name == "lihop-boiler" then
		entity.set_recipe("lihop-infinity-water-steam")
		entity.recipe_locked = true
	end
end)

script.on_event({
	defines.events.on_pre_player_mined_item,
	defines.events.on_robot_pre_mined,
	defines.events.on_entity_died,
	defines.events.script_raised_destroy,
}, function(e)
	local entity = e.entity
	if not entity or not entity.valid then
		return
	end
	if entity.name == "lihop-teleporteur" then
		global.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"][entity.unit_number] = nil
	end
end)


--------------------------------------------------------------------------------------------------------
--------------------------------------- Gestion des Gui ------------------------------------------------
--------------------------------------------------------------------------------------------------------

local function handle_gui_event(e)
	local msg = gui.read_action(e)
	if msg then
		if msg.gui == "lihop_teleporter" then
			lihop_teleporter.handle_gui_action(msg, e)
		end
		return true
	end
	return false
end

gui.hook_events(handle_gui_event)

script.on_event(defines.events.on_gui_opened, function(e)
	if not handle_gui_event(e) then
		local entity = e.entity
		local player = game.get_player(e.player_index)
		if not player then
			return
		end
		if entity and entity.valid then
			local name = entity.name
			if name == "lihop-teleporteur" then
				lihop_teleporter.create_gui(entity, player)
			end
		end
	end
end)

script.on_event(defines.events.on_gui_elem_changed, function(e)
	local player = game.get_player(e.player_index)
	if not player then return end
	if not player.opened then return end
	if player.opened.name == "lihop_tel_frame" then
		local refs = player.opened
		if not refs then return end
		local texticon_lihop_teleporter = refs.children[1].children[3]
		local ee = { player_index = e.player_index }
		local ent =util.split(texticon_lihop_teleporter.name,"/-")
		local tmp={ force = ent[1], surface = ent[2], number = tonumber(ent[3]) }
		local msg = { action = "choose", entity=tmp }
		lihop_teleporter.handle_gui_action(msg, ee)
	end
end)

--------------------------------------------------------------------------------------------------------
------------------------------------------ PLAYER ------------------------------------------------------
--------------------------------------------------------------------------------------------------------

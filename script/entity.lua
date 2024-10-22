local lihop_inf_miner = require("script.miner_pump")

local function on_entity_build(e)
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
		if not storage.lihop_buildings[entity.force.name] then storage.lihop_buildings[entity.force.name] = {} end
		if not storage.lihop_buildings[entity.force.name][entity.surface.name] then storage.lihop_buildings[entity.force.name][entity.surface.name] = {} end
        if not storage.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"] then storage.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"] = {} end
		storage.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"][entity.unit_number] = {
            ent = entity,
            name = game.backer_names[math.random(#game.backer_names)],
            refs = {}
          }
	elseif entity.name == "lihop-boiler" then
		entity.set_recipe("lihop-infinity-water-steam")
		entity.recipe_locked = true
	elseif entity.name=="lihop-infinity-pump" then
		lihop_inf_miner.definerecipefluidfromtile(entity)
	end
end

local function on_entity_disapear(e)
	local entity = e.entity
	if not entity or not entity.valid then
		return
	end
	if entity.name == "lihop-teleporteur" then
		storage.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"][entity.unit_number] = nil
	end
end

local entity ={}


entity.events={
	[defines.events.on_built_entity]=on_entity_build,
	[defines.events.on_robot_built_entity]=on_entity_build,
	[defines.events.on_pre_player_mined_item]=on_entity_disapear,
	[defines.events.on_robot_pre_mined]=on_entity_disapear,
	[defines.events.on_entity_died]=on_entity_disapear,
	[defines.events.script_raised_destroy]=on_entity_disapear,
}

return entity
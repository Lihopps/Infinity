local lihop_inf_miner={}

local function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end

local function getIndex(tab, val)
    local index = nil
    for i, v in ipairs (tab) do 
        if (v.id == val) then
          index = i 
        end
    end
    return index
end

---- Define recipe for solid miner
function lihop_inf_miner.definerecipesolid(ent,player)
	--game.players[1].print("ici")
	local pos=ent.position
	local dir=ent.direction
	local surf=ent.surface
	ent.destroy()
	local entity =surf.create_entity{name="lihop-infinity-miner",position=pos,force=player.force.name}
	entity.recipe_locked=true
    local a=surf.find_entities_filtered{area = entity.bounding_box , type = "resource"}
	local b={}
	for i =1,#a do
		if game.entity_prototypes["lihop-infinity-miner-fake"].resource_categories[game.entity_prototypes[a[i].name].resource_category] then
			b[#b+1]=a[i]
		end
	end
	if #b >0 then
		local i=math.random (#b)
		local name="lihop-".. b[i].name
		try(function()
			entity.set_recipe(name)
		end, function(e)
			surf.print(b[i].name .." not supported")
		end)
	end
	entity.direction=dir
end

---- Define recipe for fluid pump
function lihop_inf_miner.definerecipefluid(ent,player)
	local pos=ent.position
	local dir=ent.direction
	local surf=ent.surface
	ent.destroy()
	local entity =surf.create_entity{name="lihop-infinity-pump-jack",position=pos,force=player.force.name,direction=dir}
	entity.recipe_locked=true
    local a=surf.find_entities_filtered{area = entity.bounding_box , type = "resource"}
	local b={}
	for i =1,#a do
		if game.entity_prototypes["lihop-infinity-pump-jack-fake"].resource_categories[game.entity_prototypes[a[i].name].resource_category] then
			b[#b+1]=a[i]
		end
	end
	if #b >0 then
		local i=math.random (#b)
		local name="lihop-".. b[i].name
		try(function()
			entity.set_recipe(name)
		end, function(e)
			surf.print(b[i].name .." not supported")
		end)
	end
end

return lihop_inf_miner
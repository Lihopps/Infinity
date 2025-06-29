

local function on_surface_renamed(e)
	for forcename,datforce in pairs(storage.lihop_buildings) do
		storage.lihop_buildings[forcename][e.new_name]=storage.lihop_buildings[forcename][e.old_name]
		storage.lihop_buildings[forcename][e.old_name]=nil
	end
end

local function on_all_entities_deleted(e)
	for forcename,datforce in pairs(storage.lihop_buildings) do
		for surfname,datsurf in pairs(storage.lihop_buildings[forcename]) do
			if game.surfaces[surfname].index==e.surface_index then
				storage.lihop_buildings[forcename][surfname]=nil
			end
		end
	end
end


local surface={}


surface.events={
	[defines.events.on_surface_renamed]=on_surface_renamed,
	[defines.events.on_surface_cleared]=on_all_entities_deleted,
	[defines.events.on_surface_deleted]=on_all_entities_deleted,

}

return surface
local migrations = {}

-- storage.lihop_buildings.force.surface.teleporter ={}
-- storage.lihop_buildings.force.surface.access ={unit_}
-- storage.teleporteur[entity.backer_name]=entity

migrations.versions = {
  ["1.0.0"] = function()
    ----migration teleporter

    storage.teleporter = nil --nuke all reference
    for _, tforce in pairs(game.forces) do
      if not storage.lihop_buildings[tforce.name] then storage.lihop_buildings[tforce.name] = {} end
      for _, surface in pairs(game.surfaces) do
        local teleporters = surface.find_entities_filtered { name = "lihop-teleporteur",force=tforce}
        if not storage.lihop_buildings[tforce.name][surface.name] then storage.lihop_buildings[tforce.name][surface.name] = {} end
        if not storage.lihop_buildings[tforce.name][surface.name]["teleporter"] then storage.lihop_buildings[tforce.name][surface.name]["teleporter"] = {} end
        for _, teleporter in pairs(teleporters) do
          storage.lihop_buildings[tforce.name][surface.name]["teleporter"][teleporter.unit_number] = {
            ent = teleporter,
            name = game.backer_names[math.random(#game.backer_names)],
            refs = {}
          }
        end
      end
      if tforce.technologies["lihop-infinity-stone"] then
        local tech = tforce.technologies["lihop-infinity-stone"]
        tech.researched=false
        tech.researched=true
      end
    end
  end
}
return migrations

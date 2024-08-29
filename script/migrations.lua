local migrations = {}

-- global.lihop_buildings.force.surface.teleporter ={}
-- global.lihop_buildings.force.surface.access ={unit_}
-- global.teleporteur[entity.backer_name]=entity

migrations.versions = {
  ["1.0.0"] = function()
    ----migration teleporter

    global.teleporter = nil --nuke all reference
    for _, tforce in pairs(game.forces) do
      if not global.lihop_buildings[tforce.name] then global.lihop_buildings[tforce.name] = {} end
      for _, surface in pairs(game.surfaces) do
        local teleporters = surface.find_entities_filtered { name = "lihop-teleporteur",force=tforce}
        if not global.lihop_buildings[tforce.name][surface.name] then global.lihop_buildings[tforce.name][surface.name] = {} end
        if not global.lihop_buildings[tforce.name][surface.name]["teleporter"] then global.lihop_buildings[tforce.name][surface.name]["teleporter"] = {} end
        for _, teleporter in pairs(teleporters) do
          global.lihop_buildings[tforce.name][surface.name]["teleporter"][teleporter.unit_number] = {
            ent = teleporter,
            name = game.backer_names[math.random(#game.backer_names)],
            refs = {}
          }
        end
      end
    end
  end
}
return migrations

local migration = require("__flib__.migration")

local migrations = require("script.migrations")



local main={}

function main.on_init()
    if not storage.lihop_buildings then storage.lihop_buildings= {} end
end

function main.on_configuration_changed(e)
    if not storage.lihop_buildings then storage.lihop_buildings = {} end
	migration.on_config_changed(e, migrations.versions)
end

main.events={

}

return main
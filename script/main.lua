local migrations = require("script.migrations")



local main={}

function main.on_init()
    if not storage.lihop_buildings then storage.lihop_buildings= {} end
end

function main.on_configuration_changed(e)
    if not storage.lihop_buildings then storage.lihop_buildings = {} end
	
    for version, migration in pairs(migrations) do
        if helpers.compare_versions(version, old_version) > 0 then
            migration()
        end
    end

end

main.events={

}

return main
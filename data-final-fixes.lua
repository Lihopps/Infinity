local util=require("script.util")

local probability_divisor=5
-------------------------------------------------------------------------------------------------------------------------
------------------------------------------ FUNCTIONS -------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

function Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

local function recipe_result(resource, input_fluid, output_fluid)
    local res = {}
    local icon = nil
    local iconsize = nil
    local subgroup = nil
    local category = nil
    local order = nil
    local recipe = {
        type = "recipe",
        name = "lihop-" .. resource.name,
        enabled = true,
        energy_required = 2,
        ingredients = {},
        results = {},
        hidden=true,
        hidden_in_factoriopedia=true,
        hide_from_signal_gui=true
    }
    if (input_fluid) then
        recipe.ingredients = { { type = "fluid", name = resource.minable.required_fluid, amount = resource.minable.fluid_amount } }
    end
    if (resource.minable.results) then
        res = resource.minable.results
        recipe.localised_name = resource.name
        for k, v in pairs(res) do
            if (output_fluid) then
                res[k].amount = lihop.settings.fluidAmount
                category = "lihop-excavate-fluid"
                if data.raw.fluid[resource.name] then
                    subgroup = data.raw.fluid[resource.name].subgroup
                    icon = data.raw.fluid[resource.name].icon
                    iconsize = data.raw.fluid[resource.name].icon_size
                    order = data.raw.fluid[resource.name].order
                else
                    subgroup = data.raw.resource[resource.name].subgroup
                    icon = data.raw.resource[resource.name].icon
                    iconsize = data.raw.resource[resource.name].icon_size
                    order = data.raw.resource[resource.name].order
                end
            else
                res[k].amount = lihop.settings.oreAmount
                category = "lihop-excavate"
                if data.raw.item[resource.name] then
                    subgroup = data.raw.item[resource.name].subgroup
                    icon = data.raw.item[resource.name].icon
                    iconsize = data.raw.item[resource.name].icon_size
                    order = data.raw.item[resource.name].order
                    recipe.localised_name = resource.name
                else
                    subgroup = data.raw.resource[resource.name].subgroup
                    icon = data.raw.resource[resource.name].icon
                    iconsize = data.raw.resource[resource.name].icon_size
                    order = data.raw.resource[resource.name].order
                    recipe.localised_name = resource.name
                end
            end
        end
    elseif (resource.minable.result) then
        if (output_fluid) then
            res = { { type = "fluid", name = resource.minable.result, amount = lihop.settings.fluidAmount } }
            category = "lihop-excavate-fluid"
            if data.raw.fluid[resource.name] then
                subgroup = data.raw.fluid[resource.name].subgroup
                icon = data.raw.fluid[resource.name].icon
                iconsize = data.raw.fluid[resource.name].icon_size
                order = data.raw.fluid[resource.name].order
                recipe.localised_name = resource.name
            else
                subgroup = data.raw.resource[resource.name].subgroup
                icon = data.raw.resource[resource.name].icon
                iconsize = data.raw.resource[resource.name].icon_size
                order = data.raw.resource[resource.name].order
                recipe.localised_name = resource.name
            end
        else
            res = { { type = "item", name = resource.minable.result, amount = lihop.settings.oreAmount } }
            category = "lihop-excavate"
            if data.raw.item[resource.name] then
                subgroup = data.raw.item[resource.name].subgroup
                icon = data.raw.item[resource.name].icon
                iconsize = data.raw.item[resource.name].icon_size
                order = data.raw.item[resource.name].order
                recipe.localised_name = resource.name
            else
                subgroup = data.raw.resource[resource.name].subgroup
                icon = data.raw.resource[resource.name].icon
                iconsize = data.raw.resource[resource.name].icon_size
                order = data.raw.resource[resource.name].order
                recipe.localised_name = resource.name
            end
        end
    end


    recipe["results"] = res
    if icon then recipe["icon"] = icon end
    if iconsize then recipe["icon_size"] = iconsize end
    if category then recipe["category"] = category end
    if subgroup then recipe["subgroup"] = subgroup end
    if order then recipe["order"] = order end

    return recipe
end

function insertRecipe(name)
    table.insert(data.raw["technology"]["mining-productivity-3"].effects,changeRecipe(name))
end

function changeRecipe(name)
    return {
        type = "change-recipe-productivity",
        recipe = "lihop-" .. name,
        change = 0.1,
        hidden=true
      }

end

-------------------------------------------------------------------------------------------------------------------------
------------------------------------------ ORES AND MOST OF MODDED ORES -------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
local solid = Set(lihop.minertype)
local fluid = Set(lihop.pumptype)

for k, v in pairs(data.raw.resource) do
    if solid[data.raw.resource[k].category] or data.raw.resource[k].category == nil then
        if data.raw.resource[k].minable.required_fluid ~= nil then
            data:extend({recipe_result(data.raw.resource[k], true, false)})
            insertRecipe(data.raw.resource[k].name)
        else
            data:extend({recipe_result(data.raw.resource[k], false, false)})
            insertRecipe(data.raw.resource[k].name)
        end
    elseif fluid[data.raw.resource[k].category] then
        if data.raw.resource[k].minable.required_fluid ~= nil then
            data:extend({recipe_result(data.raw.resource[k], true, true)})
            insertRecipe(data.raw.resource[k].name)
        else
            data:extend({recipe_result(data.raw.resource[k], false, true)})
            insertRecipe(data.raw.resource[k].name)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------------
------------------------------------------ Fluids Recipe From tile -------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
for k, v in pairs(data.raw.tile) do
    if v.fluid then
    data:extend(
        {
            {
                type = "recipe",
                name = "lihop-infinity-pump-"..v.fluid,
                category = "lihop-excavate-fluid-tile",
                enabled = true,
                localised_name = v.fluid,
                energy_required = 0.5,
                ingredients = {},
                hidden=true,
                hide_from_signal_gui=true,
                hidden_in_factoriopedia=true,
                results = { { type = "fluid", name = v.fluid, amount = 500 } }
            },
        }
    )
    end
end

-------------------------------------------------------------------------------------------------------------------------
------------------------------------------ spawn chunk asteroids -------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
for k,v in pairs(data.raw["space-connection"]) do
    if (v.from=="nauvis" or v.to=="nauvis") or (v.from=="shattered_planet_trip" or v.to=="shattered_planet_trip") then
        local spawn_asteroids=v.asteroid_spawn_definitions
        for i,spawn_ast in pairs(spawn_asteroids) do
            local sp=nil
            if spawn_ast.type=="asteroid-chunk" then
                if util.split(spawn_ast.asteroid, "-")[1]=="metallic" then
                    sp=table.deepcopy(spawn_ast)
                    for _,v in pairs(sp.spawn_points) do
                        v.probability=v.probability/probability_divisor
                    end
                end
            else
                if util.split(spawn_ast.asteroid, "-")[2]=="metallic" then
                    sp=table.deepcopy(spawn_ast)
                    for _,v in pairs(sp.spawn_points) do
                        v.probability=v.probability/probability_divisor
                    end
                end
            end
            if sp then
                local name=sp.asteroid:gsub("metallic","infinity",1)
                sp.asteroid=name
                table.insert(v.asteroid_spawn_definitions,sp)
            end
        end
        --log(serpent.block(v.asteroid_spawn_definitions))
    end
end

function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local function recipe_result(resource,input_fluid,output_fluid)
	local res={}
	local icon=nil
	local iconsize=nil
	local subgroup=nil
	local category=nil
	local order=nil
	local recipe ={
		type="recipe",
		name="lihop-"..resource.name,
		normal={
			enabled = false,
			energy_required = 2,
			ingredients={},
			results={}
		}
	}
	if(input_fluid) then
		recipe.normal.ingredients ={{type="fluid", name=resource.minable.required_fluid, amount=resource.minable.fluid_amount}}
	end
	if(resource.minable.results) then
		res=resource.minable.results
		for k,v in pairs(res) do
			if(output_fluid) then
				res[k].amount = lihop.settings.fluidAmount
				category="lihop-excavate-fluid"
			else
				res[k].amount=lihop.settings.oreAmount
				category="lihop-excavate"				
				if data.raw.item[resource.name] then 
					subgroup=data.raw.item[resource.name].subgroup
					icon=data.raw.item[resource.name].icon
					iconsize=data.raw.item[resource.name].icon_size
					order=data.raw.item[resource.name].order
				else
					subgroup=data.raw.resource[resource.name].subgroup
					icon=data.raw.resource[resource.name].icon
					iconsize=data.raw.resource[resource.name].icon_size
					order=data.raw.resource[resource.name].order
				end
			end
		end
	elseif (resource.minable.result) then
		if(output_fluid) then
			res= {{type="fluid",name=resource.minable.result, amount=lihop.settings.fluidAmount}}
			category="lihop-excavate-fluid"
		else
			res= {{name=resource.minable.result, amount=lihop.settings.oreAmount}}
			category="lihop-excavate"
			if data.raw.item[resource.name] then 
				subgroup=data.raw.item[resource.name].subgroup
				icon=data.raw.item[resource.name].icon
				iconsize=data.raw.item[resource.name].icon_size
				order=data.raw.item[resource.name].order
			else
				subgroup=data.raw.resource[resource.name].subgroup
				icon=data.raw.resource[resource.name].icon
				iconsize=data.raw.resource[resource.name].icon_size
				order=data.raw.resource[resource.name].order
			end
		end
	end


	recipe.normal["results"]=res
	if icon then recipe["icon"]=icon end
	if iconsize then recipe["icon_size"]=iconsize end
	if category then recipe["category"]=category end
	if subgroup then recipe["subgroup"]=subgroup end
	if order then recipe["order"]=order end

	return recipe
end


-------------------------------------------------------------------------------------------------------------------------
------------------------------------------ ORES AND MOST OF MODDED ORES -------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
local solid = Set(lihop.minertype)
local fluid = Set(lihop.pumptype)

for k, v in pairs(data.raw.resource) do
	if solid[data.raw.resource[k].category] or data.raw.resource[k].category==nil then
		if data.raw.resource[k].minable.required_fluid ~= nil then
			data:extend({
			recipe_result(data.raw.resource[k],true,false)
			})
		else
			data:extend({
			recipe_result(data.raw.resource[k],false,false)
			})
		end
	elseif fluid[data.raw.resource[k].category] then
		if data.raw.resource[k].minable.required_fluid ~= nil then
			data:extend({
			recipe_result(data.raw.resource[k],true,true)
			})
		else
			data:extend({
			recipe_result(data.raw.resource[k],false,true)
			})
		end

	end
end


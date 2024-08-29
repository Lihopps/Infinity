local util = {}

local restriction ={}
restriction["lihop-ascenseur"]=1
restriction["lihop-infinity-receiver"]=1

---- check if tbl contains x
function util.table_contains(tbl, x)
  local found = false
  for _, v in pairs(tbl) do
    if v == x then
      found = true
    end
  end
  return found
end

---- sort table tbl[string → LuaEntityPrototype] by criter and return tbl[string → LuaEntityPrototype] (reduce if needed =>(name, criter))

function util.sort_table(tbl,criter, reduce)
local output_tbl={}
local temp={}
local index=1
for name,entityPrototype in pairs(tbl) do
  temp[index]={name=name,criter=entityPrototype[criter]}
  index=index+1
end
table.sort(temp,function(k1,k2) return k1.criter<k2.criter end)
if reduce then
  return temp
else
  for i=1,#temp do
    output_tbl[temp[i].name]=tbl[temp[i].name]
  end
  return output_tbl
end



end
---- create flying text
function util.entity_flying_text(entity, text, color, pos)
  local posi = nil
  if pos then posi = pos else posi = entity.position end
  entity.surface.create_entity({
    type = "flying-text",
    text_alignment="center",
    name = "flying-text",
    position = posi,
    text = {text},
    color = color,
  })
end

--separate string
function util.split (inputstr, sep)
   if sep == nil then
      sep = "%s"
   end
   local t={}
   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
   end
   return t
end

----------- Restriction for entities
function util.restrictionForce(constructeur,entity)
  if constructeur.force.get_entity_count(entity.name) > restriction[entity.name] then
    local item =entity.prototype.items_to_place_this[1]
    local inventory =constructeur.get_inventory(defines.inventory.robot_repair) or constructeur.get_inventory(defines.inventory.character_main)
    util.entity_flying_text(constructeur, "gui.limited_entity", { r = 255 / 255, g = 0, b = 0 }, entity.position)
    entity.destroy()
    if inventory.can_insert({name=item.name, count=1}) then
      inventory.insert({name=item.name, count=1})
    end
    return false
  end
  return true
end

return util

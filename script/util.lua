local util = {}

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


return util

if not lihop then lihop = {} end
if not lihop.settings then lihop.settings = {} end
if not lihop.minertype then lihop.minertype = {} end
if not lihop.pumptype then lihop.pumptype = {} end

lihop.settings.oreAmount = settings.startup["lihop-infinity-oreamount"].value
lihop.settings.fluidAmount = settings.startup["lihop-infinity-fluidamount"].value
lihop.settings.forcetel = settings.startup["lihop-infinity-force-tel"].value

lihop.minertype={"basic-solid"}
lihop.pumptype={"basic-fluid"}


-------------------------------------------------------------------------------------------------------------------------
--------------------------------Gestion Spécifique de la compatibilité avec d'autres mods -------------------------------
-------------------------------------------------------------------------------------------------------------------------
-- si présence du mod
if mods["Krastorio2"] then
	lihop.settings.Krastorioquarry = settings.startup["lihop-infinity-Krastorioquarry"].value
	table.insert(lihop.pumptype, "oil")
	if lihop.settings.Krastorioquarry then
		table.insert(lihop.minertype, "kr-quarry")
	end

end
if mods["bobores"] then
	table.insert(lihop.pumptype, "water")

end
if mods["space-exploration"] then
	table.insert(lihop.minertype,"hard-resource")
	se_delivery_cannon_recipes["lihop-raw-infinity-stone"] = {name="lihop-raw-infinity-stone"}
	

end

-- Si absence du mod
if not mods["Krastorio2"]  or lihop.settings.forcetel then --si pas Krastorio ou si le teleporter est forcé
	require("prototypes.entities.Teleporteur.infinity-teleporteur")
end

-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------- Chargement standars du mod -------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

require("prototypes.categories.recipe-category")
require("prototypes.items.item")
require("prototypes.items.recipe")
require("prototypes.entities.entities")
require("prototypes.projectiles")
require("prototypes.ammo")
require("prototypes.equipment")
require("prototypes.technologies")

require("prototypes.style")


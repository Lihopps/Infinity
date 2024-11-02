local gui = require("__flib__.gui")


-- TODO: revoir le available
---- Check if teleporter have enought energy
local function isAvailable(entity)
    local percent_full =
        math.ceil((entity.energy / entity.prototype.electric_energy_source_prototype.buffer_capacity) * 100)
    local fully_charged = percent_full == 100
    if (fully_charged) then
        return true
    else
        return false
    end
end

local function on_gui_rename_click(e)
    local entity = e.element.tags["entity"]
    if not entity then return end
    local refs = storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs
        [e.player_index]
    local textfield = refs.name_textfield
    local label = refs.name_label
    if textfield.visible then
        storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].name = textfield.text
        textfield.visible = false
        label.caption = textfield.text --storage.teleporteur[msg.number].name
        label.visible = true
    else
        textfield.text = storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].name or
            ""
        textfield.visible = true
        textfield.select_all()
        textfield.focus()
        label.visible = false
    end
end

local function on_gui_closed(e)
    local player = game.get_player(e.player_index)
    if not player then return end
    if player.opened and player.opened.prototype.type~="equipment-grid" then
        if player.opened.name == "lihop_tel_frame" then
            local refs = player.opened
            if not refs then return end
            refs.destroy()
            player.opened = nil
        end
    elseif not e.entity then
        if not e.element then return end
        local entity = e.element.tags["entity"]
        if not entity then return end
        if storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs[e.player_index] then
            storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs[e.player_index]
                .lihop_tel_frame.destroy()
            storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs[e.player_index] = nil
        end
    end
end

local function on_gui_closed_click(e)
    on_gui_closed(e)
end

local function on_teleportation_clicked(e)
    local player= game.get_player(e.player_index)
    if not player then return end
    
    local fe_tags=e.element.tags["fromentity"]
    if not fe_tags then return end
    local entity=e.element.tags["entity"]
    if not entity then return end
    local fromentity = storage.lihop_buildings[fe_tags.force][fe_tags.surface]["teleporter"][fe_tags.number].ent
    local ent = storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].ent
    on_gui_closed(e)
    if isAvailable(ent) then
        local area = fromentity.bounding_box
        local players_to_tel = fromentity.surface.find_entities_filtered { area = area, type = "character" }
        if #players_to_tel > 0 then
            for _, character in pairs(players_to_tel) do
                if character.player and character.player.valid then
                    character.player.teleport(ent.position, ent.surface)
                end
            end
        else
            player.create_local_flying_text { text = { "gui.no_player" }, position = fromentity.position, color = { r = 255 / 255, g = 0, b = 0 } }
        end
    else
        player.create_local_flying_text { text = { "gui.not_enought_power" }, position = fromentity.position, color = { r = 255 / 255, g = 0, b = 0 } }
    end
    fromentity.energy = 0
    ent.energy = 0
end


local function update_list_teleport(refs, entity, player, surface_name)
    local list_teleport = refs.table_teleporter
    local teleport = {}
    list_teleport.clear()
    refs.surface_name_label.caption = surface_name
    if not storage.lihop_buildings[player.force.name] then return end
    if not storage.lihop_buildings[player.force.name][surface_name] then return end
    if storage.lihop_buildings[player.force.name][surface_name]["teleporter"] then
        for number, data in pairs(storage.lihop_buildings[player.force.name][surface_name]["teleporter"]) do
            local teleporter = data.ent
            -- on test si c'est pas lui meme
            if entity.unit_number ~= teleporter.unit_number then
                -- on test si il est alimenté
                table.insert(teleport,
                    {
                        type = "frame",
                        style = "deep_frame_in_shallow_frame",
                        direction = "vertical",
                        style_mods = { horizontally_stretchable = true },
                        {
                            type = "minimap",
                            position = teleporter.position,
                            surface_index = teleporter.surface.index,
                            style_mods = { horizontally_stretchable = true },
                            zoom = 5
                        },
                        {
                            type = "button",
                            caption = data.name,
                            enabled = isAvailable(teleporter),
                            style_mods = { horizontally_stretchable = true },
                            tooltip = { "gui.lihop-rename-tooltip" },
                            handler = { [defines.events.on_gui_click] = on_teleportation_clicked },
                            tags={
                                fromentity = { force = entity.force.name or entity.force, surface = entity.surface.name or entity.surface, number = entity.unit_number },
                                entity = { force = teleporter.force.name, surface = teleporter.surface.name, unit_number = teleporter.unit_number }
                            },
                        }
                    })
            end
        end
    end
    gui.add(list_teleport, teleport)
end

local function on_surface_clicked(e)
    local entity = e.element.tags["entity"]
    local surface_dest = e.element.tags["surface_dest"]
    local player = game.get_player(e.player_index)
    if not entity then return end
    if not surface_dest then return end
    if not player then return end
    update_list_teleport(
        storage.lihop_buildings[entity.force][entity.surface]["teleporter"][entity.unit_number].refs[e.player_index],
        entity, player, surface_dest)
end

local function update_surface_name(refs, player, entity)
    if not storage.lihop_buildings[player.force.name] then return end
    local entity_tags = { force = entity.force.name, surface = entity.surface.name, unit_number = entity.unit_number }
    refs.frame_surface.clear()
    surfaces = {}
    for name, surf in pairs(storage.lihop_buildings[player.force.name]) do
        if surf["teleporter"] then
            table.insert(surfaces,
                {
                    type = "button",
                    name = "button_tel_" .. name,
                    caption = name,
                    style = "inf_list_box_item",
                    tags = { entity = entity_tags, surface_dest = name },
                    handler = { [defines.events.on_gui_click] = on_surface_clicked },
                })
        end
    end
    gui.add(refs.frame_surface, surfaces)
end

--- @param player LuaPlayer
local function create_gui(entity, player)
    local data = storage.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"][entity.unit_number]
    local entity_tags = { force = entity.force.name, surface = entity.surface.name, unit_number = entity.unit_number }
    local refs = gui.add(player.gui.screen, {
        {
            type = "frame",
            direction = "vertical",
            name = "lihop_tel_frame",
            tags = { entity = entity_tags },
            auto_center = false,
            style_mods = { minimal_width = 500},
            handler = { [defines.events.on_gui_closed] = on_gui_closed },
            children = {
                -- bar du haut
                {
                    type = "flow",
                    style_mods = { horizontally_squashable = true },
                    name = "titlebar",
                    children = {
                        {
                            type = "label",
                            style = "subheader_caption_label",
                            rich_text_setting = "enabled",
                            caption = data.name,
                            name = "name_label",

                        },
                        {
                            type = "textfield",
                            visible = false,
                            name = "name_textfield",
                            style_mods = {
                                maximal_width = 0,
                                top_margin = -3,
                                right_padding = 0,
                                horizontally_stretchable = true
                            },
                            rich_text_setting = "enabled",
                            icon_selector = true,
                        },
                        {
                            type = "sprite-button",
                            style = "frame_action_button",
                            sprite = "utility/rename_icon",
                            tooltip = { "gui.lihop-rename-tooltip" },
                            tags = { entity = entity_tags },
                            handler = { [defines.events.on_gui_click] = on_gui_rename_click },
                        },
                        {
                            type = "empty-widget",
                            style = "draggable_space_header",
                            style_mods = { height = 24, horizontally_stretchable = true, right_margin = 4 },
                            ignored_by_interaction = true,
                        },
                        {
                            type = "sprite-button",
                            style = "frame_action_button",
                            sprite = "utility/close",
                            name = "button_close",
                            ref = { "button_close" },
                            hovered_sprite = "utility/close",
                            clicked_sprite = "utility/close",
                            tooltip = { "gui.close-instruction" },
                            handler = { [defines.events.on_gui_click] = on_gui_closed_click },
                        },
                    },
                },
                -- frame principale
                {
                    type = "frame",
                    style = "inside_shallow_frame",
                    style_mods = { vertically_stretchable = true,horizontally_squashable = true },
                    direction = "vertical",
                    children =
                    {
                        {
                            type = "frame",
                            style = "deep_frame_in_shallow_frame",
                            children = {
                                { 
                                    type = "entity-preview", 
                                    style = "wide_entity_button", 
                                    elem_mods = { entity = entity },
                                    style_mods = { vertically_stretchable = true,horizontally_squashable = true },
                                },
                            },
                        },
                        {
                            type = "frame",
                            name = "fprinc",
                            direction = "horizontal",
                            style_mods = { vertically_stretchable = true, horizontally_squashable = true },
                            {
                                type = "frame",
                                style_mods = { vertically_stretchable = true,  },
                                visible = player.force.technologies["lihop-infinity-teleportation"].researched,
                                {
                                    type = "frame",
                                    style_mods = { vertically_stretchable = true },
                                    style = "deep_frame_in_shallow_frame",
                                    {
                                        type = "scroll-pane",
                                        style = "inf_list_box_scroll_pane",
                                        style_mods = { vertically_stretchable = true, },
                                        name = "frame_surface",
                                    }
                                },
                            },
                            {
                                type = "frame",
                                name = "frame_minimap",
                                style_mods = { horizontally_squashable = true },
                                direction = "vertical",
                                {
                                    type = "label",
                                    caption = player.surface.name,
                                    name = "surface_name_label"
                                },
                                {
                                    type = "scroll-pane",
                                    horizontal_scroll_policy = "never",
                                    --style_mods = { horizontally_stretchable = true },
                                    {
                                        type = "table",
                                        style = "inset_frame_container_table",
                                        --style_mods = { horizontally_stretchable = true },
                                        name = "table_teleporter",
                                        column_count = 3
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    })

    refs.titlebar.drag_target = refs.lihop_tel_frame
    refs.lihop_tel_frame.force_auto_center()
    update_surface_name(refs, player, entity)
    update_list_teleport(refs, entity, player, player.surface.name)
    --refs.texticon_lihop_teleporter.elem_value = { type = "item", name = "lihop-false-item" }
    player.opened = refs.lihop_tel_frame
    storage.lihop_buildings[entity.force.name][entity.surface.name]["teleporter"][entity.unit_number].refs[player.index] =
        refs
end

local function on_gui_opened(e)
    local player = game.players[e.player_index]
    if not player then return end
    if e.entity then
        if e.entity.name == "lihop-teleporteur" then
            --si deja ouvert request de fermeture
            create_gui(e.entity, player)
        end
    end
end

local machgui = {}
function machgui.update_gui()
end

machgui.events = {
    [defines.events.on_gui_opened] = on_gui_opened,
    [defines.events.on_gui_closed] = on_gui_closed
}

gui.add_handlers({
    on_gui_closed_click = on_gui_closed_click,
    on_gui_rename_click = on_gui_rename_click,
    on_surface_clicked = on_surface_clicked,
    on_teleportation_clicked = on_teleportation_clicked
})

return machgui

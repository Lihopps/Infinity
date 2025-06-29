local sounds = require("__base__/prototypes/entity/sounds")
local hit_effects = require ("__base__/prototypes/entity/hit-effects")
local explosion_animations = require("__base__/prototypes/entity/explosion-animations")

data:extend(
{
	{
    type = "ammo",
    name = "lihop-infinity-rounds-magazine",
    icon = "__Infinity__/graphics/items/infinity-rounds-magazine.png",
    icon_size = 64, icon_mipmaps = 4,
    ammo_category="bullet",
    ammo_type =
    {
      category = "bullet",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-hit",
              offsets = {{0, 1}},
              offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}}
            },
            {
              type = "damage",
              damage = { amount = 36, type = "physical"}
            }
          }
        }
      }
    },
    magazine_size = 10,
    subgroup="ammo",
    order="a[basic-clips]-d[infinity-round-magazine]",
    stack_size = 200
  },
  
	{
    type = "ammo",
    name = "lihop-infinity-bomb",
    icon = "__Infinity__/graphics/items/infinity-bomb.png",
    icon_size = 64, icon_mipmaps = 4,
    ammo_category="bullet",
    ammo_type =
    {
      range_modifier = 5,
      cooldown_modifier = 5,
      target_type = "position",
      category = "rocket",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "lihop-infinity-rocket",
          starting_speed = 0.05,
          source_effects =
          {
            type = "create-entity",
            entity_name = "explosion-hit"
          }
        }
      }
    },
    subgroup="ammo",
    order="d[rocket-launcher]-d[infinity-bomb]",
    stack_size = 10
  },
	{
    type = "ammo",
    name = "lihop-infinity-cannon-shell",
    icon = "__Infinity__/graphics/items/infinity-cannon-shell.png",
    icon_size = 64, icon_mipmaps = 4,
    ammo_category="bullet",
    ammo_type =
    {
      category = "cannon-shell",
      target_type = "direction",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "lihop-infinity-cannon-shell",
          starting_speed = 1.3,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 50,
          min_range = 5,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          }
        }
      }
    },
    subgroup="ammo",
    order="d[explosive-canon-shell]-ca[cannon-shell]",
    stack_size = 200
  },
  {
    type = "ammo",
    name = "lihop-explosive-infinity-cannon-shell",
    icon = "__Infinity__/graphics/items/explosive-infinity-cannon-shell.png",
    icon_size = 64, icon_mipmaps = 4,
    ammo_category="bullet",
    ammo_type =
    {
      category = "cannon-shell",
      target_type = "direction",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "projectile",
          projectile = "lihop-explosive-infinity-cannon-shell",
          starting_speed = 1,
          direction_deviation = 0.1,
          range_deviation = 0.1,
          max_range = 30,
          min_range = 5,
          source_effects =
          {
            type = "create-explosion",
            entity_name = "explosion-gunshot"
          }
        }
      }
    },
    subgroup="ammo",
    order="d[explosive-canon-shell]-ca[-explosive-cannon-shell]",
    stack_size = 200
  }
 })
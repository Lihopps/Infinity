data:extend({
{
    type = "damage-type",
    name = "lihop-explosion"
  },
{
    type = "projectile",
    name = "lihop-infinity-rocket",
    flags = {"not-on-map"},
    acceleration = 0.05,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
              repeat_count = 100,
              type = "create-trivial-smoke",
              smoke_name = "nuclear-smoke",
              offset_deviation = {{-1, -1}, {1, 1}},
              starting_frame = 3,
              starting_frame_deviation = 5,
              starting_frame_speed = 0,
              starting_frame_speed_deviation = 5,
              speed_from_center = 0.5
          },
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "damage",
            damage = {amount = 600, type = "explosion"}
          },
          {
            type = "create-entity",
            entity_name = "big-scorchmark",
            check_buildability = true
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1,
          },
          {
            type = "destroy-decoratives",
            from_render_layer = "decorative",
            to_render_layer = "object",
            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
            include_decals = false,
            invoke_decorative_trigger = true,
            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
            radius = 8 -- large radius for demostrative purposes
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              target_entities = false,
              trigger_from_target = true,
              repeat_count = 2500,
              radius = 50,
              action_delivery =
              {
                type = "projectile",
                projectile = "atomic-bomb-wave",
                starting_speed = 0.5
              }
            }
          }
        }
      }
    },
    light = {intensity = 0.8, size = 15},
    animation =
    {
      filename = "__base__/graphics/entity/rocket/rocket.png",
      frame_count = 8,
      line_length = 8,
      width = 9,
      height = 35,
      shift = {0, 0},
      priority = "high"
    },
    shadow =
    {
      filename = "__base__/graphics/entity/rocket/rocket-shadow.png",
      frame_count = 1,
      width = 7,
      height = 24,
      priority = "high",
      shift = {0, 0}
    },
    smoke =
    {
      {
        name = "smoke-fast",
        deviation = {0.15, 0.15},
        frequency = 1,
        position = {0, 1},
        slow_down_factor = 1,
        starting_frame = 3,
        starting_frame_deviation = 5,
        starting_frame_speed = 0,
        starting_frame_speed_deviation = 5
      }
    }
  },
  {
    type = "projectile",
    name = "lihop-infinity-cannon-shell",
    flags = {"not-on-map"},
    collision_box = {{-0.3, -1.1}, {0.3, 1.1}},
    acceleration = 0,
    direction_only = true,
    piercing_damage = 800,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "damage",
            damage = {amount = 600 , type = "physical"}
          },
          {
            type = "damage",
            damage = {amount = 300 , type = "explosion"}
          },
          {
            type = "create-entity",
            entity_name = "uranium-cannon-explosion"
          }
        }
      }
    },
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          }
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  },
  {
    type = "projectile",
    name = "lihop-explosive-infinity-cannon-shell",
    flags = {"not-on-map"},
    collision_box = {{-0.3, -1.1}, {0.3, 1.1}},
    acceleration = 0,
    piercing_damage = 250,
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "damage",
            damage = {amount = 500 , type = "physical"}
          },
          {
            type = "create-entity",
            entity_name = "uranium-cannon-explosion"
          }
        }
      }
    },
    final_action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
            type = "create-entity",
            entity_name = "uranium-cannon-shell-explosion"
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              radius = 5,
              action_delivery =
              {
                type = "instant",
                target_effects =
                {
                  {
                    type = "damage",
                    damage = {amount = 500, type = "explosion"}
                  },
                  {
                    type = "create-entity",
                    entity_name = "uranium-cannon-explosion"
                  }
                }
              }
            }
          },
          {
            type = "create-entity",
            entity_name = "medium-scorchmark",
            check_buildability = true
          },
          {
            type = "invoke-tile-trigger",
            repeat_count = 1,
          },
          {
            type = "destroy-decoratives",
            from_render_layer = "decorative",
            to_render_layer = "object",
            include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
            include_decals = false,
            invoke_decorative_trigger = true,
            decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
            radius = 3.25 -- large radius for demostrative purposes
          }
        }
      }
    },
    animation =
    {
      filename = "__base__/graphics/entity/bullet/bullet.png",
      frame_count = 1,
      width = 3,
      height = 50,
      priority = "high"
    }
  }
})
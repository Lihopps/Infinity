local smoke_animations = require("__base__/prototypes/entity/smoke-animations")
local trivial_smoke = smoke_animations.trivial_smoke

data:extend(
{
  {
    type = "recipe-category",
    name = "lihop-excavate"
  },
  {
    type = "recipe-category",
    name = "lihop-excavate-fluid"
  },
  {
    type = "recipe-category",
    name = "lihop-boiler"
  },
  {
    type = "recipe-category",
    name = "lihop-concentrating"
  },
  {
    type = "fuel-category",
    name = "lihop-solid-fuel"
  }
 }
 )

data:extend({trivial_smoke{name = "lihop-generator-smoke",color = {r = 1, g = 0, b = 0, a = 0.7}}})
data:extend({
{
    type = "generator-equipment",
    name = "lihop-fusion-reactor-equipment",
    take_result="lihop-fusion-reactor-equipment",
    sprite =
    {
      filename = "__Infinity__/graphics/equipments/fusion-reactor-eq.png",
      width = 32,
      height = 32,
      priority = "medium"
    },
    shape =
    {
      width = 2,
      height = 2,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "primary-output"
    },
    power = "1000kW",
    categories = {"armor"}
  }
})
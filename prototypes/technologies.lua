if mods["space-exploration"] then
	--plus tard
	data:extend({
		{
		type = "technology",
		name = "lihop-infinity-stone",
		icon_size = 256, icon_mipmaps = 4,
		icon = "__Infinity__/graphics/technologies/infinity-science.png",
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "lihop-concentrator"
			},
			{
				type = "unlock-recipe",
				recipe = "lihop-raw-infinity-stone"
			},
			{
				type = "unlock-recipe",
				recipe = "lihop-infinity-stone"
			},
		},
		prerequisites = {"se-energy-science-pack-1","se-biological-science-pack-1","se-material-science-pack-1","se-astronomic-science-pack-1"},
		unit =
		{
			  count = 1000,
			  ingredients =
			  {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1},
				{"se-astronomic-science-pack-1", 1},
				{"se-material-science-pack-1", 1},
				{"se-biological-science-pack-1", 1},
				{"se-energy-science-pack-1", 1},

			  },
			  time = 30
		},
		order = "a-b-b"
		},
		{
			type = "technology",
			name= "lihop-infinity-miner",
			icon_size = 256, icon_mipmaps = 4,
			icons= 
			{
				{
					icon="__Infinity__/graphics/technologies/mining.png"
				}
			},
			effects =
			{
				{
					type = "unlock-recipe",
					recipe = "lihop-infinity-miner"
				}
			},
			unit =
			{
				count = 1500,
				ingredients =
			  {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1},
				{"se-astronomic-science-pack-1", 1},
				{"se-material-science-pack-1", 1},
				{"se-biological-science-pack-1", 1},
				{"se-energy-science-pack-1", 1},

			  },
			  time = 30
			},
			prerequisites = {"lihop-infinity-stone"}
		},
		{
			type = "technology",
			name= "lihop-infinity-pump-jack",
			icon_size = 256, icon_mipmaps = 4,
			icons= 
			{
				{
					icon="__Infinity__/graphics/technologies/pump.png"
				}
			},
			effects =
			{
				{
				type = "unlock-recipe",
				recipe = "lihop-infinity-pump-jack"
				},
				{
				type = "unlock-recipe",
				recipe = "lihop-infinity-pump"
				}
			},
			unit =
			{
				count = 1500,
				ingredients =
			  {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1},
				{"se-astronomic-science-pack-1", 1},
				{"se-material-science-pack-1", 1},
				{"se-biological-science-pack-1", 1},
				{"se-energy-science-pack-1", 1},

			  },
			  time = 30
			},
			prerequisites = {"lihop-infinity-stone"}
		},
		{
			type = "technology",
			name= "lihop-infinity-energy2",
			icon_size = 256, icon_mipmaps = 4,
			icons= 
			{
				{
					icon="__Infinity__/graphics/technologies/energy2.png"
				}
			},
			effects =
			{
				{
				type = "unlock-recipe",
				recipe = "lihop-infinity-fuel-cell"
				},
				{
				type = "unlock-recipe",
				recipe = "lihop-infinity-generator"
				}
			},
			unit =
			{
				count = 5000,
				ingredients =
			  {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1},
				{"se-astronomic-science-pack-4", 1},
				{"se-material-science-pack-4", 1}

			  },
			  time = 30
			},
			prerequisites = {"lihop-infinity-stone","se-antimatter-reactor"}
		},
		{
			type = "technology",
			name= "lihop-infinity-energy",
			icon_size = 256, icon_mipmaps = 4,
			icons= 
			{
				{
					icon="__Infinity__/graphics/technologies/energy.png"
				}
			},
			effects =
			{
				{
				type = "unlock-recipe",
				recipe = "lihop-infinity-fuel"
				},
				{
				type = "unlock-recipe",
				recipe = "lihop-fusion-reactor-equipment"
				},
				{
				type = "unlock-recipe",
				recipe = "lihop-infinity-solar-panel"
				},
			},
			unit =
			{
				count = 5000,
				ingredients =
			  {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1},
				{"se-astronomic-science-pack-4", 1},
				{"se-material-science-pack-4", 1}

			  },
			  time = 30
			},
			prerequisites = {"lihop-infinity-stone","se-space-solar-panel-3","fusion-reactor-equipment","kovarex-enrichment-process"}
		},
		{
			type = "technology",
			name= "lihop-infinity-weapon",
			icon_size = 256, icon_mipmaps = 4,
			icons= 
			{
				{
					icon="__Infinity__/graphics/technologies/weapon.png"
				}
			},
			effects =
			{
				{
				type = "unlock-recipe",
				recipe = "lihop-infinity-rounds-magazine"
				},
				{
				type = "unlock-recipe",
				recipe = "lihop-infinity-bomb"
				},
				{
				type = "unlock-recipe",
				recipe = "lihop-infinity-cannon-shell"
				},
				{
				type = "unlock-recipe",
				recipe = "lihop-explosive-infinity-cannon-shell"
				}
			},
			unit =
			{
				count = 2000,
				ingredients =
				{
					{"automation-science-pack", 1},
					{"logistic-science-pack", 1},
					{"chemical-science-pack", 1},
					{"production-science-pack", 1},
					{"utility-science-pack", 1},
					{"military-science-pack",1},
					{"space-science-pack", 1}
				},
				time = 30
			},
			prerequisites = {"lihop-infinity-stone","uranium-ammo"}
		}
	
	})
else
	data:extend({
	{
    type = "technology",
    name = "lihop-infinity-stone",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__Infinity__/graphics/technologies/infinity-science.png",
    effects =
    {
		{
			type = "unlock-recipe",
			recipe = "lihop-concentrator"
		},
		{
			type = "unlock-recipe",
			recipe = "lihop-satellite-miner"
		},
		{
			type = "unlock-recipe",
			recipe = "lihop-infinity-stone"
		},
	},
    prerequisites = {"space-science-pack"},
    unit =
    {
		  count = 1000,
		  ingredients =
		  {
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
			{"production-science-pack", 1},
			{"utility-science-pack", 1},
			{"space-science-pack", 1}
		  },
		  time = 30
	},
    order = "a-b-b"
	},
	{
		type = "technology",
		name= "lihop-infinity-miner",
		icon_size = 256, icon_mipmaps = 4,
		icons= 
		{
			{
				icon="__Infinity__/graphics/technologies/mining.png"
			}
		},
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "lihop-infinity-miner"
			}
		},
		unit =
		{
			count = 1500,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}
			},
			time = 30
		},
		prerequisites = {"lihop-infinity-stone"}
	},
	{
		type = "technology",
		name= "lihop-infinity-pump-jack",
		icon_size = 256, icon_mipmaps = 4,
		icons= 
		{
			{
				icon="__Infinity__/graphics/technologies/pump.png"
			}
		},
		effects =
		{
			{
			type = "unlock-recipe",
			recipe = "lihop-infinity-pump-jack"
			},
			{
			type = "unlock-recipe",
			recipe = "lihop-infinity-pump"
			}
		},
		unit =
		{
			count = 1500,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}
			},
			time = 30
		},
		prerequisites = {"lihop-infinity-stone"}
	},
	{
		type = "technology",
		name= "lihop-infinity-energy2",
		icon_size = 256, icon_mipmaps = 4,
		icons= 
		{
			{
				icon="__Infinity__/graphics/technologies/energy2.png"
			}
		},
		effects =
		{
			{
			type = "unlock-recipe",
			recipe = "lihop-infinity-fuel-cell"
			},
			{
			type = "unlock-recipe",
			recipe = "lihop-infinity-generator"
			}
		},
		unit =
		{
			count = 2000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}
			},
			time = 30
		},
		prerequisites = {"lihop-infinity-stone"}
	},
	{
		type = "technology",
		name= "lihop-infinity-energy",
		icon_size = 256, icon_mipmaps = 4,
		icons= 
		{
			{
				icon="__Infinity__/graphics/technologies/energy.png"
			}
		},
		effects =
		{
			{
			type = "unlock-recipe",
			recipe = "lihop-infinity-fuel"
			},
			{
			type = "unlock-recipe",
			recipe = "lihop-fusion-reactor-equipment"
			},
			{
			type = "unlock-recipe",
			recipe = "lihop-infinity-solar-panel"
			},
			{
			type = "unlock-recipe",
			recipe = "lihop-boiler"
			}
		},
		unit =
		{
			count = 1500,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1}
			},
			time = 30
		},
		prerequisites = {"lihop-infinity-stone"}
	},
	{
		type = "technology",
		name= "lihop-infinity-weapon",
		icon_size = 256, icon_mipmaps = 4,
		icons= 
		{
			{
				icon="__Infinity__/graphics/technologies/weapon.png"
			}
		},
		effects =
		{
			{
			type = "unlock-recipe",
			recipe = "lihop-infinity-rounds-magazine"
			},
			{
			type = "unlock-recipe",
			recipe = "lihop-infinity-bomb"
			},
			{
			type = "unlock-recipe",
			recipe = "lihop-infinity-cannon-shell"
			},
			{
			type = "unlock-recipe",
			recipe = "lihop-explosive-infinity-cannon-shell"
			}
		},
		unit =
		{
			count = 2000,
			ingredients =
			{
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"production-science-pack", 1},
				{"utility-science-pack", 1},
				{"military-science-pack",1},
				{"space-science-pack", 1}
			},
			time = 30
		},
		prerequisites = {"lihop-infinity-stone"}
	}

})
end
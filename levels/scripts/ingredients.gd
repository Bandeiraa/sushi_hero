extends Node
class_name Ingredients

var ingredients_dict: Dictionary = {
	"avocado": {
		"item_texture": "res://foods_ingredients/assets/avocado.png",
		"item_name": "avocado",
		"price": 3
	},
	
	"crab_sticks": {
		"item_texture": "res://foods_ingredients/assets/crab_sticks.png",
		"item_name": "crab_sticks",
		"price": 12
	},
	
	"cucumber": {
		"item_texture": "res://foods_ingredients/assets/cucumber.png",
		"item_name": "cucumber",
		"price": 3,
		
		"prepared_ingredient": {
			"sliced_cucumber": {
				"item_texture": "res://foods_ingredients/assets/sliced_cucumber.png",
				"item_name": "sliced_cucumber"
			}
		}
	},
	
	"ebi": {
		"item_texture": "res://foods_ingredients/assets/ebi.png",
		"item_name": "ebi",
		"price": 7
	},
	
	"eel": {
		"item_texture": "res://foods_ingredients/assets/eel.png",
		"item_name": "eel",
		"price": 12,
		
		"prepared_ingredient": {
			"fish_fillet": {
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png",
				"item_name": "fish_fillet"
			}
		}
	},
	
	"fish": {
		"item_texture": "res://foods_ingredients/assets/fish.png",
		"item_name": "fish",
		"price": 10,
		
		"prepared_ingredient": {
			"fish_fillet": {
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png",
				"item_name": "fish_fillet"
			}
		}
	},
	
	"flounder": {
		"item_texture": "res://foods_ingredients/assets/flounder.png",
		"item_name": "flounder",
		"price": 11,
		
		"prepared_ingredient": {
			"fish_fillet": {
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png",
				"item_name": "fish_fillet"
			}
		}
	},
	
	"mackerel": {
		"item_texture": "res://foods_ingredients/assets/mackerel.png",
		"item_name": "mackerel",
		"price": 11,
		
		"prepared_ingredient": {
			"fish_fillet": {
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png",
				"item_name": "fish_fillet"
			}
		}
	},
	
	"nori": {
		"item_texture": "res://foods_ingredients/assets/nori.png",
		"item_name": "nori",
		"price": 3
	},
	
	"octopus": {
		"item_texture": "res://foods_ingredients/assets/octopus.png",
		"item_name": "octopus",
		"price": 35,
		
		"prepared_ingredient": {
			"tentacle": {
				"item_texture": "res://foods_ingredients/assets/tentacle.png",
				"item_name": "tentacle"
			}
		}
	},
	
	"rice": {
		"item_texture": "res://foods_ingredients/assets/rice.png",
		"item_name": "rice",
		"price": 5
	},
	
	"salmon_fish": {
		"item_texture": "res://foods_ingredients/assets/salmon_fish.png",
		"item_name": "salmon_fish",
		"price": 20,
		
		"prepared_ingredient": {
			"salmon": {
				"item_texture": "res://foods_ingredients/assets/salmon.png",
				"item_name": "salmon"
			}
		}
	},
	
	"sea_urchin": {
		"item_texture": "res://foods_ingredients/assets/sea_urchin.png",
		"item_name": "sea_urchin",
		"price": 1.5,
		
		"prepared_ingredient": {
			"sea_urchin_open": {
				"item_texture": "res://foods_ingredients/assets/sea_urchin_open.png",
				"item_name": "sea_urchin_open"
			}
		}
	},
	
	"shimesaba": {
		"item_texture": "res://foods_ingredients/assets/shimesaba.png",
		"item_name": "shimesaba",
		"price": 12,
		
		"prepared_ingredient": {
			"fish_fillet": {
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png",
				"item_name": "fish_fillet"
			}
		}
	},
	
	"squid": {
		"item_texture": "res://foods_ingredients/assets/squid.png",
		"item_name": "squid",
		"price": 30,
		
		"prepared_ingredient": {
			"tentacle": {
				"item_texture": "res://foods_ingredients/assets/tentacle.png",
				"item_name": "tentacle"
			}
		}
	},
	
	"tuna": {
		"item_texture": "res://foods_ingredients/assets/tuna.png",
		"item_name": "tuna",
		"price": 16,
		
		"prepared_ingredient": {
			"fish_fillet": {
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png",
				"item_name": "fish_fillet"
			}
		}
	},
	
	"fish_fillet": {
		"item_texture": "res://foods_ingredients/assets/fish_fillet.png",
		"item_name": "fish_fillet",
		"price": 15
	},
	
	"sliced_cucumber": {
		"item_texture": "res://foods_ingredients/assets/sliced_cucumber.png",
		"item_name": "sliced_cucumber",
		"price": 3
	},
	
	"tentacle": {
		"item_texture": "res://foods_ingredients/assets/tentacle.png",
		"item_name": "tentacle",
		"price": 30
	},
	
	"salmon": {
		"item_texture": "res://foods_ingredients/assets/salmon.png",
		"item_name": "salmon",
		"price": 20
	},
	
	"sea_urchin_open": {
		"item_texture": "res://foods_ingredients/assets/sea_urchin_open.png",
		"item_name": "sea_urchin_open",
		"price": 1.5
	}
}

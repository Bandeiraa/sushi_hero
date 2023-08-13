extends Node
class_name Recipes

#fish         -> $10
#rice         -> $5
#avocado      -> $3
#ebi          -> $7
#shimesaba    -> $12
#flounder     -> $11
#octopus      -> $35
#cucumber     -> $3
#nori         -> $3
#salmon       -> $20
#mackerel     -> $11
#sea urchin   -> $1.50
#tuna         -> $16
#eel          -> $12
#crab sticks  -> $12

var character_ref = null

var recipes_dict: Dictionary = {
	"chukaman": {
		"item_texture": "res://foods/assets/chukaman.png",
		"ingredients": {
			"fish_fillet": {
				"amount": 3,
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png"
			}
		},
		
		"price": 33.0 #+10% ingredients price
	},
	
	"dango": {
		"item_texture": "res://foods/assets/dango.png",
		"ingredients": {
			"rice": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/rice.png"
			},
			
			"fish_fillet": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png"
			},
			
			"avocado": {
				"amount": 2,
				"item_texture": "res://foods_ingredients/assets/avocado.png"
			}
		},
		
		"price": 23.10
	},
	
	"ebi_nigiri": {
		"item_texture": "res://foods/assets/ebi_nigiri.png",
		"ingredients": {
			"rice": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/rice.png"
			},
			
			"ebi": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/ebi.png"
			}
		},
		
		"price": 13.20
	},
	
	"gyoza": {
		"item_texture": "res://foods/assets/gyoza.png",
		"ingredients": {
			"fish_fillet": {
				"amount": 2,
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png"
			}
		},
		
		"price": 26.40
	},
	
	"maguro_nigiri": {
		"item_texture": "res://foods/assets/maguro_nigiri.png",
		"ingredients": {
			"rice": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/rice.png"
			},
			
			"fish_fillet": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png"
			}
		},
		
		"price": 17.60
	},
	
	"octopus_nigiri": {
		"item_texture": "res://foods/assets/octopus_nigiri.png",
		"ingredients": {
			"rice": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/rice.png"
			},
			
			"tentacle": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/tentacle.png"
			}
		},
		
		"price": 44.0
	},
	
	"onigiri": {
		"item_texture": "res://foods/assets/onigiri.png",
		"ingredients": {
			"rice": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/rice.png"
			}
		},
		
		"price": 5.5
	},
	
	"ramen": {
		"item_texture": "res://foods/assets/ramen.png",
		"ingredients": {
			"ebi": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/ebi.png"
			},
			
			"cucumber": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/cucumber.png"
			},
			
			"nori": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/nori.png"
			}
		},
		
		"price": 22.0
	},
	
	"roll": {
		"item_texture": "res://foods/assets/roll.png",
		"ingredients": {
			"fish_fillet": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png"
			},
			
			"nori": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/nori.png"
			},
			
			"rice": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/rice.png"
			}
		},
		
		"price": 20.90
	},
	
	"salmon_nigiri": {
		"item_texture": "res://foods/assets/salmon_nigiri.png",
		"ingredients": {
			"rice": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/rice.png"
			},
			
			"salmon": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/salmon.png"
			}
		},
		
		"price": 27.50
	},
	
	"salmon_roll": {
		"item_texture": "res://foods/assets/salmon_roll.png",
		"ingredients": {
			"salmon": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/salmon.png"
			},
			
			"nori": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/nori.png"
			},
			
			"rice": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/rice.png"
			}
		},
		
		"price": 30.80
	},
	
	"sea_urchin_roll": {
		"item_texture": "res://foods/assets/sea_urchin_roll.png",
		"ingredients": {
			"sea_urchin_open": {
				"amount": 10,
				"item_texture": "res://foods_ingredients/assets/sea_urchin_open.png"
			},
			
			"nori": {
				"amount": 2,
				"item_texture": "res://foods_ingredients/assets/nori.png"
			}
		},
		
		"price": 23.10
	},
	
	"tamago_nigiri": {
		"item_texture": "res://foods/assets/tamago_nigiri.png",
		"ingredients": {
			"rice": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/rice.png"
			},
			
			"fish_fillet": {
				"amount": 2,
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png"
			}
		},
		
		"price": 23.10
	},
	
	"udon": {
		"item_texture": "res://foods/assets/udon.png",
		"ingredients": {
			"cucumber": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/cucumber.png"
			},
			
			"eel": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/eel.png"
			},
			
			"fish_fillet": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/fish_fillet.png"
			}
		},
		
		"price": 29.70
	},
	
	"wasabi": {
		"item_texture": "res://foods/assets/wasabi.png",
		"ingredients": {
			"avocado": {
				"amount": 1,
				"item_texture": "res://foods_ingredients/assets/avocado.png"
			}
		},
		
		"price": 3.30
	}
}

func order_random_food(_client: Client) -> void:
	var _recipes: Array = recipes_dict.keys()
	var _random_id: int = randi() % recipes_dict.size()
	
	var _recipe_data: Dictionary = {
		"name": _recipes[_random_id],
		"price": recipes_dict[_recipes[_random_id]]["price"],
		"item_texture": recipes_dict[_recipes[_random_id]]["item_texture"]
	}
	
	_client.configure_client_feedback(
		_recipe_data
	)

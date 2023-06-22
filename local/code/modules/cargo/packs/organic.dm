/datum/supply_pack/organic/fiestatortilla
	name = "Fiesta Crate"
	desc = "Spice up the kitchen with this fiesta themed food order! Contains 8 tortilla based food items and some hot-sauce."
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(
		/obj/item/food/taco,
		/obj/item/food/taco,
		/obj/item/food/taco/plain,
		/obj/item/food/taco/plain,
		/obj/item/food/enchiladas,
		/obj/item/food/enchiladas,
		/obj/item/food/carneburrito,
		/obj/item/food/cheesyburrito,
		/obj/item/reagent_containers/cup/bottle/capsaicin,
	)
	crate_name = "fiesta crate"

/datum/supply_pack/organic/combomeal
	name = "Burger Combo Crate"
	desc = "We value our customers at Tasty Burger, so much so that we're willing to deliver -just for you.- Contains two combo meals, consisting of a Burger, Fries, and pack of chicken nuggets!"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/item/food/burger/cheese,
		/obj/item/food/burger/cheese,
		/obj/item/food/fries,
		/obj/item/food/fries,
		/obj/item/storage/fancy/nugget_box,
		/obj/item/storage/fancy/nugget_box,
	)
	crate_name = "tasty burger crate"
	crate_type = /obj/structure/closet/crate/wooden

/datum/supply_pack/organic/fakemeat
	name = "Synthmeat Crate"
	desc = "Not actually made out of Synths."
	cost = CARGO_CRATE_VALUE * 2.25
	contains = list(
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/meat/slab/meatproduct,
		/obj/item/food/fishmeat/carp/imitation,
		/obj/item/food/fishmeat/carp/imitation,
		/obj/item/food/fishmeat/carp/imitation,
		/obj/item/food/fishmeat/carp/imitation,
	)
	crate_name = "synthmeat crate"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/mixedboxes
	name = "Kitchen Loot Box"
	desc = "Get overwhelmed with inspiration by ordering these boxes of surprise ingredients! Get four boxes filled with an assortment of products!"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(
		/obj/item/storage/box/ingredients/wildcard,
		/obj/item/storage/box/ingredients/wildcard,
		/obj/item/storage/box/ingredients/wildcard,
		/obj/item/storage/box/ingredients/wildcard,
	)
	crate_name = "kitchen loot box"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/qualityoilbulk
	name = "Quality Oil Bulk Pack"
	desc = "Normal cooking oil not cutting it? Chef throw all the quality stuff in the frier because they thought it was funny? Well, We got you covered, Introducing a bulk pack of Ten (10) bottles of our finest oils, blended for the perfect taste in cold recipes, and a resistance for going acrid when cooking."
	cost = CARGO_CRATE_VALUE * 9
	contains = list(
		/obj/item/reagent_containers/condiment/quality_oil,
		/obj/item/reagent_containers/condiment/quality_oil,
		/obj/item/reagent_containers/condiment/quality_oil,
		/obj/item/reagent_containers/condiment/quality_oil,
		/obj/item/reagent_containers/condiment/quality_oil,
		/obj/item/reagent_containers/condiment/quality_oil,
		/obj/item/reagent_containers/condiment/quality_oil,
		/obj/item/reagent_containers/condiment/quality_oil,
		/obj/item/reagent_containers/condiment/quality_oil,
		/obj/item/reagent_containers/condiment/quality_oil,
	)
	crate_name = "bulk quality oil pack"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/vinegarbulk
	name = "Vinegar Bulk Pack"
	desc = "Mothic Cuisine night? The winged fellows in port? Well, We'll have you cooking in no time. Refined from several rich wines and cultivated for just the right bite, This pack Ten (10) Bottles of vinegar for the perfect dressings and sauces."
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
		/obj/item/reagent_containers/condiment/vinegar,
	)
	crate_name = "bulk vinegar pack"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/organic/lavalandsamples
	name = "Planetary Flora Samples"
	desc = "A box of samples taken from the surface of Lavaland. Requires Hydroponics access to open."
	cost = CARGO_CRATE_VALUE * 2
	access_view = ACCESS_HYDROPONICS
	contains = list(
		/obj/item/seeds/lavaland/polypore,
		/obj/item/seeds/lavaland/porcini,
		/obj/item/seeds/lavaland/inocybe,
		/obj/item/seeds/lavaland/ember,
		/obj/item/seeds/lavaland/seraka,
		/obj/item/seeds/star_cactus,
		/obj/item/seeds/star_cactus,
	)
	crate_name = "planetary seeds crate"
	crate_type = /obj/structure/closet/crate/hydroponics


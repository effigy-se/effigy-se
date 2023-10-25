/datum/crafting_recipe/food/haggis
	name = "Haggis"
	reqs = list(
		/obj/item/organ/internal/heart = 1,
		/obj/item/organ/internal/liver = 1,
		/obj/item/organ/internal/lungs = 1,
		/obj/item/organ/internal/stomach = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/oat = 1,
		/datum/reagent/consumable/salt = 1,
	)
	result = /obj/item/food/snacks/store/bread/haggis
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/neep_tatty_haggis
	name = "Haggis With Neeps and Tatties"
	reqs = list(
		/obj/item/food/snacks/breadslice/haggis = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/grown/redbeet = 1,
		/obj/item/food/grown/whitebeet = 1
		)
	result = /obj/item/food/snacks/neep_tatty_haggis
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/raw_battered_sausage
	name = "Raw Battered Sausage"
	reqs = list(
		/datum/reagent/consumable/ethanol/beerbatter = 5,
		/obj/item/food/raw_meatball = 1,
		/obj/item/food/meat/rawcutlet = 2
	)
	result = /obj/item/food/raw_sausage/battered
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/shortbread
	name = "Shortbread"
	time = 5
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/butter = 1
	)
	result = /obj/item/food/cookie/shortbread
	category = CAT_PASTRY

/datum/crafting_recipe/food/tuna
	name = "Can of Tuna"
	time = 40
	reqs = list(/obj/item/stack/sheet/iron = 1,
		/obj/item/food/fishmeat = 2
	)
	result = /obj/item/food/canned/tuna
	category = CAT_SEAFOOD

// Recipes that provide crafting instructions and don't yield any result

/datum/crafting_recipe/food/grill/battered_sausage
	reqs = list(
		/obj/item/food/raw_sausage/battered = 1
	)
	result = /obj/item/food/sausage/battered

/datum/crafting_recipe/food/piru_dough
	name = "Piru dough"
	reqs = list(
		/datum/reagent/consumable/piru_flour = 15,
		/datum/reagent/consumable/muli_juice = 10,
	)
	result = /obj/item/food/piru_dough
	category = CAT_TESHARI

/datum/crafting_recipe/food/spiced_jerky
	name = "Spiced Jerky"
	reqs = list(
		/obj/item/food/meat/cutlet = 1,
		/datum/reagent/consumable/nakati_spice = 2,
	)
	result = /obj/item/food/spiced_jerky
	category = CAT_TESHARI

/datum/crafting_recipe/food/sirisai_wrap
	name = "Sirisai Wrap"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/cabbage = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/sirisai_wrap
	category = CAT_TESHARI

/datum/crafting_recipe/food/sweet_piru_noodles
	name = "Sweet Piru Noodles"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/piru_pasta = 1,
		/obj/item/food/grown/kiri = 1,
		/obj/item/food/grown/muli = 1,
		/obj/item/food/grown/carrot = 1,
	)
	result = /obj/item/food/sweet_piru_noodles
	category = CAT_TESHARI

/datum/crafting_recipe/food/kiri_curry
	name = "Kiri Curry"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/piru_pasta = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/chili = 1,
		/datum/reagent/consumable/nakati_spice = 5,
		/datum/reagent/consumable/kiri_jelly = 5,
	)
	result = /obj/item/food/kiri_curry
	category = CAT_TESHARI

/datum/crafting_recipe/food/sirisai_flatbread
	name = "Sirisai Flatbread"
	reqs = list(
		/obj/item/food/grilled_piru_flatbread = 1,
		/obj/item/food/meat/cutlet = 3,
		/obj/item/food/grown/muli = 1,
		/obj/item/food/grown/tomato = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/sirisai_flatbread
	category = CAT_TESHARI

/datum/crafting_recipe/food/bluefeather_crisp
	name = "Bluefeather Crisp"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/datum/reagent/consumable/nakati_spice = 2,
	)
	result = /obj/item/food/bluefeather_crisp
	category = CAT_TESHARI

/datum/crafting_recipe/food/stewed_muli
	name = "Stewed Muli"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/datum/reagent/consumable/muli_juice = 10,
		/obj/item/food/meat/cutlet = 2,
		/obj/item/food/grown/cabbage = 1,
		/obj/item/food/grown/carrot = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/stewed_muli
	category = CAT_TESHARI

/datum/crafting_recipe/food/stuffed_muli_pod
	name = "Stuffed Muli Pod"
	reqs = list(
		/obj/item/food/grown/muli = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/kiri = 1,
		/obj/item/food/grown/chili = 1,
		/datum/reagent/consumable/nakati_spice = 2,
	)
	result = /obj/item/food/stuffed_muli_pod
	category = CAT_TESHARI

/datum/crafting_recipe/food/caramel_jelly_toast
	name = "Caramel-jelly Toast"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/datum/reagent/consumable/kiri_jelly = 5,
		/datum/reagent/consumable/caramel = 5,
	)
	result = /obj/item/food/caramel_jelly_toast
	category = CAT_TESHARI

/datum/crafting_recipe/food/kiri_jellypuff
	name = "Kiri Jellypuff"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/datum/reagent/consumable/kiri_jelly = 5,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/piru_flour = 5,
	)
	result = /obj/item/food/kiri_jellypuff
	category = CAT_TESHARI

/datum/crafting_recipe/food/bluefeather_crisps_and_dip
	name = "Bluefeather Crisps and Dip"
	reqs = list(
		/obj/item/food/bluefeather_crisp = 2,
		/datum/reagent/consumable/muli_juice = 5,
		/obj/item/food/grown/tomato = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/bluefeather_crisps_and_dip
	category = CAT_TESHARI

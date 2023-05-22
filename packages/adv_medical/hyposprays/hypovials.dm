/obj/item/reagent_containers/cup/hypovial
	name = "hypovial"
	desc = "A small, 60u capacity vial compatible with hyposprays."
	icon = 'packages/adv_medical/assets/obj/vials.dmi'
	icon_state = "hypovial"
	spillable = FALSE
	volume = 60
	/// The suffix of the overlay texture that the hypovial uses when loading textures.
	var/type_suffix = "-s"
	possible_transfer_amounts = list(1,2,5,10,14,20,30,45,60)
	fill_icon_thresholds = list(10, 25, 50, 75, 100)
	var/chem_color //Used for hypospray overlay

/obj/item/reagent_containers/cup/hypovial/update_overlays()
	. = ..()
	if(!fill_icon_thresholds)
		return
	if(reagents.total_volume)
		var/fill_name = fill_icon_state? fill_icon_state : icon_state
		var/fill_overlay = 10
		switch(round((reagents.total_volume / volume)*100))
			if(1 to 24)
				fill_overlay = 10
			if(25 to 49)
				fill_overlay = 25
			if(50 to 74)
				fill_overlay = 50
			if(75 to 89)
				fill_overlay = 75
			if(89 to 100)
				fill_overlay = 100
		var/mutable_appearance/filling = mutable_appearance('packages/adv_medical/assets/obj/hypospray_fillings.dmi', "[fill_name][fill_overlay]")

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		chem_color = filling.color
		. += filling

/obj/item/reagent_containers/cup/hypovial/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/reagent_containers/cup/hypovial/on_reagent_change()
	update_icon()

//Hypos that are in the CMO's kit round start
/obj/item/reagent_containers/cup/hypovial/crit
	name = "crit hypovial"
	list_reagents = list(/datum/reagent/medicine/omnizine/protozine = 30, /datum/reagent/medicine/atropine = 30)

/obj/item/reagent_containers/cup/hypovial/lenturi
	name = "burn hypovial"
	list_reagents = list(/datum/reagent/medicine/c2/lenturi = 60)

/obj/item/reagent_containers/cup/hypovial/syriniver
	name = "toxins hypovial"
	list_reagents = list(/datum/reagent/medicine/c2/syriniver = 60)

/obj/item/reagent_containers/cup/hypovial/synthflesh
	name = "synthflesh hypovial"
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 60)

/obj/item/reagent_containers/cup/hypovial/libital
	name = "brute hypovial"
	list_reagents = list(/datum/reagent/medicine/c2/libital = 60)

/obj/item/reagent_containers/cup/hypovial/convermol
	name = "oxyloss hypovial"
	list_reagents = list(/datum/reagent/medicine/c2/convermol = 60)

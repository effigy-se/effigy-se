/obj/item/scrap/tattered_sheet_metal
	icon_state = "tattered_sheet_metal"
	name = "tattered sheet metal"
	desc = "For when regular metal doesn't suffice."
	custom_materials = (/datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/scrap/whoopie_cushion/randomize_credit_cost()
	return rand(10, 22)

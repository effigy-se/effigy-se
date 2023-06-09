/*
* NIF STUFF
*/
/datum/supply_pack/goody/standard_nif
	name = "Standard Type NIF"
	desc = "Contains a single standard NIF by itself, surgery is required."
	cost = CARGO_CRATE_VALUE * 15
	contains = list(
		/obj/item/organ/internal/cyberimp/brain/nif/standard,
	)

/datum/supply_pack/goody/cheap_nif
	name = "Econo-Deck Type NIF"
	desc = "Contains a single Econo-Deck NIF by itself, surgery is required."
	cost = CARGO_CRATE_VALUE * 7.5
	contains = list(
		/obj/item/organ/internal/cyberimp/brain/nif/roleplay_model,
	)

/datum/supply_pack/goody/nif_repair_kit
	name = "Cerulean NIF Regenerator"
	desc = "Contains a single container of NIF repair fluid, good for up to 5 uses."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(
		/obj/item/nif_repair_kit,
	)

/datum/supply_pack/goody/money_sense_nifsoft
	name = "Automatic Appraisal NIFSoft"
	desc = "Contains a single Automatic Appraisal NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/money_sense,
	)

/datum/supply_pack/goody/shapeshifter_nifsoft
	name = "Polymorph NIFSoft"
	desc = "Contains a single Polymorph NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/shapeshifter,
	)

/datum/supply_pack/goody/hivemind_nifsoft
	name = "Hivemind NIFSoft"
	desc = "Contains a single Hivemind NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/disk/nifsoft_uploader/hivemind,
	)

/datum/supply_pack/goody/summoner_nifsoft
	name = "Grimoire Caeruleam NIFSoft"
	desc = "Contains a single Grimoire Caeruleam NIFSoft uploader disk."
	cost = CARGO_CRATE_VALUE * 0.75
	contains = list(
		/obj/item/disk/nifsoft_uploader/summoner,
	)

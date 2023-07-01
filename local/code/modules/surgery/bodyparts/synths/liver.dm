/obj/item/organ/internal/liver/synth
	name = "reagent processing unit"
	desc = "An electronic device that processes the beneficial chemicals for the synthetic user."
	organ_flags = ORGAN_SYNTHETIC | ORGAN_SYNTHETIC_FROM_SPECIES
	status = ORGAN_ROBOTIC
	icon = 'local/icons/obj/medical/surgery.dmi'
	icon_state = "liver-ipc"
	filterToxins = FALSE //We dont filter them, we're immune to them

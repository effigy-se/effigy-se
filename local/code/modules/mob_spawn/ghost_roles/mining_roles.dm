/obj/effect/mob_spawn/ghost_role/human/hermit
	quirks_enabled = TRUE
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/beach
	quirks_enabled = TRUE
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/bartender
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/seed_vault
	restricted_species = list(/datum/species/pod)
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/ash_walker
	restricted_species = list(/datum/species/lizard/ashwalker)
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/ash_walker/special(mob/living/carbon/human/spawned_human)
	spawned_human.fully_replace_character_name(null, spawned_human.generate_random_mob_name(TRUE))
	quirks_enabled = TRUE // ghost role quirks
	. = ..()

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

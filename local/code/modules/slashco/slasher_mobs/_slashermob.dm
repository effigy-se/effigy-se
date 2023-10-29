/mob/living/basic/slasher
	maxHealth = INFINITY
	health = INFINITY
	icon = 'local/icons/mob/slashers.dmi'
	lighting_cutoff_red = 50
	lighting_cutoff_green = 22
	lighting_cutoff_blue = 22

/mob/living/basic/slasher/Initialize(mapload)
	. = ..()
	name = initial(name)

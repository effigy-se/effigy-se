/atom/proc/do_jiggle(targetangle = 45, timer = 20)
	var/matrix/OM = matrix(transform)
	var/matrix/M = matrix(transform)
	var/halftime = timer * 0.5
	M.Turn(pick(-targetangle, targetangle))
	animate(src, transform = M, time = halftime, easing = ELASTIC_EASING)
	animate(src, transform = OM, time = halftime, easing = ELASTIC_EASING)

/atom/proc/do_squish(squishx = 1.2, squishy = 0.6, timer = 20)
	var/matrix/OM = matrix(transform)
	var/matrix/M = matrix(transform)
	var/halftime = timer * 0.5
	M.Scale(squishx, squishy)
	animate(src, transform = M, time = halftime, easing = BOUNCE_EASING)
	animate(src, transform = OM, time = halftime, easing = BOUNCE_EASING)

///This will check if GLOB.sprite_accessories[mutant_part]?[part_name] is associated with sprite accessory with factual TRUE.
/proc/is_factual_sprite_accessory(mutant_part, part_name)
	if(!mutant_part || !part_name)
		return FALSE
	var/datum/sprite_accessory/accessory = GLOB.sprite_accessories[mutant_part]?[part_name]
	return accessory?.factual

/obj/structure/chair/post_buckle_mob(mob/living/M)
	. = ..()
	if(HAS_TRAIT(M, TRAIT_OVERSIZED))
		visible_message(span_warning("[src] buckles under the weight of [M] causing it to break!"))
		playsound(src, 'local/sound/effects/chair_break.ogg', 70, TRUE)
		deconstruct()

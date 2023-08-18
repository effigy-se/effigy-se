/obj/item/stack/medical/splint
	name = "medical splint"
	desc = "Medical splints, designed to fastened a limb with ease, perfect for stabilizing broken bones and torn muscles. "
	gender = PLURAL
	singular_name = "medical splint"
	icon_state = "splint"
	icon = 'local/icons/obj/medical/stack_medical.dmi'
	self_delay = 5 SECONDS
	other_delay = 2 SECONDS
	max_amount = 12
	amount = 6
	grind_results = list(/datum/reagent/carbon = 2)
	custom_price = PAYCHECK_LOWER * 2
	merge_type = /obj/item/stack/medical/splint
	var/splint_type = /datum/bodypart_aid/splint

/obj/item/stack/medical/splint/try_heal(mob/living/M, mob/user, silent)
	var/obj/item/bodypart/limb = M.get_bodypart(check_zone(user.zone_selected))
	if(!limb)
		to_chat(user, span_notice("There's nothing there to bandage!"))
		return
	if(!LAZYLEN(limb.wounds))
		to_chat(user, span_notice("There's no wounds that require bandaging on [user==M ? "your" : "[M]'s"] [limb.name]!")) // good problem to have imo
		return

	var/splintable_wound = FALSE
	for(var/i in limb.wounds)
		var/datum/wound/woundies = i
		if(woundies.wound_flags & ACCEPTS_SPLINT)
			splintable_wound = TRUE
			break
	if(!splintable_wound)
		to_chat(user, span_notice("There's no wounds that require splinting on [user==M ? "your" : "[M]'s"] [limb.name]!")) // good problem to have imo
		return

	if(limb.current_splint)
		to_chat(user, span_warning("[user==M ? "Your" : "[M]'s"] [limb.name] is already fastened in a splint!"))
		return

	user.visible_message(span_warning("[user] begins fastening [M]'s [limb.name] with [src]..."), span_warning("You begin to fasten [user == M ? "your" : "[M]'s"] [limb.name] with [src]..."))
	if(!do_after(user, (user == M ? self_delay : other_delay), target=M))
		return

	user.visible_message(span_green("[user] applies [src] to [M]'s [limb.name]."), span_green("You splint [user == M ? "your" : "[M]'s"] [limb.name]."))
	limb.apply_splint(src)

/obj/item/stack/medical/splint/twelve
	amount = 12

/obj/item/stack/medical/splint/tribal
	name = "tribal splint"
	desc = "Bone fastened with sinew, used to keep injured limbs rigid, surprisingly effective."
	singular_name = "tribal splint"
	icon_state = "splint_tribal"
	amount = 1
	splint_type = /datum/bodypart_aid/splint/tribal
	merge_type = /obj/item/stack/medical/splint/tribal

/obj/item/stack/medical/splint/improvised
	name = "improvised splint"
	desc = "Crudely made out splints with wood and some cotton sling, you doubt this will be any good."
	singular_name = "improvised splint"
	icon_state = "splint_improv"
	amount = 1
	splint_type = /datum/bodypart_aid/splint/improvised
	merge_type = /obj/item/stack/medical/splint/improvised

/obj/item/stack/medical/gauze
	var/gauze_type = /datum/bodypart_aid/gauze
	var/splint_type = /datum/bodypart_aid/splint

/obj/item/stack/medical/gauze/improvised
	gauze_type = /datum/bodypart_aid/gauze/improvised
	splint_type = /datum/bodypart_aid/splint/improvised

/obj/item/bodypart/proc/apply_gauze(obj/item/stack/medical/gauze/new_gauze)
	if(!istype(new_gauze) || current_gauze)
		return
	current_gauze = new new_gauze.gauze_type(src)
	new_gauze.use(1)

/obj/item/bodypart/proc/apply_splint(obj/item/stack/medical/gauze/new_splint)
	if(!istype(new_splint) || current_splint)
		return
	current_splint = new new_splint.splint_type(src)
	new_splint.use(1)
/obj/item/stack/medical/gauze/improvised
	gauze_type = /datum/bodypart_aid/gauze/improvised
	splint_type = /datum/bodypart_aid/splint/improvised

// gauze is only relevant for wounds, which are handled in the wounds themselves
/obj/item/stack/medical/gauze/try_heal(mob/living/patient, mob/user, silent)

	var/treatment_delay = (user == patient ? self_delay : other_delay)

	var/obj/item/bodypart/limb = patient.get_bodypart(check_zone(user.zone_selected))
	if(!limb)
		patient.balloon_alert(user, "missing limb!")
		return
	if(!LAZYLEN(limb.wounds))
		patient.balloon_alert(user, "no wounds!") // good problem to have imo
		return

	var/gauzeable_wound = FALSE
	var/splintable_wound = FALSE
	var/datum/wound/woundies
	for(var/i in limb.wounds)
		woundies = i
		if(woundies.wound_flags & (ACCEPTS_GAUZE | ACCEPTS_SPLINT))
			if(woundies.wound_flags & ACCEPTS_GAUZE)
				gauzeable_wound = TRUE
				continue
			if(woundies.wound_flags & ACCEPTS_SPLINT)
				splintable_wound = TRUE
				continue
	if(!gauzeable_wound && !splintable_wound)
		patient.balloon_alert(user, "can't heal those!")
		return

	if(limb.current_gauze && gauzeable_wound)
		gauzeable_wound = FALSE
	if(limb.current_splint && splintable_wound)
		splintable_wound = FALSE
	if(!gauzeable_wound && !splintable_wound)
		balloon_alert(user, "already bandaged!")
		return

	if(HAS_TRAIT(woundies, TRAIT_WOUND_SCANNED))
		treatment_delay *= 0.5
		if(user == patient)
			user.visible_message(span_warning("[user] begins expertly [gauzeable_wound ? "wrapping the wounds on their [limb.plaintext_zone]" : "splinting their [limb.plaintext_zone]"] with [src]..."), span_notice("You keep in mind the indications from the holo-image about your injury, and expertly begin [gauzeable_wound ? "wrapping your wounds" : "splinting your [limb.plaintext_zone]"] with [src]."))
		else
			user.visible_message(span_warning("[user] begins expertly [gauzeable_wound ? "wrapping the wounds on [patient]'s [limb.plaintext_zone]" : "splinting [patient]'s [limb.plaintext_zone]"] with [src]..."), span_warning("You begin quickly [gauzeable_wound ? "wrapping the wounds on [patient]'s [limb.plaintext_zone]" : "splinting [patient]'s [limb.plaintext_zone]"] with [src], keeping the holo-image indications in mind..."))
	else
		user.visible_message(span_warning("[user] begins [gauzeable_wound ? "wrapping the wounds on [patient]'s [limb.plaintext_zone]" : "splinting [patient]'s [limb.plaintext_zone]"] with [src]..."), span_warning("You begin [gauzeable_wound ? "wrapping the wounds on" : "splinting"] [user == patient ? "your" : "[patient]'s"] [limb.plaintext_zone] with [src]..."))

	if(!do_after(user, treatment_delay, target = patient))
		return

	user.visible_message("<span class='infoplain'><span class='green'>[user] [gauzeable_wound ? "wraps the wounds on" : "splints"] [user == patient ? "[user.p_their()]" : "[patient]'s"] [limb.plaintext_zone] with [src].</span></span>", "<span class='infoplain'><span class='green'>You [gauzeable_wound ? "wrap the wounds on" : "splint"]  [user == patient ? "your" : "[patient]'s"] [limb.plaintext_zone].</span></span>")
	if(gauzeable_wound)
		limb.apply_gauze(src)
		return
	if(splintable_wound)
		limb.apply_splint(src)
		return

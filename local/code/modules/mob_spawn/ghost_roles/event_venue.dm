/obj/effect/mob_spawn/ghost_role/human/interlink_event_venue
	name = "guest entry transit tube"
	icon = /obj/structure/transit_tube/station/dispenser/reverse::icon
	icon_state = /obj/structure/transit_tube/station/dispenser/reverse::icon_state
	desc = "A conveinent; all-in-one solution for guest dropoff, straight to the venue. The future is now; and stolen directly from your local bank."
	prompt_name = "event venue guest"
	uses = 0
	deletes_on_zero_uses_left = FALSE
	you_are_text = "The event venue is open; and you are a guest."
	flavour_text = "Try to be on your best behavior for whatever is unfurling to bring you here."
	important_text = "Depending on the Event's context and the organizer(s') consent; you may be at risk of invoking Rule 4 for creating a disturbance. Exercise your best judgement."
	spawner_job_path = /datum/job/event_venue
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE
	show_flavor = FALSE
	role_ban = ROLE_EVENTVENUE_GUEST

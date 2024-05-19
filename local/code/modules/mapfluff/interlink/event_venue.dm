/// Fluff Papers
/obj/item/paper/fluff/interlink/event_venue_howto_admin_only_do_not_fucking_map_this_elsewhere_i_will_find_you // christmas present spawn's still a-okay; just insuring nobody does anything stupid
	name = "paper - 'How To Run An Event Venue Event'"
	default_raw_text = {"Hey there! I'm going to drop all shred of the fourth wall here to get what I need to across: <br>
		If you're reading this; you're either a snooping observer or an admin curious on how to use the event venue. Here's some things you have to keep in mind: <br>
		- It's highly reccomended NOT to enable both the ghost spawner and the connector to the Interlink. Unlogged stealth respawns are a headache for you and your fellow staff. <br>
		- If you enable the ghost spawner; remember you that you can customize which outfit everyone will spawn with the "outfit" variable. Do not edit the spawner_job_path variable. <br>
		- By default; everyone will spawn in with their loadout. While I'd reccomend working AROUND this; you can disable it via the "loadout_enabled" variable. <br>
		- Do not give the ghost spawner any CentCom or ERT-Adjacent Outfits. Anyone with the access flag "ACCESS_CENT_CAPTAIN" can jailbreak the venue. <br>
		- To enable the spawner; set "uses" to the amount of participants allowed (-1 for infinity). <br>
		- On the spawner; It's reccomended to edit "flavor_text" to explain the context of the event (wedding; bougie party; etc) and "important_text" to clarify if shitstirring (or worse) was/is allowed."}

/obj/item/paper/fluff/interlink/pizza_party
	name = "paper - 'pizza party howto'"
	default_raw_text = {"In an effort to save on kitchen space; we've provided a special pizza box that should remotely order and prepare the favored pizza of whomever opens it each time. Show it to your
	guests; have them open the box - and take out the pizza provided. Try not to let them order multiple for our budget."}

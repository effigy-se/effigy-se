/obj/item/toy/plush/effigy/socialdistrict
	name = "debug social district plushie"
	desc = "oh no how did this get here i am not good with computer"
	icon_state = "debug"
	attack_verb_continuous = list("kisses", "nuzzles", "cuddles", "purrs against")
	attack_verb_simple = list("kiss", "nuzzle", "cuddle", "purr against")
	squeak_override = list('local/sound/emotes/voice/nya.ogg' = 1)
	anchored = TRUE
	var/district_addr
	var/district_name
	special_desc = "<div class='chat_alert_pink'>Changing district...</div>"

/obj/item/toy/plush/effigy/socialdistrict/social
	name = "social district plushie"
	desc = "A bright blue feline plush with neon pink hair, here to hand out kisses wherever kisses need be. Usually found near its home habitat, the tram."
	icon_state = "plushie_skyy"
	attack_verb_continuous = list("kisses", "nuzzles", "cuddles", "purrs against")
	attack_verb_simple = list("kiss", "nuzzle", "cuddle", "purr against")
	squeak_override = list('local/sound/emotes/voice/nya.ogg' = 1)
	district_addr = "ss13.effigy.se:7717"

/obj/item/toy/plush/effigy/socialdistrict/action
	name = "action district plushie"
	desc = "Not actually made of igneous rock, giving this plush a hug will let you feel like you're being squeezed by the jaws of life!"
	icon_state = "plushie_granite"
	attack_verb_continuous = list("bleps", "SQUEEZES", "pies")
	attack_verb_simple = list("blep", "SQUEEZE", "pie")
	squeak_override = list('local/sound/emotes/generic/twobeep.ogg' = 1)
	district_addr = "ss13.effigy.se:7717"
	district_name = "Action District"

/obj/item/toy/plush/effigy/socialdistrict/examine_more(mob/user)
	. = ..()
	var/client/player_client = user?.client
	if(isnull(player_client))
		return

	if(tgui_alert(user, "Move to the [district_name]?", "Nya", list("Yes", "No")) != "Yes")
		return

	player_client << link("byond://[district_addr]")

/mob/living/silicon/Login()
	if(mind)
		mind?.remove_antags_for_borging()
	// EFFIGY EDIT ADD START
		var/voice_to_use = client?.prefs.read_preference(/datum/preference/choiced/voice)
		if(voice_to_use)
			voice = voice_to_use
	// EFFIGY EDIT ADD END
	return ..()


/mob/living/silicon/auto_deadmin_on_login()
	if(!client?.holder)
		return TRUE
	if(CONFIG_GET(flag/auto_deadmin_silicons) || (client.prefs?.toggles & DEADMIN_POSITION_SILICON))
		return client.holder.auto_deadmin()
	return ..()

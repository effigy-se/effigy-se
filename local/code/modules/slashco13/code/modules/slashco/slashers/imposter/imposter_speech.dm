/datum/status_effect/speech/imposter
	id = "imposter"

/datum/status_effect/speech/imposter/handle_message(datum/source, list/message_args)
	var/picked_message = rand(1,7)
	switch(picked_message)
		if(1)
			message_args[TREAT_MESSAGE_ARG] = "IMposter.. amongoose.. e-hju-"
		if(2)
			message_args[TREAT_MESSAGE_ARG] = "sUS SUS SUS AMONGASS-ssu-"
		if(3)
			message_args[TREAT_MESSAGE_ARG] = "SUS! Sus. Sus- Amonggh-h-hhhech-"
		if(4)
			message_args[TREAT_MESSAGE_ARG] = "Ishs-ushises; Imposter- h-gh-"
		if(5)
			message_args[TREAT_MESSAGE_ARG] = "Imposter among us; Imposter-"
		if(6)
			message_args[TREAT_MESSAGE_ARG] = "Among us. sss-sh-sh-Gah-sshhhHHhhuh-wh-POSB-Stew-wwww..."
		if(7)
			message_args[TREAT_MESSAGE_ARG] = "Among us. Ps-s-sp-Owa-PFT-Gh-ss-sfh-pf-HHhhhhhua- Im-post-eerrrrrrrr....."
	playsound(get_turf(source), "local/code/modules/slashco13/sound/slasher/imposter/speech[picked_message].ogg", 75)

	return

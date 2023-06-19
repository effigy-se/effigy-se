/proc/is_banned_from_antag_se(question, mob/candidate_mob)
	if(is_banned_from(candidate_mob.ckey, BAN_GHOST_TAKEOVER) || is_banned_from(candidate_mob.ckey, BAN_ANTAGONIST))
		to_chat(candidate_mob, "There was a ghost prompt for: [question], unfortunately you are banned from ghost takeovers.")
		return TRUE

	return FALSE

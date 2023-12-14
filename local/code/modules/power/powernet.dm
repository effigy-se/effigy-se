/datum/powernet/get_electrocute_damage()
	if(avail >= 1000 && avail <= 15000)
		return round(avail/45000) + rand(-30,2) //Slight buff. Weaker electrical currents are somewhat mitigated.
	if(avail >= 15000)
		return round(avail/15000) + rand(-5,10) //You're dead.
	if(avail >= 20000)
		return round(avail/10000) + rand(0,20) //You're VERY dead.
	// EffigyEdit Change END
	else
		return 0

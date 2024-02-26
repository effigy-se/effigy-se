/datum/weather/rain_storm
	name = "rain storm"
	desc = "Thick bouts of rain trickle in from the trees above, coating the outside jungle."
	probability = 90

	telegraph_message = "<span class='warning'>The atmosphere shifts as clouds converge..</span>"
	telegraph_duration = 300
	telegraph_overlay = "light_rain"

	weather_message = "<span class='userdanger'><i>Rain pours in from the breaks in the trees above!</i></span>"
	weather_overlay = "rain_storm"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = "<span class='boldannounce'>The raindrops slow, before falling still.</span>"

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_RAINSTORM

	barometer_predictable = TRUE

	glow_overlay_icon = 'local/icons/effects/glow_weather.dmi'
	weather_overlay_icon = 'local/icons/effects/weather_effects.dmi'

// since rainstorm is on a station z level, add extra checks to not annoy everyone
/datum/weather/rain_storm/can_get_alert(mob/player)
	if(!..())
		return FALSE

	if(!is_station_level(player.z))
		return TRUE  // bypass checks

	if(isobserver(player))
		return TRUE

	if(HAS_MIND_TRAIT(player, TRAIT_DETECT_STORM))
		return TRUE

	if(istype(get_area(player), /area/mine))
		return TRUE

	for(var/area/rain_area in impacted_areas)
		if(locate(rain_area) in view(player))
			return TRUE

	return FALSE

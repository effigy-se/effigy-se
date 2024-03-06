/// Dynamically calculate nightshift brightness. How TG does it is painful to modify.
#define NIGHTSHIFT_POWER_MODIFIER 0.25
#define NIGHTSHIFT_RANGE_MODIFIER 0.25
#define NIGHTSHIFT_COLOR_MODIFIER 0.15

/atom
	light_power = 1.25

/obj/machinery/light
	icon = 'local/icons/obj/lighting.dmi'
	overlay_icon = 'local/icons/obj/lighting_overlay.dmi'
	brightness = 7
	fire_brightness = 9
	fire_colour = "#E85888"
	bulb_colour = LIGHT_COLOR_DEFAULT
	bulb_power = 1.2
	nightshift_light_color = null // Let the dynamic night shift color code handle this.
	bulb_low_power_colour = COLOR_STRONG_BLUE
	bulb_low_power_brightness_mul = 0.75
	bulb_low_power_pow_mul = 0.75
	bulb_low_power_pow_min = 0.75
	bulb_emergency_colour = LIGHT_COLOR_INTENSE_RED
	bulb_major_emergency_brightness_mul = 1
	power_consumption_rate = 5.62
	var/maploaded = FALSE //So we don't have a lot of stress on startup.
	var/turning_on = FALSE //More stress stuff.

/obj/machinery/light/proc/turn_on(trigger, play_sound = TRUE)
	if(QDELETED(src))
		return
	turning_on = FALSE
	if(!on)
		return
	var/area/local_area  = get_room_area(src)
	var/new_brightness = brightness
	var/new_power = bulb_power
	var/new_color = bulb_colour
	if (local_area?.fire)
		new_color = fire_colour
		new_brightness = fire_brightness
	else if(color)
		new_color = color
	else if (nightshift_enabled)
		new_brightness -= NIGHTSHIFT_RANGE_MODIFIER
		new_power -= NIGHTSHIFT_POWER_MODIFIER
		if(!color && nightshift_light_color)
			new_color = nightshift_light_color
		else if(color) // In case it's spraypainted.
			new_color = color
		else // Adjust light values to be warmer. I doubt caching would speed this up by any worthwhile amount, as it's all very fast number and string operations.
			// Convert to numbers for easier manipulation.
			var/list/color_parts = rgb2num(bulb_colour)
			var/red = color_parts[1]
			var/green = color_parts[2]
			var/blue = color_parts[3]

			red += round(red * NIGHTSHIFT_COLOR_MODIFIER)
			green -= round(green * NIGHTSHIFT_COLOR_MODIFIER * 0.3)
			red = clamp(red, 0, 255) // clamp to be safe, or you can end up with an invalid hex value
			green = clamp(green, 0, 255)
			blue = clamp(blue, 0, 255)
			new_color = "#[num2hex(red, 2)][num2hex(green, 2)][num2hex(blue, 2)]"  // Splice the numbers together and turn them back to hex.

	var/matching = light && new_brightness == light.light_range && new_power == light.light_power && new_color == light.light_color
	if(!matching)
		switchcount++
		if(prob(min(60, (switchcount**2)*0.01)))
			if(trigger)
				burn_out()
		else
			use_power = ACTIVE_POWER_USE
			set_light(new_brightness, new_power, new_color)

/obj/machinery/light/dim
	bulb_colour = LIGHT_COLOR_DEFAULT
	bulb_power = 0.8

/obj/machinery/light/cold/dim
	bulb_power = 0.8

/obj/machinery/light/warm/dim
	bulb_power = 0.8

/obj/machinery/light/small
	brightness = 3.5
	nightshift_brightness = 3
	bulb_colour = LIGHT_COLOR_DEFAULT
	bulb_power = 1
	fire_colour = "#E85888"

/obj/machinery/light/cold
	nightshift_light_color = null

/obj/machinery/light/warm
	bulb_colour = LIGHT_COLOR_DEFAULT
	nightshift_light_color = null


#undef NIGHTSHIFT_POWER_MODIFIER
#undef NIGHTSHIFT_RANGE_MODIFIER
#undef NIGHTSHIFT_COLOR_MODIFIER

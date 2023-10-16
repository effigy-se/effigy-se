/mob/living/silicon
	var/datum/examine_panel/examine_panel = new() //create the datum

/mob/living/silicon/robot
	var/robot_resting = FALSE
	var/robot_rest_style = ROBOT_REST_NORMAL

/mob/living/silicon/robot/model/cargo
	set_model = /obj/item/robot_model/cargo
	icon_state = "cargo"

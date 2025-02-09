/obj/item/scrap/toy_robot
	icon_state = "toy_robot"
	name = "toy robot"
	desc = "Pre-painted. No wonder it ended up in with the trash."
	pickup_sound = 'sound/items/metal_pick_up.ogg'
	drop_sound = 'sound/items/metal_drop.ogg'

/obj/item/scrap/toy_robot/randomize_credit_cost()
	return rand(56, 87)

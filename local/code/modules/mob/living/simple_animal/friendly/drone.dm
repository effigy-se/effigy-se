/mob/living/basic/drone
	//So that drones can do things without worrying about stuff
	shy = FALSE
	//So drones aren't forced to carry around a nodrop toolbox essentially
	default_storage = /obj/item/storage/backpack/drone_bag

/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	name = "[initial(name)] [rand(0,9)]-[rand(100,999)]" //So that we can identify drones from each other

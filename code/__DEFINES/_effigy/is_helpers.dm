#define is_curator_job(job_type) (istype(job_type, /datum/job/curator))

#define iscomputer(passed_atom) (istype(passed_atom, /obj/machinery/computer))

#define ismelee(A) (istype(A, /obj/item/melee)) // Does not guarantee this is a weapon because this typepath is real soulcode. It's going to be phased out longterm; hopefully...

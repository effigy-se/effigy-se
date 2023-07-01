/datum/tgs_chat_command/addbunkerbypass
	name = "whitelist"
	help_text = "whitelist <ckey>"
	admin_only = TRUE

/datum/tgs_chat_command/addbunkerbypass/Run(datum/tgs_chat_user/sender, params)
	if(!CONFIG_GET(flag/sql_enabled))
		return "The Database is not enabled!"

	GLOB.bunker_passthrough |= ckey(params)

	GLOB.bunker_passthrough[ckey(params)] = world.realtime
	SSpersistence.save_panic_bunker() //we can do this every time, it's okay
	log_admin("[sender.friendly_name] has added [params] to the current round's bunker bypass list.")
	message_admins("[sender.friendly_name] has added [params] to the current round's bunker bypass list.")
	return new /datum/tgs_message_content("[params] has been added to the current round's bunker bypass list.")

/datum/controller/subsystem/persistence/proc/load_panic_bunker()
	var/bunker_path = file("data/bunker_passthrough.json")
	if(fexists(bunker_path))
		var/list/json = json_decode(file2text(bunker_path))
		GLOB.bunker_passthrough = json["data"]
		for(var/ckey in GLOB.bunker_passthrough)
			if(daysSince(GLOB.bunker_passthrough[ckey]) >= CONFIG_GET(number/max_bunker_days))
				GLOB.bunker_passthrough -= ckey

/datum/controller/subsystem/persistence/proc/save_panic_bunker()
	var/json_file = file("data/bunker_passthrough.json")
	var/list/file_data = list()
	file_data["data"] = GLOB.bunker_passthrough
	fdel(json_file)
	WRITE_FILE(json_file,json_encode(file_data))

/datum/config_entry/number/max_bunker_days
	default = 7
	min_val = 1

/// A list of vars that shouldn't be tracked by persistence.
GLOBAL_LIST_INIT(modular_persistence_ignored_vars, list(
	"datum_flags",
	"datum_components",
	"comp_lookup",
	"tgui_shared_states",
	"gc_destroyed",
	"active_timers",
	"status_traits",
	"signal_procs",
	"cached_ref",
	"weak_reference",
	"cooldowns",
	"__auxtools_weakref_id",
	"tag",
	"type",
	"parent_type",
	"owner",
	"vars",
	"stored_character_slot_index",
))

/obj/item/organ/internal/brain
	/// The modular persistence data for a character.
	var/datum/modular_persistence/modular_persistence

/// Saves the contents of the modular persistence datum for the player's client to their file.
/datum/controller/subsystem/persistence/proc/save_modular_persistence()
	for(var/mob/living/carbon/human/player in GLOB.human_list)
		player.save_individual_persistence()

/// Loads the contents of the player's modular_persistence file to their character.
/datum/controller/subsystem/persistence/proc/load_modular_persistence(obj/item/organ/internal/brain/brain)
	if(!brain)
		return FALSE

	if(!ishuman(brain.owner))
		return FALSE

	var/mob/living/carbon/human/player = brain.owner

	var/json_file = file("data/player_saves/[player.ckey[1]]/[player.ckey]/modular_persistence.json")
	var/list/json = fexists(json_file) ? json_decode(file2text(json_file)) : null

	brain.modular_persistence = new(brain, islist(json) ? json["[player.mind.original_character_slot_index]"] : null)

/// The master persistence datum. Add vars onto this in your own code. Just be aware that you'll need to use simple data types, such as strings, ints, and lists.
/datum/modular_persistence
	/// The human that this is attached to.
	var/obj/item/organ/internal/brain/owner
	/// The owner's character slot index.
	var/stored_character_slot_index

/datum/modular_persistence/New(obj/item/organ/internal/brain/brain, list/persistence_data)
	owner = brain
	. = ..()

	stored_character_slot_index = owner.owner.mind?.original_character_slot_index

	if(!persistence_data)
		return

	for(var/var_name in vars)
		var/var_entry = persistence_data[var_name]

		if(var_entry)
			vars[var_name] = var_entry

	if(!owner.owner)
		CRASH("Tried to load modular persistence on a brain with no owner! How did this happen?! (\ref[brain], [brain.brainmob?.ckey], [brain])")

	var/mob/living/carbon/human/human = owner.owner
	human.load_nif_data(src)

/datum/modular_persistence/Destroy(force, ...)
	owner = null
	return ..()

// On a base datum, this should be empty, at a glance.
/datum/modular_persistence/proc/serialize_contents_to_list()
	var/list/returned_list = list()

	var/mob/living/carbon/human/human = owner.owner
	human.save_nif_data(src)

	for(var/var_name in vars)
		if(var_name in GLOB.modular_persistence_ignored_vars)
			continue

		var/var_entry = vars[var_name]

		if(!isnull(var_entry))
			returned_list[var_name] = var_entry

	return returned_list

/// Saves the held persistence data to where it needs to go.
/datum/modular_persistence/proc/save_data(var/ckey)
	ckey = replacetext(ckey || owner.owner?.ckey || owner.brainmob?.ckey, "@", "")
	if(!owner.owner && !owner.brainmob)
		CRASH("Modular persistence save called on a brain with no owning mob or brainmob! How did this happen?! (\ref[owner], [owner])")
	if(!ckey)
		CRASH("Modular persistence save called on a brain with no ckey! How did this happen?! (\ref[owner], [owner])")

	var/json_file = file("data/player_saves/[ckey[1]]/[ckey]/modular_persistence.json")
	var/list/json = fexists(json_file) ? json_decode(file2text(json_file)) : list()
	fdel(json_file)

	if(!islist(json))
		json = list()

	json["[stored_character_slot_index]"] = serialize_contents_to_list()
	WRITE_FILE(json_file, json_encode(json))

/// Saves the persistence data for the owner.
/mob/living/carbon/human/proc/save_individual_persistence(var/ckey)
	var/obj/item/organ/internal/brain/brain = get_organ_slot(ORGAN_SLOT_BRAIN)

	return brain?.modular_persistence?.save_data(ckey)

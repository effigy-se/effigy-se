/// This was initially going to be a spawner for dorms(tm) items but the d20 said I should be useful for once
/obj/effect/spawner/random/clothing/otherwise_unused
	name = "effigy's otherwise unused clothing lottery spawner"
	desc = "A conveinent list of clothing we need to either remove or implement, and a loot spawner, all in one!"
	loot = list(
		// Civilian
		/obj/item/clothing/head/costume/cowboyhat_old,
		/obj/item/clothing/glasses/trickblindfold/hamburg,
		/obj/item/clothing/mask/muzzle/ball,
		/obj/item/clothing/mask/gas/atmos/glass, // this is just a duplicate of /obj/item/clothing/mask/gas/glass with a different name...
		/// Implant
		// /obj/item/clothing/glasses/nerve_staple, // This entry isn't actually for the spawner as shit would break, but this is an item orphaned from a quirk we didn't port. It's also just pacifism but easier to game

		// Cargo
		/// Quartermaster
		// /obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck, // Skirt variant IS used????? // yes and i hate only one is. leaving this here as a reminder to how much i hate one being used and not the other

		// Command
		// Captain
		/obj/item/clothing/head/caphat/beret/alt,
		/obj/item/clothing/under/rank/captain/skyrat/utility/syndicate, // Interdyne/DS-2 Leftover
		/obj/item/clothing/under/rank/captain/skyrat/pilot, // FUCKING SHIPSTATION LEFTOVER // also used on rimpoint and i'm biased so keep it :3
		/obj/item/clothing/under/rank/captain/skyrat/pilot/skirt, // shipstation leftover // uwa~ captain-chan.. dockside is superior, you're right~..
		/// I should be shot for the above comment, anyways engineering section
		/// Who wrote this? What's your operating number?
		/// Blueshield
		/obj/item/clothing/neck/mantle/bsmantle,
		/obj/item/clothing/under/rank/blueshield,
		/obj/item/clothing/under/rank/blueshield/skirt,
		/obj/item/clothing/under/rank/blueshield/turtleneck,
		/obj/item/clothing/under/rank/blueshield/turtleneck/skirt,
		/// NT Representative (can't we repurpose these for HOP or something? green fits hop being technically the service dept head)
		/obj/item/clothing/head/hats/intern/developer, // ????? What is the point of this one // looks like they wanted a more informal name on the parent item. we can probably just delete this
		/obj/item/clothing/under/rank/nanotrasen_consultant,
		/obj/item/clothing/under/rank/nanotrasen_consultant/skirt,

		//Engineering
		/// Chief Engineer
		/obj/item/clothing/head/beret/engi/ce,
		/// Engineer
		/obj/item/clothing/glasses/hud/eyepatch/meson/blindfold,
		/// Atmospheric Technician
		/obj/item/clothing/mask/gas/atmos/vox, // racial Vox item (should get this back in)
		/obj/item/clothing/under/rank/engineering/atmospheric_technician/skyrat/utility/advanced,  // just a rename of engineering utility suit

		// Medical
		/// Chief Medical Officer
		/obj/item/clothing/head/beret/medical/cmo/alt,
		/// Doctor
		/obj/item/clothing/glasses/hud/eyepatch/med/blindfold,

		// Science
		/// Research Director
		/obj/item/clothing/head/beret/science/rd/alt,
		/// Scientist
		/obj/item/clothing/head/beret/science/fancy,
		/obj/item/clothing/glasses/hud/eyepatch/diagnostic/blindfold,
		/obj/item/clothing/glasses/hud/eyepatch/sci/blindfold,

		// Service
		/// Head of Personnel
		/obj/item/clothing/head/hopcap/beret,
		/obj/item/clothing/head/hopcap/beret/alt,
		/obj/item/clothing/suit/toggle/hop_parade,
		/obj/item/clothing/suit/armor/vest/capcarapace/jacket,
		/obj/item/clothing/suit/toggle/labcoat/effigy/rd,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade/female,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck/skirt,
		/// Chaplain
		/obj/item/storage/backpack/satchel/crusader,
		/obj/item/storage/belt/crusader,

		// Security
		/// Head of Security
		/obj/item/clothing/head/hats/hos/peacekeeper/sol,
		/obj/item/clothing/suit/armor/hos/navyblue,
		/obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper/cloak, // Bluesec leftover
		/// Security Officer
		/obj/item/clothing/glasses/hud/eyepatch/sec/blindfold,
		/obj/item/clothing/mask/gas/sechailer/vox, // racial Vox item
		/obj/item/clothing/neck/mantle/regal, // racial Unathi item
		/obj/item/clothing/under/rank/security/skyrat/utility/redsec, // BlueSec remnant (we should nuke all bluesec remnants)
		/obj/item/clothing/under/rank/security/peacekeeper/sol/cadet,
		/obj/item/clothing/under/rank/security/head_of_security/peacekeeper/sol,
		/obj/item/clothing/suit/cowboyvest, // Why is this a dupe of the one the det gets
		/obj/item/clothing/suit/toggle/jacket/sec/old, // BlueSec leftover
		/obj/item/storage/belt/holster/cowboy,

		// Enclave //can we use this stuff in a bitrunner thing? shooting enclave soldiers could be fun
		/obj/item/clothing/gloves/military, // GAMER GEAR GAMER GEAR
		/obj/item/clothing/head/soft/enclave, // cringe
		/obj/item/clothing/head/soft/enclaveo, // ditto
		/obj/item/clothing/under/syndicate/skyrat/enclaveo, // Cringe
		/obj/item/clothing/under/syndicate/skyrat/enclaveo/real, // Cringe
		/obj/item/clothing/under/syndicate/skyrat/enclave/real, // Cringe

		// Historic
		/obj/item/clothing/mask/gas/german,
		/obj/item/clothing/mask/gas/hecu1,
		/obj/item/clothing/mask/gas/hecu2,
		/obj/item/clothing/mask/gas/soviet,

		// Syndicate
		/// Interdyne QM
		/obj/item/clothing/under/rank/cargo/qm/skyrat/syndie, // Used on a rimpoint ruin but useful to group it in
		/obj/item/clothing/suit/toggle/jacket/supply/head,
		/obj/item/clothing/neck/cloak/qm/syndie,
		/// Interdyne Bioweapon Scientist
		/obj/item/clothing/under/rank/cargo/tech/skyrat/utility/syndicate,
		/obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate, // removes NT namedrop in description and has no sensors. good for ruins
		/obj/item/clothing/under/rank/medical/doctor/skyrat/utility/syndicate, // removes NT namedrop in description and has no sensors. good for ruins
		/// DS-2 Master at Arms
		/obj/item/clothing/head/beret/sec/navywarden/syndicate,
		/obj/item/clothing/suit/armor/vest/warden/syndicate,
		/obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate,
		/// DS-2 Engineer
		/obj/item/clothing/under/rank/engineering/engineer/skyrat/utility/syndicate,
		/// DS-2 Crew
		/obj/item/clothing/under/misc/skyrat/utility/syndicate,
		/obj/item/clothing/under/syndicate/skyrat/baseball,
		/obj/item/clothing/under/syndicate/skyrat/tactical, // (Technically used on a rimpoint ruin)
		/obj/item/clothing/under/syndicate/skyrat/tactical/skirt, // Ditto
	)

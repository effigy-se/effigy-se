/// This was initially going to be a spawner for dorms(tm) items but the d20 said I should be useful for once
/obj/effect/spawner/random/clothing/otherwise_unused
	name = "effigy's otherwise unused clothing lottery spawner"
	desc = "A conveinent list of clothing we need to either remove or implement, and a loot spawner, all in one!"
	loot = list(
		/obj/item/clothing/ears/headphones,
		/obj/item/clothing/glasses/kim,
		/obj/item/clothing/glasses/trickblindfold/hamburg,
		/obj/item/clothing/glasses/hud/eyepatch/sec/blindfold,
		/obj/item/clothing/glasses/hud/eyepatch/med/blindfold,
		/obj/item/clothing/glasses/hud/eyepatch/meson/blindfold,
		/obj/item/clothing/glasses/hud/eyepatch/diagnostic/blindfold,
		/obj/item/clothing/glasses/hud/eyepatch/sci/blindfold,
		// /obj/item/clothing/glasses/nerve_staple, // This entry isn't actually for the spawner as shit would break, but this is an item orphaned from a quirk we didn't port. It's also just pacifism but easier to game
		/obj/item/clothing/gloves/military, // GAMER GEAR GAMER GEAR
		/obj/item/clothing/head/costume/skyrat/en,
		/obj/item/clothing/head/hats/intern/developer, // ????? What is the point of this one
		/obj/item/clothing/head/beret/sec/navywarden/syndicate, // Interdyne/DS-2 Leftover
		/obj/item/clothing/head/soft/enclave, // cringe
		/obj/item/clothing/head/soft/enclaveo, // ditto
		/obj/item/clothing/head/hats/hos/peacekeeper/sol,
		/obj/item/clothing/head/costume/cowboyhat_old,
		/obj/item/clothing/head/soft/yankee/rimless,
		/obj/item/clothing/head/beret/engi/ce,
		/obj/item/clothing/head/beret/medical/cmo/alt,
		/obj/item/clothing/head/beret/science/fancy,
		/obj/item/clothing/head/beret/science/rd/alt,
		/obj/item/clothing/head/beret/cargo/qm,
		/obj/item/clothing/head/beret/cargo/qm/alt,
		/obj/item/clothing/head/caphat/beret/alt,
		/obj/item/clothing/head/hopcap/beret,
		/obj/item/clothing/head/hopcap/beret/alt,
		/obj/item/clothing/mask/muzzle/ball,
		/obj/item/clothing/mask/gas/atmos/glass,
		/obj/item/clothing/mask/gas/alt,
		/obj/item/clothing/mask/gas/german,
		/obj/item/clothing/mask/gas/hecu1,
		/obj/item/clothing/mask/gas/hecu2,
		/obj/item/clothing/mask/gas/soviet,
		/obj/item/clothing/mask/gas/atmos/vox,
		/obj/item/clothing/mask/gas/sechailer/vox,
		/obj/item/clothing/neck/mantle/regal,
		/obj/item/clothing/neck/mantle/bsmantle, // Blueshield Leftover
		/obj/item/clothing/neck/cloak/qm/syndie, // Interdyne/DS-2 Leftover
		/obj/item/clothing/shoes/sneakers/crimson, // Interdyne/DS-2 Leftover
		/obj/item/storage/backpack/satchel/crusader,
		/obj/item/storage/belt/crusader,
		/obj/item/storage/belt/holster/cowboy,
		/obj/item/clothing/suit/armor/hos/navyblue,
		/obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper/cloak, // Bluesec leftover
		/obj/item/clothing/suit/armor/vest/warden/syndicate, // Interdyne/DS-2 Leftover
		/obj/item/clothing/suit/toggle/hop_parade,
		/obj/item/clothing/suit/armor/vest/capcarapace/jacket,
		/obj/item/clothing/suit/toggle/labcoat/effigy/rd,
		/obj/item/clothing/suit/kimjacket,
		/obj/item/clothing/suit/brownfurrich,
		/obj/item/clothing/suit/brownfurrich/public,
		/obj/item/clothing/suit/brownfurrich/white,
		/obj/item/clothing/suit/brownfurrich/cream,
		/obj/item/clothing/suit/modern_winter,
		/obj/item/electropack/shockcollar/pacify, // Ditto
		/// JUMPSUITS SECTION
		/// Civilian
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade/female,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck/skirt,
		/// Cargo
		/obj/item/clothing/under/rank/cargo/tech/skyrat/utility/syndicate, // Interdyne/DS-2 Leftover
		/obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck, // Skirt variant IS used?????
		/obj/item/clothing/under/rank/cargo/qm/skyrat/syndie, // Interdyne/DS-2 Leftover // Used on a rimpoint ruin but useful to group it in
		/obj/item/clothing/under/rank/cargo/qm/skyrat/formal,
		/obj/item/clothing/under/rank/cargo/qm/skyrat/formal/skirt,
		/obj/item/clothing/under/rank/cargo/qm/skyrat/casual,
		/// Command
		/obj/item/clothing/under/rank/captain/skyrat/kilt,
		/obj/item/clothing/under/rank/captain/skyrat/black,
		/obj/item/clothing/under/rank/blueshield, // Blueshield leftover
		/obj/item/clothing/under/rank/blueshield/skirt, // Blueshield leftover
		/obj/item/clothing/under/rank/blueshield/turtleneck, // Blueshield leftover
		/obj/item/clothing/under/rank/blueshield/turtleneck/skirt, // Blueshield leftover
		/obj/item/clothing/under/rank/nanotrasen_consultant, // NT Rep leftover
		/obj/item/clothing/under/rank/nanotrasen_consultant/skirt, // NT rep leftover
		/obj/item/clothing/under/rank/captain/skyrat/utility/syndicate, // Interdyne/DS-2 Leftover
		/obj/item/clothing/under/rank/captain/skyrat/pilot, // FUCKING SHIPSTATION LEFTOVER // also used on rimpoint and i'm biased so keep it :3
		/obj/item/clothing/under/rank/captain/skyrat/pilot/skirt, // shipstation leftover // uwa~ captain-chan.. dockside is superior, you're right~..
		/// I should be shot for the above comment, anyways engineering section
		/obj/item/clothing/under/rank/engineering/engineer/skyrat/utility/syndicate, // Interdyne/DS-2 Leftover
		/obj/item/clothing/under/rank/engineering/atmospheric_technician/skyrat/utility/advanced,
		/// Medical
		/obj/item/clothing/under/rank/medical/doctor/skyrat/utility/syndicate, // Interdyne/DS-2 Leftover
		/// Science
		/obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate, // You're not gonna beleive this, but what if I said Interdyne/DS-2 Leftover
		/obj/item/clothing/under/rank/security/skyrat/utility/redsec, // BlueSec remnant (we should nuke all bluesec remnants)
		/obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate, // Interdyne/DS-2 Leftover
		/obj/item/clothing/suit/toggle/jacket/supply/head, // Interdyne/DS-2 Leftover
		/obj/item/clothing/suit/toggle/jacket/sec/old, // BlueSec leftover
		/obj/item/clothing/accessory/badge,
		/obj/item/clothing/accessory/badge/old,
		/obj/item/clothing/accessory/badge/sheriff,
		/obj/item/clothing/accessory/badge/holo,
		/obj/item/clothing/accessory/badge/holo/cord,
		/obj/item/clothing/accessory/badge/holo/warden,
		/obj/item/clothing/accessory/badge/holo/hos,
		/obj/item/clothing/accessory/badge/holo/detective,
		/obj/item/clothing/under/misc/skyrat/utility/syndicate, // Interdyne/DS-2 Leftover
		/obj/item/clothing/suit/cowboyvest, // Why the fuck is this a dupe of the one the det gets
		/obj/item/clothing/under/rank/security/peacekeeper/sol/cadet,
		/obj/item/clothing/under/rank/security/head_of_security/peacekeeper/sol,
		/obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec, // BrigPhys leftover (Fuck SecMeds we a DOCTOR ASSIGNED TO THE BRIG house not a OFFICER WITH SURGICAL KNOWLEDGE house)
		/obj/item/clothing/under/syndicate/skyrat/baseball,
		/obj/item/clothing/under/syndicate/skyrat/tactical, // Interdyne/DS-2 Leftover (Technically used on a rimpoint ruin)
		/obj/item/clothing/under/syndicate/skyrat/tactical/skirt, // Ditto
		/obj/item/clothing/under/syndicate/skyrat/enclaveo, // Cringe
		/obj/item/clothing/under/syndicate/skyrat/enclaveo/real, // Cringe
		/obj/item/clothing/under/syndicate/skyrat/enclave/real, // Cringe
		/obj/item/towel, // Counting this as clothing
	)

/*
 *	LOADOUT ITEM DATUMS FOR THE HEAD SLOT
 */

/// Head Slot Items (Moves overrided items to backpack)
GLOBAL_LIST_INIT(loadout_helmets, generate_loadout_items(/datum/loadout_item/head))

/datum/loadout_item/head
	category = LOADOUT_ITEM_HEAD

/datum/loadout_item/head/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.head))
		.. ()
		return TRUE

/datum/loadout_item/head/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.head)
			LAZYADD(outfit.backpack_contents, outfit.head)
		outfit.head = item_path
	else
		outfit.head = item_path

/*
 *	HARDHATS
 */

/datum/loadout_item/head/dark_blue_hardhat
	name = "Dark Blue Hardhat"
	item_path = /obj/item/clothing/head/utility/hardhat/dblue

/datum/loadout_item/head/orange_hardhat
	name = "Orange Hardhat"
	item_path = /obj/item/clothing/head/utility/hardhat/orange

/datum/loadout_item/head/red_hardhat
	name = "Red Hardhat"
	item_path = /obj/item/clothing/head/utility/hardhat/red

/datum/loadout_item/head/white_hardhat
	name = "White Hardhat"
	item_path = /obj/item/clothing/head/utility/hardhat/white

/datum/loadout_item/head/yellow_hardhat
	name = "Yellow Hardhat"
	item_path = /obj/item/clothing/head/utility/hardhat

/*
 *	BEANIES
 */

/datum/loadout_item/head/white_beanie
	name = "Recolorable Beanie"
	item_path = /obj/item/clothing/head/beanie

/datum/loadout_item/head/black_beanie
	name = "Black Beanie"
	item_path = /obj/item/clothing/head/beanie/black

/datum/loadout_item/head/red_beanie
	name = "Red Beanie"
	item_path = /obj/item/clothing/head/beanie/red

/datum/loadout_item/head/dark_blue_beanie
	name = "Dark Blue Beanie"
	item_path = /obj/item/clothing/head/beanie/darkblue

/datum/loadout_item/head/yellow_beanie
	name = "Yellow Beanie"
	item_path = /obj/item/clothing/head/beanie/yellow

/datum/loadout_item/head/orange_beanie
	name = "Orange Beanie"
	item_path = /obj/item/clothing/head/beanie/orange

/datum/loadout_item/head/rastafarian
	name = "Rastafarian Beanie"
	item_path = /obj/item/clothing/head/rasta

/datum/loadout_item/head/christmas_beanie
	name = "Christmas Beanie"
	item_path = /obj/item/clothing/head/beanie/christmas

/*
 *	CAPS
 */

/datum/loadout_item/head/baseball
	name = "Baseball Cap"
	item_path = /obj/item/clothing/head/soft/mime

/datum/loadout_item/head/fashionable_cap
	name = "Fashionable Baseball Cap"
	item_path = /obj/item/clothing/head/soft/yankee

/datum/loadout_item/head/fashionable_cap
	name = "Fashionable Baseball Cap, Rimless" // cursed and i sob
	item_path = /obj/item/clothing/head/soft/yankee

/datum/loadout_item/head/black_cap
	name = "Black Cap"
	item_path = /obj/item/clothing/head/soft/black

/datum/loadout_item/head/blue_cap
	name = "Blue Cap"
	item_path = /obj/item/clothing/head/soft/blue

/datum/loadout_item/head/green_cap
	name = "Green Cap"
	item_path = /obj/item/clothing/head/soft/green

/datum/loadout_item/head/grey_cap
	name = "Grey Cap"
	item_path = /obj/item/clothing/head/soft/grey

/datum/loadout_item/head/orange_cap
	name = "Orange Cap"
	item_path = /obj/item/clothing/head/soft/orange

/datum/loadout_item/head/purple_cap
	name = "Purple Cap"
	item_path = /obj/item/clothing/head/soft/purple

/datum/loadout_item/head/red_cap
	name = "Red Cap"
	item_path = /obj/item/clothing/head/soft/red

/datum/loadout_item/head/grey_cap
	name = "Grey Cap"
	item_path = /obj/item/clothing/head/soft/grey

/datum/loadout_item/head/yellow_cap
	name = "Yellow Cap"
	item_path = /obj/item/clothing/head/soft/yellow

/datum/loadout_item/head/rainbow_cap
	name = "Rainbow Cap"
	item_path = /obj/item/clothing/head/soft/rainbow

/datum/loadout_item/head/flatcap
	name = "Flat Cap"
	item_path = /obj/item/clothing/head/flatcap

/datum/loadout_item/head/pflatcap
	name = "Recolorable Flat Cap"
	item_path = /obj/item/clothing/head/colourable_flatcap

/*
 *	TREK HATS
 */

/datum/loadout_item/head/trekcap
	name = "Officer's Cap (White)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL)

/datum/loadout_item/head/trekcapcap
	name = "Officer's Cap (Black)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap/black
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/head/trekcapmedisci
	name = "MedSci Officer's Cap (Blue)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap/medsci
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_CHEMIST, JOB_PSYCHOLOGIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/head/trekcapeng
	name = "Eng Officer's Cap (Yellow)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap/eng
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_STATION_ENGINEER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_BITRUNNER)

/datum/loadout_item/head/trekcapsec
	name = "Officer's Cap (Red)"
	item_path = /obj/item/clothing/head/hats/caphat/parade/fedcap/sec
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_STATION_ENGINEER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_BITRUNNER)

/datum/loadout_item/head/solofficercap
	name = "Security Officer's Sol Cap"
	item_path = /obj/item/clothing/head/hats/sec/peacekeeper/sol
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_WARDEN)

/datum/loadout_item/head/soltrafficoff
	name = "Traffic Officer Cap"
	item_path = /obj/item/clothing/head/hats/sec/peacekeeper/sol/traffic
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY, JOB_WARDEN)

/datum/loadout_item/head/mail_cap
	name = "Mail Cap"
	item_path = /obj/item/clothing/head/costume/mailman

/datum/loadout_item/head/domina_cap
	name = "Dominant Cap"
	item_path = /obj/item/clothing/head/domina_cap
	erp_item = TRUE

/*
 *	BERETS
 */

/datum/loadout_item/head/greyscale_beret
	name = "Greyscale Beret"
	item_path = /obj/item/clothing/head/beret

/datum/loadout_item/head/greyscale_beret/badge
	name = "Greyscale Beret with Badge"
	item_path = /obj/item/clothing/head/beret/badge

/datum/loadout_item/head/atmos_beret
	name = "Atmospherics Beret"
	item_path = /obj/item/clothing/head/beret/atmos
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)

/datum/loadout_item/head/engi_beret
	name = "Engineering Beret"
	item_path = /obj/item/clothing/head/beret/engi
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)

/datum/loadout_item/head/cargo_beret
	name = "Supply Beret"
	item_path = /obj/item/clothing/head/beret/cargo
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_BITRUNNER)

/datum/loadout_item/head/beret_med
	name = "Medical Beret"
	item_path = /obj/item/clothing/head/beret/medical
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_CHEMIST, JOB_CORONER)

/datum/loadout_item/head/beret_paramedic
	name = "Paramedic Beret"
	item_path = /obj/item/clothing/head/beret/medical/paramedic
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_PARAMEDIC)

/datum/loadout_item/head/beret_viro
	name = "Virology Beret"
	item_path = /obj/item/clothing/head/beret/medical/virologist
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_CHEMIST, JOB_CORONER)

/datum/loadout_item/head/beret_chem
	name = "Chemistry Beret"
	item_path = /obj/item/clothing/head/beret/medical/chemist
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_CHEMIST)

/datum/loadout_item/head/beret_sci
	name = "Science Beret"
	item_path = /obj/item/clothing/head/beret/science
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST)

/datum/loadout_item/head/beret_robo
	name = "Robotics Beret"
	item_path = /obj/item/clothing/head/beret/science/fancy/robo
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_ROBOTICIST)

/datum/loadout_item/head/beret_qm
	name = "Quartermaster Beret"
	item_path = /obj/item/clothing/head/beret/cargo/qm
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/head/beret_qm_alt
	name = "Quartermaster Beret, White"
	item_path = /obj/item/clothing/head/beret/cargo/qm/alt
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/head/navyblueofficerberet
	name = "Security Naval Beret"
	item_path = /obj/item/clothing/head/beret/sec/navyofficer
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN)

/datum/loadout_item/head/navybluewardenberet
	name = "Warden's Naval beret"
	item_path = /obj/item/clothing/head/beret/sec/navywarden
	restricted_roles = list(JOB_WARDEN)

/*
 *	FEDORAS
 */

/datum/loadout_item/head/black_fedora
	name = "Black Fedora"
	item_path = /obj/item/clothing/head/fedora/fedblack

/datum/loadout_item/head/beige_fedora
	name = "Beige Fedora"
	item_path = /obj/item/clothing/head/fedora/beige

/datum/loadout_item/head/white_fedora
	name = "White Fedora"
	item_path = /obj/item/clothing/head/fedora/white

/datum/loadout_item/head/brown_fedora
	name = "Brown Fedora"
	item_path = /obj/item/clothing/head/fedora/fedbrown

/*
 *	MISCELLANEOUS
 */

/datum/loadout_item/head/standalone_hood
	name = "Recolorable Standalone Hood"
	item_path = /obj/item/clothing/head/standalone_hood

/datum/loadout_item/head/bandana
	name = "Bandana"
	item_path = /obj/item/clothing/head/costume/pirate/bandana

/datum/loadout_item/head/top_hat
	name = "Top Hat"
	item_path = /obj/item/clothing/head/hats/tophat

/datum/loadout_item/head/bowler_hat
	name = "Bowler Hat"
	item_path = /obj/item/clothing/head/hats/bowler

/datum/loadout_item/head/nursehat
	name = "Nurse Hat"
	item_path = /obj/item/clothing/head/costume/nursehat
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_CHEMIST, JOB_CORONER)

/datum/loadout_item/head/cybergoggles	//Cyberpunk-P.I. Outfit
	name = "Type-34C Forensics Headwear"
	item_path = /obj/item/clothing/head/fedora/det_hat/cybergoggles
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/head/flowerpin
	name = "Flower Pin"
	item_path = /obj/item/clothing/head/costume/skyrat/flowerpin

/datum/loadout_item/head/rice_hat
	name = "Rice Hat"
	item_path = /obj/item/clothing/head/costume/rice_hat

/*
 *	COWBOY
 */

/datum/loadout_item/head/cowboyhat
	name = "Recolorable Cattleman Hat"
	item_path = /obj/item/clothing/head/cowboy/skyrat/cattleman

/datum/loadout_item/head/cowboyhat_black
	name = "Recolorable Wide-Brimmed Cattleman Hat"
	item_path = /obj/item/clothing/head/cowboy/skyrat/cattleman/wide

/datum/loadout_item/head/cowboyhat_wide
	name = "Wide-Brimmed Hat"
	item_path = /obj/item/clothing/head/cowboy/skyrat/wide

/datum/loadout_item/head/cowboyhat_wide_feather
	name = "Wide-Brimmed Feathered Hat"
	item_path = /obj/item/clothing/head/cowboy/skyrat/wide/feathered

/datum/loadout_item/head/cowboyhat_flat
	name = "Flat-Brimmed Hat"
	item_path = /obj/item/clothing/head/cowboy/skyrat/flat

/datum/loadout_item/head/cowboyhat_flat_cowl
	name = "Flat-Brimmed Hat with Cowl"
	item_path = /obj/item/clothing/head/cowboy/skyrat/flat/cowl

/datum/loadout_item/head/cowboyhat_sheriff
	name = "Sheriff Hat"
	item_path = /obj/item/clothing/head/cowboy/skyrat/flat/sheriff

/datum/loadout_item/head/cowboyhat_deputy
	name = "Deputy Hat"
	item_path = /obj/item/clothing/head/cowboy/skyrat/flat/deputy

/datum/loadout_item/head/cowboyhat_winter
	name = "Winter Cowboy Hat"
	item_path = /obj/item/clothing/head/cowboy/skyrat/flat/cowl/sheriff

/datum/loadout_item/head/cowboyhat_sec
	name = "Cattleman Hat, Security"
	item_path = /obj/item/clothing/head/cowboy/skyrat/cattleman/sec
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/head/cowboyhat_secwide
	name = "Wide-Brimmed Cattleman Hat, Security"
	item_path = /obj/item/clothing/head/cowboy/skyrat/cattleman/wide/sec
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY)

/*
 * USHANKAS & PAPAKHAS
 */

/datum/loadout_item/head/ushanka
	name = "Ushanka"
	item_path = /obj/item/clothing/head/costume/ushanka

/datum/loadout_item/head/ushanka/sec
	name = "Security Ushanka"
	item_path = /obj/item/clothing/head/costume/ushanka/sec
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/head/wrussian
	name = "Black Papakha"
	item_path = /obj/item/clothing/head/costume/skyrat/papakha

/datum/loadout_item/head/wrussianw
	name = "White Papakha"
	item_path = /obj/item/clothing/head/costume/skyrat/papakha/white

/*
 *	FAMILIES
 */

/datum/loadout_item/head/tmc
	name = "TMC Hat"
	item_path = /obj/item/clothing/head/costume/tmc

/datum/loadout_item/head/deckers
	name = "Decker's Hat"
	item_path = /obj/item/clothing/head/costume/deckers

/datum/loadout_item/head/saints
	name = "Fancy Hat"
	item_path = /obj/item/clothing/head/costume/fancy

/*
 *	CHRISTMAS
 */

/datum/loadout_item/head/santa
	name = "Santa Hat"
	item_path = /obj/item/clothing/head/costume/santa
	required_season = CHRISTMAS

/datum/loadout_item/head/christmas
	name = "Red Christmas Hat"
	item_path = /obj/item/clothing/head/costume/skyrat/christmas
	required_season = CHRISTMAS

/datum/loadout_item/head/christmas/green
	name = "Green Christmas Hat"
	item_path = /obj/item/clothing/head/costume/skyrat/christmas/green
	required_season = CHRISTMAS

/*
 *	HALLOWEEN
 */

/datum/loadout_item/head/pirate
	name = "Pirate hat"
	item_path = /obj/item/clothing/head/costume/pirate

/datum/loadout_item/head/kitty_ears
	name = "Kitty Ears"
	item_path = /obj/item/clothing/head/costume/kitty

/datum/loadout_item/head/rabbit_ears
	name = "Rabbit Ears"
	item_path = /obj/item/clothing/head/costume/rabbitears

/datum/loadout_item/head/bearpelt
	name = "Brown Bear Pelt"
	item_path = /obj/item/clothing/head/pelt

/datum/loadout_item/head/bearpeltblack
	name = "Black Bear Pelt"
	item_path = /obj/item/clothing/head/pelt/black

/datum/loadout_item/head/bearpeltwhite
	name = "White Bear Pelt"
	item_path = /obj/item/clothing/head/pelt/white

/datum/loadout_item/head/wolfpelt
	name = "Brown Wolf Pelt"
	item_path = /obj/item/clothing/head/pelt/wolf

/datum/loadout_item/head/wolfpeltblack
	name = "Black Wolf Pelt"
	item_path = /obj/item/clothing/head/pelt/wolf/black

/datum/loadout_item/head/wolfpeltwhite
	name = "White Wolf Pelt"
	item_path = /obj/item/clothing/head/pelt/wolf/white

/datum/loadout_item/head/tigerpelt
	name = "Shiny Tiger Pelt"
	item_path = /obj/item/clothing/head/pelt/tiger

/datum/loadout_item/head/tigerpeltsnow
	name = "Snow Tiger Pelt"
	item_path = /obj/item/clothing/head/pelt/snow_tiger

/datum/loadout_item/head/tigerpeltpink
	name = "Pink Tiger Pelt"
	item_path = /obj/item/clothing/head/pelt/pink_tiger

/datum/loadout_item/head/maid_headband
	name = "Recolorable Maid Headband"
	item_path = /obj/item/clothing/head/maid_headband

/datum/loadout_item/head/maidhead
	name = "Simple Maid Headband"
	item_path = /obj/item/clothing/head/costume/skyrat/maid
	additional_tooltip_contents = list("Small headband that only fits on top the head.")

/datum/loadout_item/head/maidhead2
	name = "Frilly Maid Headband"
	item_path = /obj/item/clothing/head/costume/maidheadband
	additional_tooltip_contents = list("Larger headband from the maid rework. Fits around head and ears.")

/datum/loadout_item/head/wig
	name = "Wig"
	item_path = /obj/item/clothing/head/wig

/datum/loadout_item/head/wignatural
	name = "Natural Wig"
	item_path = /obj/item/clothing/head/wig/natural

/datum/loadout_item/head/blastwave_helmet
	name = "Blastwave Plastic Helmet"
	item_path = /obj/item/clothing/head/blastwave

/datum/loadout_item/head/blastwave_cap
	name = "Blastwave Peaked Cap"
	item_path = /obj/item/clothing/head/blastwave/officer

/datum/loadout_item/head/delinquent_cap
	name = "Delinquent Cap"
	item_path = /obj/item/clothing/head/costume/delinquent

/datum/loadout_item/head/slime
	name = "Slime Hat"
	item_path = /obj/item/clothing/head/collectable/slime

/datum/loadout_item/head/glatiator
	name = "Gladiator Helmet"
	item_path = /obj/item/clothing/head/helmet/gladiator

/datum/loadout_item/head/griffin
	name = "Griffon Head"
	item_path = /obj/item/clothing/head/costume/griffin

/datum/loadout_item/head/wedding_veil
	name = "Wedding Veil"
	item_path = /obj/item/clothing/head/costume/weddingveil

/datum/loadout_item/head/flakhelm
	name = "Flak Helmet"
	item_path = /obj/item/clothing/head/hats/flakhelm

/datum/loadout_item/head/synde
	name = "Replica Black Space-Helmet"
	item_path = /obj/item/clothing/head/syndicatefake

/datum/loadout_item/head/plague_doctor
	name = "Plague Doctor Costume Head"
	item_path = /obj/item/clothing/head/bio_hood/plague

/datum/loadout_item/head/snowman
	name = "Snowman Costume Head"
	item_path = /obj/item/clothing/head/costume/snowman

/datum/loadout_item/head/chicken
	name = "Chicken Costume Head"
	item_path = /obj/item/clothing/head/costume/chicken

/datum/loadout_item/head/en
	name = "Cybernetic Dog Costume Head"
	item_path = /obj/item/clothing/head/costume/skyrat/en

/datum/loadout_item/head/cardborg
	name = "Cardborg Costume Head"
	item_path = /obj/item/clothing/head/costume/cardborg

/datum/loadout_item/head/xenos
	name = "Xenos Helmet"
	item_path = /obj/item/clothing/head/costume/xenos

/datum/loadout_item/head/wizard
	name = "Wizard Hat"
	item_path = /obj/item/clothing/head/wizard/fake

/datum/loadout_item/head/witch
	name = "Witch Hat"
	item_path = /obj/item/clothing/head/wizard/marisa/fake

//STAR WARS Galactic Empire

/datum/loadout_item/head/imperial_cap
	name = "Captain's Naval Cap"
	item_path = /obj/item/clothing/head/hats/imperial/cap
	restricted_roles = list(JOB_CAPTAIN)

/datum/loadout_item/head/imperial_hop
	name = "Head of Personnel's Naval Cap"
	item_path = /obj/item/clothing/head/hats/imperial/hop
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL)

/datum/loadout_item/head/imperial_cmo
	name = "Chief Medical Officer's Naval Cap"
	item_path = /obj/item/clothing/head/hats/imperial/cmo
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/head/imperial_ce
	name = "Chief Engineer's blast helmet."
	item_path = /obj/item/clothing/head/hats/imperial/ce
	restricted_roles = list(JOB_CHIEF_ENGINEER)

/datum/loadout_item/head/imperial_generic
	name = "Grey Naval Officer Cap"
	item_path = /obj/item/clothing/head/hats/imperial
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER)

/datum/loadout_item/head/imperial_grey
	name = "Dark Grey Naval Officer Cap"
	item_path = /obj/item/clothing/head/hats/imperial/grey
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER)

/datum/loadout_item/head/imperial_red
	name = "Red Naval Officer Cap"
	item_path = /obj/item/clothing/head/hats/imperial/red
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER)

/datum/loadout_item/head/imperial_white
	name = "White Naval Officer Cap"
	item_path = /obj/item/clothing/head/hats/imperial/white
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER)

/datum/loadout_item/head/blasthelmet
	name = "General's Helmet"
	item_path = /obj/item/clothing/head/hats/imperial/helmet
	restricted_roles = list(JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_OFFICER, JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER)

/datum/loadout_item/head/navybluehoscap
	name = "Head of Security's Naval Cap"
	item_path = /obj/item/clothing/head/hats/imperial/hos
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

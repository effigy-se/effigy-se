GLOBAL_LIST_INIT(loadout_toys, generate_loadout_items(/datum/loadout_item/toys))

/datum/loadout_item/toys
	category = LOADOUT_ITEM_TOYS

/*
*	PLUSHIES
*/

/datum/loadout_item/toys/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)  // these go in the backpack
	return FALSE

/datum/loadout_item/toys/bee
	name = "Bee Plushie"
	item_path = /obj/item/toy/plush/beeplushie

/datum/loadout_item/toys/carp
	name = "Carp Plushie"
	item_path = /obj/item/toy/plush/carpplushie

/datum/loadout_item/toys/shark
	name = "Shark Plushie"
	item_path = /obj/item/toy/plush/shark

/datum/loadout_item/toys/lizard_greyscale
	name = "Greyscale Lizard Plushie"
	item_path = /obj/item/toy/plush/lizard_plushie

/datum/loadout_item/toys/moth
	name = "Moth Plushie"
	item_path = /obj/item/toy/plush/moth

/datum/loadout_item/toys/narsie
	name = "Nar'sie Plushie"
	item_path = /obj/item/toy/plush/narplush
	restricted_roles = list(JOB_CHAPLAIN)

/datum/loadout_item/toys/nukie
	name = "Nukie Plushie"
	item_path = /obj/item/toy/plush/nukeplushie

/datum/loadout_item/toys/peacekeeper
	name = "Peacekeeper Plushie"
	item_path = /obj/item/toy/plush/pkplush

/datum/loadout_item/toys/plasmaman
	name = "Plasmaman Plushie"
	item_path = /obj/item/toy/plush/plasmamanplushie

/datum/loadout_item/toys/ratvar
	name = "Ratvar Plushie"
	item_path = /obj/item/toy/plush/ratplush
	restricted_roles = list(JOB_CHAPLAIN)

/datum/loadout_item/toys/rouny
	name = "Rouny Plushie"
	item_path = /obj/item/toy/plush/rouny

/datum/loadout_item/toys/snake
	name = "Snake Plushie"
	item_path = /obj/item/toy/plush/snakeplushie

/datum/loadout_item/toys/slime
	name = "Slime Plushie"
	item_path = /obj/item/toy/plush/slimeplushie

/datum/loadout_item/toys/bubble
	name = "Bubblegum Plushie"
	item_path = /obj/item/toy/plush/bubbleplush

/datum/loadout_item/toys/goat
	name = "Strange Goat Plushie"
	item_path = /obj/item/toy/plush/goatplushie

/datum/loadout_item/toys/borbplushie
	name = "Borb Plushie"
	item_path = /obj/item/toy/plush/effigy/borbplushie

/datum/loadout_item/toys/blue_cat
	name = "Blue Cat Plushie"
	item_path = /obj/item/toy/plush/effigy/blue_cat

/datum/loadout_item/toys/igneous_synth
	name = "Igneous Synth Plushie"
	item_path = /obj/item/toy/plush/effigy/igneous_synth

/datum/loadout_item/toys/courier_synth
	name = "Courier Synth Plushie"
	item_path = /obj/item/toy/plush/effigy/courier_synth

/datum/loadout_item/toys/edgy_bird
	name = "Edgy Bird Plushie"
	item_path = /obj/item/toy/plush/effigy/edgy_bird

/datum/loadout_item/toys/tree_ferret
	name = "Tree Ferret Plushie"
	item_path = /obj/item/toy/plush/effigy/tree_ferret

/datum/loadout_item/toys/mechanic_fox
	name = "Mechanist Fox Plushie"
	item_path = /obj/item/toy/plush/effigy/mechanic_fox

/datum/loadout_item/toys/tribal_salamander
	name = "Tribal Salamander Plushie"
	item_path = /obj/item/toy/plush/effigy/tribal_salamander

/datum/loadout_item/toys/ianbastardman
	name = "Ian Plushie"
	item_path = /obj/item/toy/plush/effigy/ian

/datum/loadout_item/toys/corgiman
	name = "Corgi Plushie"
	item_path = /obj/item/toy/plush/effigy/ian/small

/datum/loadout_item/toys/corgiwoman
	name = "Girly Corgi Plushie"
	item_path = /obj/item/toy/plush/effigy/ian/lisa

/datum/loadout_item/toys/commanding_teshari
	name = "Commanding Teshari Plushy"
	item_path = /obj/item/toy/plush/effigy/commanding_teshari

/datum/loadout_item/toys/breakdancing_bird
	name = "Breakdancing Bird Plushie"
	item_path = /obj/item/toy/plush/effigy/breakdancing_bird

/datum/loadout_item/toys/skreking_vox
	name = "Skreking Vox Plushie"
	item_path = /obj/item/toy/plush/effigy/skreking_vox

/datum/loadout_item/toys/blue_dog
	name = "Blue Dog Plushie"
	item_path = /obj/item/toy/plush/effigy/blue_dog

/datum/loadout_item/toys/engi_snek
	name = "Engineering Snek Plushie"
	item_path = /obj/item/toy/plush/effigy/engi_snek

/datum/loadout_item/toys/glitch_synth
	name = "Glitching Synthetic Plushie"
	item_path = /obj/item/toy/plush/effigy/glitch_synth

/datum/loadout_item/toys/boom_bird
	name = "Boom Bird Plushie"
	item_path = /obj/item/toy/plush/effigy/boom_bird

/datum/loadout_item/toys/jecca
	name = "Sexy Snoodle Plushie"
	item_path = /obj/item/toy/plush/effigy/jecca

/*
*	CARDS
*/

/datum/loadout_item/toys/card_binder
	name = "Card Binder"
	item_path = /obj/item/storage/card_binder

/datum/loadout_item/toys/card_deck
	name = "Playing Card Deck"
	item_path = /obj/item/toy/cards/deck

/datum/loadout_item/toys/kotahi_deck
	name = "Kotahi Deck"
	item_path = /obj/item/toy/cards/deck/kotahi

/datum/loadout_item/toys/wizoff_deck
	name = "Wizoff Deck"
	item_path = /obj/item/toy/cards/deck/wizoff

/datum/loadout_item/toys/tarot
	name = "Tarot Card Deck"
	item_path = /obj/item/toy/cards/deck/tarot

/*
*	DICE
*/

/datum/loadout_item/toys/d1
	name = "D1"
	item_path = /obj/item/dice/d1

/datum/loadout_item/toys/d2
	name = "D2"
	item_path = /obj/item/dice/d2

/datum/loadout_item/toys/d4
	name = "D4"
	item_path = /obj/item/dice/d4

/datum/loadout_item/toys/d6
	name = "D6"
	item_path = /obj/item/dice/d6

/datum/loadout_item/toys/d6_ebony
	name = "D6 (Ebony)"
	item_path = /obj/item/dice/d6/ebony

/datum/loadout_item/toys/d6_space
	name = "D6 (Space)"
	item_path = /obj/item/dice/d6/space

/datum/loadout_item/toys/d8
	name = "D8"
	item_path = /obj/item/dice/d8

/datum/loadout_item/toys/d10
	name = "D10"
	item_path = /obj/item/dice/d10

/datum/loadout_item/toys/d12
	name = "D12"
	item_path = /obj/item/dice/d12

/datum/loadout_item/toys/d20
	name = "D20"
	item_path = /obj/item/dice/d20

/datum/loadout_item/toys/d20/nat1
	name = "D20 (weighted on 1)"
	item_path = /obj/item/dice/d20/nat1

/datum/loadout_item/toys/d100
	name = "D100"
	item_path = /obj/item/dice/d100

/datum/loadout_item/toys/d00
	name = "D00"
	item_path = /obj/item/dice/d00

/datum/loadout_item/toys/dice
	name = "Dice Bag"
	item_path = /obj/item/storage/dice

/*
*	TENNIS BALLS
*/

/datum/loadout_item/toys/tennis
	name = "Tennis Ball (Classic)"
	item_path = /obj/item/toy/tennis

/datum/loadout_item/toys/tennisred
	name = "Tennis Ball (Red)"
	item_path = /obj/item/toy/tennis/red

/datum/loadout_item/toys/tennisyellow
	name = "Tennis Ball (Yellow)"
	item_path = /obj/item/toy/tennis/yellow

/datum/loadout_item/toys/tennisgreen
	name = "Tennis Ball (Green)"
	item_path = /obj/item/toy/tennis/green

/datum/loadout_item/toys/tenniscyan
	name = "Tennis Ball (Cyan)"
	item_path = /obj/item/toy/tennis/cyan

/datum/loadout_item/toys/tennisblue
	name = "Tennis Ball (Blue)"
	item_path = /obj/item/toy/tennis/blue

/datum/loadout_item/toys/tennispurple
	name = "Tennis Ball (Purple)"
	item_path = /obj/item/toy/tennis/purple

/*
*	MISC
*/

/datum/loadout_item/toys/cat_toy
	name = "Cat Toy"
	item_path = /obj/item/toy/cattoy

/datum/loadout_item/toys/crayons
	name = "Box of Crayons"
	item_path = /obj/item/storage/crayons

/datum/loadout_item/toys/eightball
	name = "Magic Eightball"
	item_path = /obj/item/toy/eightball

/datum/loadout_item/toys/toykatana
	name = "Toy Katana"
	item_path = /obj/item/toy/katana

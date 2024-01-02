// Because plushes have a second desc var that needs to be updated
/obj/item/toy/plush/on_loadout_custom_described()
	normal_desc = desc

/obj/item/toy/plush/effigy
	icon = 'local/icons/obj/toys/plushes.dmi'
	inhand_icon_state = null

/obj/item/toy/plush/effigy/borbplushie
	name = "borb plushie"
	desc = "An adorable stuffed toy that resembles a round, fluffy looking bird. Not to be mistaken for his friend, the birb plushie."
	icon_state = "plushie_borb"
	attack_verb_continuous = list("pecks", "peeps")
	attack_verb_simple = list("peck", "peep")
	squeak_override = list('local/sound/emotes/voice/peep_once.ogg' = 1)

/obj/item/toy/plush/effigy/ian
	name = "plush corgi"
	desc = "A plushie of an adorable corgi! Don't you just want to hug it and squeeze it and call it \"Ian\"?"
	icon_state = "ianplushie"
	attack_verb_continuous = list("barks", "woofs", "wags his tail at")
	attack_verb_simple = list("lick", "nuzzle", "bite")
	squeak_override = list('local/sound/emotes/voice/bark2.ogg' = 1)
	young = TRUE //No.

/obj/item/toy/plush/effigy/ian/small
	name = "small plush corgi"
	desc = "A plushie of an adorable corgi! Don't you just want to hug it and squeeze it and call it \"Ian\"?"
	icon_state = "corgi"

/obj/item/toy/plush/effigy/ian/lisa
	name = "plush girly corgi"
	desc = "A plushie of an adorable corgi! Don't you just want to hug it and squeeze it and call it \"Lisa\"?"
	icon_state = "girlycorgi"
	attack_verb_continuous = list("barks", "woofs", "wags her tail at")
	gender = FEMALE

/obj/item/toy/plush/effigy/mechanic_fox
	name = "mechanist fox plushie"
	desc = "A fox with fabulous hair! It has a tendency to make synth plushies look good as new when placed next to them."
	icon_state = "plushie_cali"
	attack_verb_continuous = list("fixes", "updates", "hugs")
	attack_verb_simple = list("fix", "update", "hug")
	squeak_override = list('local/sound/items/plushes/deerplush.ogg' = 1)

/obj/item/toy/plush/effigy/blue_cat
	name = "blue cat plushie"
	desc = "A bright blue feline plush with neon pink hair, here to hand out kisses wherever kisses need be. Usually found near its home habitat, the tram."
	icon_state = "plushie_skyy"
	attack_verb_continuous = list("kisses", "nuzzles", "cuddles", "purrs against")
	attack_verb_simple = list("kiss", "nuzzle", "cuddle", "purr against")
	squeak_override = list('local/sound/emotes/voice/nya.ogg' = 1)

/obj/item/toy/plush/effigy/igneous_synth
	name = "igneous synth plushie"
	desc = "Not actually made of igneous rock, giving this plush a hug will let you feel like you're being squeezed by the jaws of life!"
	icon_state = "plushie_granite"
	attack_verb_continuous = list("bleps", "SQUEEZES", "pies")
	attack_verb_simple = list("blep", "SQUEEZE", "pie")
	squeak_override = list('local/sound/emotes/generic/twobeep.ogg' = 1)

/obj/item/toy/plush/effigy/edgy_bird
	name = "edgy birb plushie"
	desc = "An edgy plush of an edgy bird. You could swear it's teleporting to a different spot every time you look away..."
	icon_state = "plushie_koto"
	attack_verb_continuous = list("pecks", "teleports behind", "caws at")
	attack_verb_simple = list("peck", "teleport behind", "caw at")
	squeak_override = list('local/sound/emotes/voice/caw.ogg' = 1)

/obj/item/toy/plush/effigy/tree_ferret
	name = "tree ferret plushy"
	desc = "This plush will always put on a smile to make your day as bright as the sun. Hugging him makes you feel warm and fuzzy. Comes with plush chemical vials to fix your non emotional traumas too!"
	icon_state = "plushie_sels"
	attack_verb_continuous = list("hugs", "cackles at", "health analyzes")
	attack_verb_simple = list("hug", "cackle at", "health analyze")
	squeak_override = list('sound/effects/crunchybushwhack1.ogg' = 1)

// Donation reward for shyshadow
/obj/item/toy/plush/effigy/plushie_winrow
	name = "dark and brooding lizard plush"
	desc = "An almost intimidating black lizard plush, this one's got a little beret to come with it! Best not to separate the two. Its eyes shine with suggestion, no maidens?"
	icon_state = "plushie_shyshadow"

/obj/item/toy/plush/effigy/tribal_salamander
	name = "tribal salamander plushie"
	desc = "A water-safe plushie that always seems to lose any clothes you try to put on it."
	icon_state = "plushie_azu"
	attack_verb_continuous = list("wurbles at", "warbles at")
	attack_verb_simple = list("wurbles at", "warbles at")
	squeak_override = list('local/sound/emotes/voice/wurble.ogg' = 1)

/obj/item/toy/plush/effigy/commanding_teshari
	name = "commanding teshari plushy"
	desc = "A very soft plush resembling a certain science-loving, command inclined Teshari. Just holding it makes you feel cared for."
	icon_state = "plushie_alara"
	attack_verb_continuous = list("peeps", "wurbles", "hugs")
	attack_verb_simple = list("peeps", "wurbles", "hugs")
	squeak_override = list('local/sound/emotes/voice/peep_once.ogg' = 1)

/obj/item/toy/plush/effigy/breakdancing_bird
	name = "breakdancing bird plushie"
	desc = "This little robotic bird plushie loves to give you a little dance in celebration of your achievements, no matter how mundane."
	icon_state = "plushie_cadicus"
	attack_verb_continuous = list("boops", "dances next to")
	attack_verb_simple = list("boop", "dance next to")
	squeak_override = list('sound/machines/ping.ogg' = 1)

/obj/item/toy/plush/effigy/skreking_vox
	name = "skreking vox plushie"
	desc = "A vox plushie that seems ready to pull a gun on you and demand your money! Rumor has it that if you poke it in a particular way, it will show you its skrektual technique."
	icon_state = "plushie_toko"
	attack_verb_continuous = list("rustles at", "threatens", "skreks at")
	attack_verb_simple = list("rustle at", "threaten", "skrek at")
	squeak_override = list('local/sound/emotes/generic/voxrustle.ogg' = 1)

/obj/item/toy/plush/effigy/blue_dog
	name = "blue dog plushie"
	desc = "A devious looking husky that seems to be begging for headpats. It smells faintly of blueberries."
	icon_state = "plushie_cobalt"
	attack_verb_continuous = list("barks at", "borks at", "woofs at")
	attack_verb_simple = list("bark at", "bork at", "woof at")
	squeak_override = list('local/sound/emotes/voice/bark1.ogg'=1, 'local/sound/emotes/voice/bark2.ogg'=1)

/obj/item/toy/plush/effigy/engi_snek
	name = "engineering snek plushie"
	desc = "This plush looks like it knows the difference between pumps and pipes! The arm is detachable, so don't lose it!"
	icon_state = "plushie_tyri"
	attack_verb_continuous = list("fixes", "unbolts", "welds")
	attack_verb_simple = list("fix", "unbolt", "weld")
	squeak_override = list('sound/items/screwdriver.ogg' = 1, 'sound/items/drill_use.ogg' = 1, 'sound/items/welder.ogg' = 1)

/obj/item/toy/plush/effigy/glitch_synth
	name = "glitching synthetic plushie"
	desc = "A synthetic plush, the interface seems to glitch out every time you give it a hug or call it cute!"
	icon_state = "plushie_rex"
	attack_verb_continuous = list("beeps", "hugs", "health analyzes")
	attack_verb_simple = list("beep", "hug", "health analyze")
	squeak_override = list('sound/machines/twobeep_high.ogg' = 1)

/obj/item/toy/plush/effigy/boom_bird
	name = "boom bird plushie"
	desc = "This little bird plushie may look like a nerd, but you have the sneaking suspicion it might be valid! Why does your skin start to glow when you hug it?"
	icon_state = "plushie_dima"
	attack_verb_continuous = list("punches", "explodes on", "peeps")
	attack_verb_simple = list("punch", "explode on", "peep")
	squeak_override = list('sound/machines/sm/accent/delam/1.ogg' = 1)

//Donation reward for October23
/obj/item/toy/plush/effigy/plushie_elofy
	name = "bumbling wolfgirl plushie"
	desc = "A white-haired wolfgirl in a stylish red security skirt. Despite her scary cybernetic arm, she is soft to hug and only wishes to be praised and comforted."
	icon_state = "plush_lonie"
	attack_verb_continuous = list("snuggles", "nibbles", "awoos", "tail whaps")
	attack_verb_simple = list("snuggle", "nibble", "awoo", "tail whap")
	squeak_override = list('local/sound/items/plushes/merowr.ogg' = 1)

//Donation reward for Kitsun
/obj/item/toy/plush/effigy/jecca
	name = "sexy snoodle plushie"
	desc = "For some reason, this plushie is rather shiny, with glistening, glittering scales, and its ruby colored eyes seem to be rather enticing and full of mischievous, lewd thoughts behind them."
	icon_state = "plushie_jecca"
	attack_verb_continuous = list("sighs")
	attack_verb_simple = list("sigh")
	squeak_override = list('local/sound/emotes/generic/female/female_sigh.ogg' = 1)
	gender = FEMALE

//Donation reward for BriareosBlue
/obj/item/toy/plush/effigy/courier_synth
	name = "courier synth plushie"
	desc = "This synth plushie looks about ready to deliver hugs and beeps straight to the heart! The tag seems to have an advertisement for a delivery company on it..."
	icon_state = "plushie_courier"
	attack_verb_continuous = list("delivers", "export scans", "dwoops", "bwuhs", "stamps")
	attack_verb_simple = list("deliver", "export scan", "dwoop", "bwuh", "stamp")
	squeak_override = list('local/sound/emotes/generic/twobeep.ogg' = 1)

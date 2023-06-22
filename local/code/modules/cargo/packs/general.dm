/datum/supply_pack/misc/painting
	name = "Advanced Art Supplies"
	desc = "Bring out your artistic spirit with these advanced art supplies. Contains coloring supplies, cloth for canvas, and two easels to work with!"
	cost = CARGO_CRATE_VALUE * 2.2
	contains = list(
		/obj/structure/easel,
		/obj/structure/easel,
		/obj/item/toy/crayon/spraycan,
		/obj/item/toy/crayon/spraycan,
		/obj/item/storage/crayons,
		/obj/item/storage/crayons,
		/obj/item/toy/crayon/white,
		/obj/item/toy/crayon/white,
		/obj/item/toy/crayon/rainbow,
		/obj/item/toy/crayon/rainbow,
		/obj/item/stack/sheet/cloth/ten,
		/obj/item/stack/sheet/cloth/ten,
	)
	crate_name = "advanced art supplies"

/datum/supply_pack/misc/coloredsheets
	name = "Bedsheet Crate"
	desc = "Give your night life a splash of color with this crate filled with bedsheets! Contains a total of nine different-colored sheets."
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(
		/obj/item/bedsheet/blue,
		/obj/item/bedsheet/green,
		/obj/item/bedsheet/orange,
		/obj/item/bedsheet/purple,
		/obj/item/bedsheet/red,
		/obj/item/bedsheet/yellow,
		/obj/item/bedsheet/brown,
		/obj/item/bedsheet/black,
		/obj/item/bedsheet/rainbow,
	)
	crate_name = "colored bedsheet crate"

/datum/supply_pack/misc/candles
	name = "Candle Crate"
	desc = "Set up a romantic dinner or host a séance with these extra candles and crayons."
	cost = CARGO_CRATE_VALUE * 1.5
	contains = list(
		/obj/item/storage/fancy/candle_box,
		/obj/item/storage/fancy/candle_box,
		/obj/item/storage/box/matches,
	)
	crate_name = "candle crate"

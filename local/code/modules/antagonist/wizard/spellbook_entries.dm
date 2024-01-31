// Laughter Demon. They're basically hugboxed slaughter demons (hence the name), but are still really powerful.
// While you're basically put in gay baby jail until it's killed, it's not TOO bad, but it should still be limited to 1.
/datum/spellbook_entry/item/hugbottle
	cost = 2
	limit = 1

// Blood in a Bottle: Spawns a Slaughter Demon. Players consumed are effectively round removed until the slaughter demon dies.
// 99% of slaughter demons just target medbay and it's not really fun for anyone except the slaughter demon (and ghost chat).
/datum/spellbook_entry/item/bloodbottle
	category = null

// Summoned Soulstones. Disabled because it was effectively round removing people. Just use the necromatic stone instead!
/datum/spellbook_entry/item/soulstones
	category = null

// Curse of Madness. Gave everyone a lobotomy tier trauma that could basically fuck over your round for no reason.
// Good for /tg/ wizard rounds that last 10 minutes, not so good for Bubberstation rounds that last 2 hours.
/datum/spellbook_entry/summon/curse_of_madness
	category = null

// Staff of Change: It's all fun and games until someone is transformed into something butcherable and someone "accidentally" butchers someone.
// Very easy way to get round removed, and a very easy way to grief the crew as you are now a funny xenomorph that can lay eggs.
/datum/spellbook_entry/item/staffchange
	category = null

// High Frequency Spellblade. Holy fuck just looking at the code is nonsense holy fuck. Can slash through walls, and also gib people who are dead. Absolutely silly.
// Replaces it with a banhammer that can send you to the perma brig because that's funnier.
/datum/spellbook_entry/item/highfrequencyblade
	name = "REAL Banhammer"
	desc = "A completely REAL Banhammer that sends anyone it hits to the void for a short period of time. Stonger hits send people to the station's permabrig, if one exists."
	item_path = /obj/item/banhammer/real
	category = "Offensive"
	cost = 2

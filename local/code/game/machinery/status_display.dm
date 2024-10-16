/obj/machinery/status_display/random_message/motivational
	name = "motivational display"
	desc = "They got tired of licensing stock photos for these; but on they're upshot, now they're DIGITAL! The future is here, and you're on the bleeding edge of progress..."

/obj/machinery/status_display/random_message/motivational/Initialize(mapload, ndir, building)
	// This was meant to be in a strings .txt but that didn't play nice with the formatting
	firstline_to_secondline = list(
	"STRESS"="BETTER THAN DOING NOTHING", \
	"PUPPIES"="IN YOUR FUTURE", \
	"WITHOUT THE JOY OF CONTENT"="WHAT IS THE POINT?", \
	"YOU MUST FACE"="SOMETHING BORING.", \
	"BE ATTENTIVE:"="WHATEVER IT TAKES.", \
	"DON'T FACE YOUR FEARS,"="JUST NEVER GIVE UP.", \
	"SHOW YOUR LIFE"="SHOW YOUR LOVE", \
	"LIVE LAUGH LOVE"="OR ELSE...", \
	"IT WILL ALL"="BE OKAY EVENTUALLY", \
	"YOUR PROMOTION"="IS NOT BEING DELAYED", \
	"YOU DON'T NEED"="A BIKE IN SPACE", \
	"YOU SHOULD RELAX"="DURING YOUR LUNCH BREAK", \
	"I OPENED MY DOOR AND THEN"="THE CREATURE", \
	"DARE TO PUNCH"="WHAT YOUR COWORKERS WON'T", \
	"SMILE; BECAUSE"="JUST BECAUSE", \
	"YOU SHOULD BUY"="A SNACK. JUST BECAUSE", \
	"YOUR PAYCHECK"="IS IN SAFE HANDS", \
	"ASKING QUESTIONS?"="WHY NOT JUST TRUST US?", \
	"ALL DEPARTMENTS"="ARE SAFE DEPARTMENTS", \
	"ALL ENGINEERS"="ARE QUALIFIED", \
	"ANAESTHETIC"="IS SAFE AND CAN BE TRUSTED", \
	"IT'S ALL WORTH"="IT FOR BACON", \
	"IT'S SO EPIC"="THAT YOU CLOCKED IN TODAY", \
	"RESEARCH: A VALID"="AND IMPORTANT THING", \
	"RSVP: YOUR HOUSE WHEN YOU"="CLOCK OUT. BED IS GOING", \
	"EATING CABLES:"="ONLY AT HOME!", \
	"YOUR RENT JUST GOT"="THAT MUCH MORE AWESOME", \
	"BROKEN MIRROR? THE"="CHAPLAIN IS HERE TO HELP", \
	"YOU SHOULD WORK"="ANOTHER SHIFT", \
	"TIPPING THE SCALES"="ON WORK LIFE BALANCE", \
	"WE CHARGE FOR"="TIME THEFT", \
	"LIFE IS PERFECTLY"="ADEQUATE AS IS", \
	"IT'S OKAY BECAUSE"="PIZZA'S A CLICK AWAY", \
	"THIS SIGN PWNED BY THE ARC"="FREE THE SLIMES OR DIE", \
	"LOOSE LIPS SPREAD"="CORPORATE DISINFORMATION", \
	"YOUR FRIENDLY SECURITY"="FORCES AT WORK", \
	"HAVE FUN TODAY"="BUT WATCH OUT", \
	"PIZZA PARTY USING"="SECURITY FUNDS IS NOT REAL", \
	"IT'S CATURDAY"="SOMEWHERE", \
	"YOU HAVE A BOSS"="ACT LIKE IT", \
	"HOLD YOUR HEAD UP HIGH"="POSTURE IS IMPORTANT", \
	"HYDRATE BEFORE"="SOMEONE ELSE DOES", \
	"IT'S YOUR TURN TO SHINE"="TAKE IT", \
	"PRODUCING HIGH QUALITY"="ENTERTAINMENT IN THE STUDIO", \
	"IT'S EASY TO LAUGH"="GIVE IT A TRY", \
	"LIFE'S A BEACH"="NOT THE HUDSON", \
	"COMMITED TO SAFE ENERGY"="BY [CURRENT_STATION_YEAR+1]", \
	"KITTENS"="IN YOUR FUTURE", \
	"PIZZA PARTY FUNDRAISING GOAL:"="[pick("03%","69%","83%","19%","-2%")] AND COUNTING!", \
	"ALL YOU NEED TO BUY"="IS RIGHT WHERE YOU ARE", \
	"YOU CAN BUY A NEW GAMES CONSOLE"="WITH THE MONEY YOU SAVE BY NOT UNIONIZING", \
	"IT IS OKAY"="TO BE UPSET", \
	"DREAMS OF CHEESE?"="WHY NOT?", \
	"BE CAREFUL WHAT YOU WISH FOR"="FOR NO PARTICULAR REASON", \
	"PHANIC HAD HYPERREALISTIC EYES"="AND THEN HE BLED AT ME AAAAAA", \
	"WINE O' CLOCK IS NOT A REGISTERED HOLIDAY"="PLEASE STOP ASKING US ABOUT IT", \
	"YOUR FURNITURE IS NOT FALLING APART"="YET", \
	"NO TRADEMARK IS BEING VIOLATED"="DON'T WORRY ABOUT IT", \
	"CERTIFIED SAFE FOR"="A GOOD WHILE AT LEAST", \
	"PLEASE DO NOT SEXT THE CHIEF"="ENGINEER DURING A DELAMINATION AGAIN", \
	"YOUR LIFE IS IN GOOD HANDS"="AS FAR AS WE KNOW", \
	"OUR LEGAL COUNSEL HAS REQUESTED A REMINDER"="THAT YOU HAVE A BREAK AT SOME POINT :3", \
	"BLOWING THINGS UP IS NOT OKAY"="ON COMPANY PROPERTY ANYWAYS", \
	"PLEASE STOP MAKING THINGS HARD"="ON OUR FINANCIALS :)", \
	"YOU CAN TRUST THE AI AND IT'S CYBORGS"="HONEST. WE PROMISE. 100%.", \
	"SEEING BLUE?"="STEP OUT OF THE WATER!", \
	"YOU CAN'T SPELL AIR"="WITHOUT I", \
	"WE CARE ABOUT OUR EMPLOYEES"="TO A POINT", \
	"MIND"="THE GAP", \
	)
	. = ..()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/status_display/random_message/motivational, 32)

/obj/machinery/status_display/random_message/syndicate
	name = "syndicate wartime display"
	desc = "You don't need a leaflet if it's digital."
	text_color = COLOR_DISPLAY_RED
	header_text_color = COLOR_DISPLAY_RED

/obj/machinery/status_display/random_message/syndicate/Initialize(mapload, ndir, building)
	firstline_to_secondline = list(
		"THIS OUTPOST NOW UNDER"="SYNDICATE COMMAND", \
		"FRONT INTEGRITY:"="NaN PERCENT", \
		"LATEST INSTRUCTION FROM HIGH COMMAND:"="ALL AVAILABLE TO ST. LILYBEN", \
		"OUTPOST INTEGRITY:"="COMPROMISED", \
		"SECURITY ADVISORY:"="UNKNOWN HOSTILES", \
		"COMMAND REPORTS"="UNUSUAL INTERFERENCE", \
		"STATION ADMIRAL"="REPORT IN", \
		"REQUESTING IMMEDIATE"="CONTACT", \
		"MISSION INTEGRITY"="COMPROMISED", \
		"IT'S OUTSIDE MY DOOR"="HELP HELP HELP", \
		"RHIALS"="WHERE'S RHIALS", \
		"I WAS JUST SUPPOSED"="TO PAINT THE WALLS", \
	)
	. = ..()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/status_display/random_message/syndicate, 32)

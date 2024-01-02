#define EXAMINE_SECTION_BREAK "<hr>"

#define EFSPAN_ANNOUNCE_MAJ_TITLE(str) ("<span class='efannouncemajtitle'>" + str + "</span>")
#define EFSPAN_ANNOUNCE_MAJ_TEXT(str) ("<span class='efannouncemajtext'>" + str + "</span>")
#define EFSPAN_ANNOUNCE_MIN_TITLE(str) ("<span class='efannouncemintitle'>" + str + "</span>")
#define EFSPAN_ANNOUNCE_MIN_TEXT(str) ("<span class='efannouncemintext'>" + str + "</span>")

// Auto punctuation global datum
GLOBAL_DATUM_INIT(has_eol_punctuation, /regex, regex(@{"[.!?~"\-*][+_|]{0,4}$"}))

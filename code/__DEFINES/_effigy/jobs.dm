// Just keeping this easy to maintain in the future.
#define JOB_NOT_VETERAN (JOB_UNAVAILABLE_ANTAG_INCOMPAT + 1)
#define JOB_UNAVAILABLE_QUIRK (JOB_NOT_VETERAN + 1)
#define JOB_UNAVAILABLE_SPECIES (JOB_UNAVAILABLE_QUIRK + 1)
#define JOB_UNAVAILABLE_LANGUAGE (JOB_UNAVAILABLE_SPECIES + 1)
#define JOB_UNAVAILABLE_FLAVOUR (JOB_UNAVAILABLE_LANGUAGE + 1)

#define SEC_RESTRICTED_QUIRKS "Blind" = TRUE, "Brain Tumor" = TRUE, "Deaf" = TRUE, "Paraplegic" = TRUE, "Mute" = TRUE, "Foreigner" = TRUE, "Pacifist" = TRUE, "Chunky Fingers" = TRUE, "No Guns" = TRUE, "Illiterate" = TRUE, "Nerve Stapled" = TRUE
#define HEAD_RESTRICTED_QUIRKS "Blind" = TRUE, "Deaf" = TRUE, "Mute" = TRUE, "Foreigner" = TRUE, "Chunky Fingers" = TRUE, "Brain Tumor" = TRUE, "Illiterate" = TRUE
#define TECH_RESTRICTED_QUIRKS "Chunky Fingers" = TRUE
#define GUARD_RESTRICTED_QUIRKS "Blind" = TRUE, "Deaf" = TRUE, "Foreigner" = TRUE, "Pacifist" = TRUE, "Nerve Stapled" = TRUE

#define RESTRICTED_QUIRKS_EXCEPTIONS list("Mute" = "Signer")

#define FLAVOR_TEXT_CHAR_REQUIREMENT 150

#define JOB_BLUESHIELD "Blueshield"
#define JOB_NT_REP "Nanotrasen Consultant"
// Nanotrasen Naval Command jobs
#define JOB_NAVAL_ENSIGN "Ensign"
#define JOB_NAVAL_LIEUTENANT "Lieutenant"
#define JOB_NAVAL_LTCR "Lieutenant Commander"
#define JOB_NAVAL_COMMANDER "Commander"
#define JOB_NAVAL_CAPTAIN "Captain"
#define JOB_NAVAL_REAR_ADMIRAL "Rear Admiral"
#define JOB_NAVAL_ADMIRAL "Admiral"
#define JOB_NAVAL_FLEET_ADMIRAL "Fleet Admiral"
// Off-Station
#define JOB_SPACE_POLICE "Space Police"
#define JOB_SOLFED "SolFed"
#define JOB_SOLFED_LIASON "SolFed Liason"

#define JOB_CORRECTIONS_OFFICER "Corrections Officer"
#define JOB_SECURITY_MEDIC "Security Medic"
#define JOB_ENGINEERING_GUARD "Engineering Guard"
#define JOB_SCIENCE_GUARD "Science Guard"
#define JOB_ORDERLY "Orderly"
#define JOB_CUSTOMS_AGENT "Customs Agent"
#define JOB_BARBER "Barber"
#define JOB_BOUNCER "Service Guard"
#define JOB_DISPLAY_ORDER_EXP_CORPS 31
#define JOB_DISPLAY_ORDER_SECURITY_MEDIC 36
#define JOB_DISPLAY_ORDER_CORRECTIONS_OFFICER 38
#define JOB_DISPLAY_ORDER_NANOTRASEN_CONSULTANT 39
#define JOB_DISPLAY_ORDER_BLUESHIELD 40
#define JOB_DISPLAY_ORDER_ORDERLY 41
#define JOB_DISPLAY_ORDER_SCIENCE_GUARD 42
#define JOB_DISPLAY_ORDER_BOUNCER 43
#define JOB_DISPLAY_ORDER_ENGINEER_GUARD 44
#define JOB_DISPLAY_ORDER_CUSTOMS_AGENT 45

#define DEPARTMENT_BITFLAG_CENTRAL_COMMAND (1<<10)
#define DEPARTMENT_CENTRAL_COMMAND "Central Command"

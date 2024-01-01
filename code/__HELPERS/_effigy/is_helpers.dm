//Robots
#define issynthetic(A) (is_species(A,/datum/species/synthetic))
//Actual Species
#define isvox(A) (is_species(A,/datum/species/vox))
#define ispodweak(A) (is_species(A,/datum/species/pod/podweak))
#define isxenohybrid(A) (is_species(A,/datum/species/xeno))
#define isdwarf(A) (is_species(A,/datum/species/dwarf))
#define isroundstartslime(A) (is_species(A,/datum/species/jelly/roundstartslime))
#define istajaran(A) (is_species(A,/datum/species/tajaran))
#define isghoul(A) (is_species(A,/datum/species/ghoul))
#define isakula(A) (is_species(A,/datum/species/akula))
#define isskrell(A) (is_species(A,/datum/species/skell)) //SKRELL GANG SKRELL GANG
#define isunathi(A) (is_species(A,/datum/species/unathi))
#define isvulpkanin(A) (is_species(A,/datum/species/vulpkanin))
#define isteshari(A) (is_species(A, /datum/species/teshari))
#define ishemophage(A) (is_species(A, /datum/species/hemophage))
#define issnail(A) (is_species(A, /datum/species/snail))
#define isluminescent(A) (is_species(A, /datum/species/jelly/luminescent))
//Customization bases
#define isaquatic(A) (is_species(A,/datum/species/aquatic))
#define ishumanoid(A) (is_species(A,/datum/species/humanoid))
#define ismammal(A) (is_species(A,/datum/species/mammal))
#define isinsect(A) (is_species(A,/datum/species/insect))
#define isfelinidonly(A) (is_species(A, /datum/species/human/felinid))
#define isfelinid(A) (isfelinidonly(A) || istajaran(A) || HAS_TRAIT(A, TRAIT_FELINE))
#define isfeline(A) (isfelinidonly(A) || istajaran(A) || HAS_TRAIT(A, TRAIT_FELINE))

#define is_spaceruins_level(z) SSmapping.level_trait(z, ZTRAIT_SPACE_RUINS) //Detects when a z-level has space ruins. This is different from empty space z-levels.

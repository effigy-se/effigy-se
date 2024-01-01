/datum/controller/subsystem/processing/reagents/Initialize()
	. = ..()
	if(CONFIG_GET(flag/disable_erp_preferences))
		for(var/reaction_path in GLOB.chemical_reactions_list)
			var/datum/chemical_reaction/reaction_datum = GLOB.chemical_reactions_list[reaction_path]
			if(!reaction_datum.erp_reaction)
				continue
			GLOB.chemical_reactions_list -= reaction_path
			for(var/reaction in reaction_datum.required_reagents)
				var/list/reaction_list = GLOB.chemical_reactions_list_reactant_index[reaction]
				if(reaction_list)
					reaction_list -= reaction_datum

/datum/controller/subsystem/economy
	roundstart_paychecks = 4
	budget_pool = 40000

/datum/job/captain
	paycheck_department = ACCOUNT_SRV

/datum/controller/subsystem/economy/Initialize()
	//removes cargo from the split
	var/budget_to_hand_out = round(budget_pool / department_accounts.len)
	if(time2text(world.timeofday, "DDD") == SUNDAY)
		mail_blocked = TRUE

	for(var/dep_id in department_accounts)
		if(dep_id == ACCOUNT_CAR) //cargo starts with NOTHING
			new /datum/bank_account/department(dep_id, 0, player_account = FALSE)
			continue
		if(dep_id == ACCOUNT_SRV) //SRV gets double as it also pays command
			new /datum/bank_account/department(dep_id, budget_to_hand_out * 2, player_account = FALSE)
			continue
		new /datum/bank_account/department(dep_id, budget_to_hand_out, player_account = FALSE)

	return SS_INIT_SUCCESS

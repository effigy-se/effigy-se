/datum/controller/subsystem/blackbox/CheckPlayerCount()
	set waitfor = FALSE

	if(!SSdbcore.Connect())
		return
	var/playercount = LAZYLEN(GLOB.player_list)
	var/admincount = GLOB.admins.len
	var/datum/db_query/query_record_playercount = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("legacy_population")] (playercount, admincount, time, server_name, server_ip, server_port, round_id)
		VALUES (:playercount, :admincount, :time, :server_name, INET_ATON(:server_ip), :server_port, :round_id)
	"}, list(
		"playercount" = playercount,
		"admincount" = admincount,
		"time" = SQLtime(),
		"server_name" = CONFIG_GET(string/serversqlname),
		"server_ip" = world.internet_address || "0",
		"server_port" = "[world.port]",
		"round_id" = GLOB.round_id,
	))
	query_record_playercount.Execute()
	qdel(query_record_playercount)

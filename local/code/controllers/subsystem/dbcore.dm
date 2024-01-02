/datum/controller/subsystem/dbcore/CheckSchemaVersion()
	if(CONFIG_GET(flag/sql_enabled))
		if(Connect())
			log_world("Database connection established.")
			var/datum/db_query/query_db_version = NewQuery("SELECT major, minor, effigy FROM [format_table_name("schema_revision")] ORDER BY date DESC LIMIT 1")
			query_db_version.Execute()
			if(query_db_version.NextRow())
				db_major = text2num(query_db_version.item[1])
				db_minor = text2num(query_db_version.item[2])
				db_effigy = text2num(query_db_version.item[3])
				if(db_major != DB_MAJOR_VERSION || db_minor != DB_MINOR_VERSION || db_effigy != DB_EFFIGY_VERSION) // EffigyEdit Add - DB Revision
					schema_mismatch = 1 // flag admin message about mismatch
					log_sql("Database schema ([db_major].[db_minor] e[db_effigy]) doesn't match the latest schema version ([DB_MAJOR_VERSION].[DB_MINOR_VERSION] e[DB_EFFIGY_VERSION]), this may lead to undefined behaviour or errors")
			else
				schema_mismatch = 2 //flag admin message about no schema version
				log_sql("Could not get schema version from database")
			qdel(query_db_version)
		else
			log_sql("Your server failed to establish a connection with the database.")
	else
		log_sql("Database is not enabled in configuration.")

/datum/controller/subsystem/dbcore/InitializeRound()
	CheckSchemaVersion()

	if(!Connect())
		GLOB.round_id = "1024" // who made round_id a string, seriously
		GLOB.round_hex = truncate(num2text(text2num(GLOB.round_id) * 1024, 9, 16), 8)
		return
	var/datum/db_query/query_round_initialize = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name("round")] (initialize_datetime, server_name, server_ip, server_port) VALUES (Now(), :server_name, INET_ATON(:internet_address), :port)",
		list("server_name" = CONFIG_GET(string/serversqlname), "internet_address" = world.internet_address || "0", "port" = "[world.port]")
	)

	query_round_initialize.Execute(async = FALSE)
	GLOB.round_id = "[query_round_initialize.last_insert_id]"
	GLOB.round_hex = truncate(num2text(text2num(GLOB.round_id) * 1024, 9, 16), 8)
	qdel(query_round_initialize)

/datum/controller/subsystem/dbcore/SetRoundStart()
	if(!Connect())
		return
	var/datum/db_query/query_round_start = SSdbcore.NewQuery(
		"UPDATE [format_table_name("round")] SET start_datetime = Now(), effigy_rid = :effigy_rid WHERE id = :round_id",
		list("round_id" = GLOB.round_id, "effigy_rid" = GLOB.round_hex)
	)
	query_round_start.Execute()
	qdel(query_round_start)

Any time you make a change to the schema files, remember to increment the database schema version. Generally increment the minor number, major should be reserved for significant changes to the schema. Both values go up to 255.

Make sure to also update `DB_EFFIGY_VERSION` which can be found in `code/__DEFINES/subsystem.dm`.

The latest Effigy database version is E5; The query to update the schema revision table is:

```sql
INSERT INTO `schema_revision` (`effigy`) VALUES (5);
```
or

```sql
INSERT INTO `SS13_schema_revision` (`effigy`) VALUES (5);
```

In any query remember to add a prefix to the table names if you use one.

-----------------------------------------------------
Version E5, 11 October 2023, by LT3
First revision of published schema

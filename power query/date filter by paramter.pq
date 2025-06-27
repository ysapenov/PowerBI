//Create parameter called DaysFiltered
7 meta [IsParameterQuery=true, Type="Number", IsParameterQueryRequired=true]
//In this query I also used parameters for Role, Database and Schema
let
    Source = Snowflake.Databases("xx123456.eu-west-1.snowflakecomputing.com",snowflake_wh, [Role=snowflake_role]),
    SNOWFLAKE_Database = Source{[Name=snowflake_db,Kind="Database"]}[Data],
    ACCOUNT_USAGE_Schema = SNOWFLAKE_Database{[Name=snowflake_schema,Kind="Schema"]}[Data],
    QUERY_HISTORY_View = ACCOUNT_USAGE_Schema{[Name="WAREHOUSE_LOAD_HISTORY",Kind="View"]}[Data],
    #"Filtered Rows" = Table.SelectRows(QUERY_HISTORY_View, each Date.IsInPreviousNDays([START_TIME], DaysFiltered))
in
    #"Filtered Rows"
//It is also possible to change the condition of filtering 
#"Filtered Rows" = Table.SelectRows(QUERY_HISTORY_View, each [START_DATE] >= Date.AddDays(DateTime.Date( DateTime.LocalNow()), - DaysFiltered) )
/*
here Role, Database and schema are parameters
The columns of the table "TRADING_SALES" are renamed according to 
the master table "TRADING_TCH_NAMING", which has 
COLUMN_NAME and BUSINESS_NAME columns
*/

let
    Source = Snowflake.Databases("xx123456.eu-west-1.snowflakecomputing.com",snowflake_wh, [Role=snowflake_role]),
    Database = Source{[Name=snowflake_db,Kind="Database"]}[Data],
    Schema = Database{[Name=snowflake_schema,Kind="Schema"]}[Data],
    Sales_rename = Table.RenameColumns(
        Schema{[Name="TRADING_SALES",Kind="Table"]}[Data],
        Table.ToRows(
            Table.SelectColumns(
                Table.SelectRows(
                    Schema{[Name="TRADING_TCH_NAMING",Kind="Table"]}[Data],
                    each [TABLE_NAME] = "TRADING_SALES"
                    and [BUSINESS_NAME] <> ""
                ),
                {"COLUMN_NAME", "BUSINESS_NAME"}
            )
        )
    )
in
    Sales_rename
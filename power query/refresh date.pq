let
    Source = DateTime.Date(DateTime.LocalNow()),
    #"Converted to Table" = #table(1, {{Source}}),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "Refreshed"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Refreshed", type date}})
in
    #"Changed Type"
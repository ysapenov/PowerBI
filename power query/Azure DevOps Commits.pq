let
    Source = VSTS.Contents("https://connectionseducation.visualstudio.com/EnterpriseSoftwarePortfolio/_apis/git/repositories?api-version=6.0"),
    #"Imported JSON" = Table.FromRecords(Json.Document(Source,65001)[value]),
    #"Removed Other Columns" = Table.SelectColumns(#"Imported JSON",{"name"}),
    #"Removed Errors" = Table.RemoveRowsWithErrors(#"Removed Other Columns"),
    #"Invoked Custom Function" = Table.AddColumn(#"Removed Errors", "v2commit", each v2commit([name])),
    #"Removed Errors1" = Table.RemoveRowsWithErrors(#"Invoked Custom Function", {"v2commit"}),
    #"Expanded v2commit" = Table.ExpandTableColumn(#"Removed Errors1", "v2commit", {"commitId", "author.name", "author.date", "workItems.id"}, {"commitId", "author.name", "author.date", "workItems.id"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded v2commit",{{"commitId", type text}, {"name", type text}, {"author.name", type text}, {"author.date", type datetime}, {"workItems.id", Int64.Type}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Changed Type",{{"author.date", type date}})
in
    #"Changed Type1"


// Function v2commit
(Repo as text) as table =>

let
    Source = VSTS.Contents("https://connectionseducation.visualstudio.com/",
    [RelativePath ="EnterpriseSoftwarePortfolio/_apis/git/repositories/"&(Repo)&"/commits?includeWorkItems=true&$top=1000&api-version=6.0"]),

    #"Imported JSON1" = Json.Document(Source,65001),
    value = #"Imported JSON1"[value],
    #"Converted to Table" = Table.FromList(value, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to Table", "Column1", {"commitId", "author", "workItems"}, {"commitId", "author", "workItems"}),
    #"Expanded author" = Table.ExpandRecordColumn(#"Expanded Column1", "author", {"name", "date"}, {"author.name", "author.date"}),
    #"Expanded workItems" = Table.ExpandListColumn(#"Expanded author", "workItems"),
    #"Expanded workItems1" = Table.ExpandRecordColumn(#"Expanded workItems", "workItems", {"id"}, {"workItems.id"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded workItems1",{{"commitId", type text}, {"author.name", type text}, {"workItems.id", Int64.Type}, {"author.date", type datetime}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Changed Type",{{"author.date", type date}})
in
    #"Expanded workItems1"
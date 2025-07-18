let
    Source = VSTS.Contents("https://connectionseducation.visualstudio.com/EnterpriseSoftwarePortfolio/_apis/git/pullRequests?status=all&$top=1000&api-version=6.0"),
    #"Imported JSON1" = Json.Document(Source,65001),
    value = #"Imported JSON1"[value],
    #"Converted to Table" = Table.FromList(value, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to Table", "Column1", {"repository", "pullRequestId", "status", "createdBy", "creationDate", "reviewers"}, {"repository", "pullRequestId", "status", "createdBy", "creationDate", "reviewers"}),
    #"Expanded repository" = Table.ExpandRecordColumn(#"Expanded Column1", "repository", {"name"}, {"repository.name"}),
    #"Expanded createdBy" = Table.ExpandRecordColumn(#"Expanded repository", "createdBy", {"displayName"}, {"createdBy.displayName"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Expanded createdBy",{{"creationDate", type datetime}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Changed Type",{{"creationDate", type date}}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Changed Type1",{{"repository.name", type text}, {"pullRequestId", type text}, {"status", type text}, {"createdBy.displayName", type text}}),
    #"Removed Errors" = Table.RemoveRowsWithErrors(#"Changed Type2"),
    #"Invoked Custom Function" = Table.AddColumn(#"Removed Errors", "WorkItemId", each v2pull_request_WI([repository.name], [pullRequestId])),
    #"Removed Errors1" = Table.RemoveRowsWithErrors(#"Invoked Custom Function", {"WorkItemId"}),
    #"Expanded WorkItemId" = Table.ExpandTableColumn(#"Removed Errors1", "WorkItemId", {"WorkItemId"}, {"WorkItemId"}),
    #"Changed Type4" = Table.TransformColumnTypes(#"Expanded WorkItemId",{{"WorkItemId", Int64.Type}}),
    #"Expanded reviewers" = Table.ExpandListColumn(#"Changed Type4", "reviewers"),
    #"Expanded reviewers1" = Table.ExpandRecordColumn(#"Expanded reviewers", "reviewers", {"displayName"}, {"reviewers.displayName"})
in
    #"Expanded reviewers1"


// Function v2pull_request_WI
(Repo as text, PullRequest as text) as table =>

let
    Source = VSTS.Contents("https://connectionseducation.visualstudio.com/",
    [RelativePath ="EnterpriseSoftwarePortfolio/_apis/git/repositories/"&(Repo)&"/pullRequests/"&(PullRequest)&"/workitems?api-version=6.0"]),
    #"Imported JSON" = Table.FromRecords(Json.Document(Source,65001)[value]),
    #"Removed Columns" = Table.RemoveColumns(#"Imported JSON",{"url"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"id", "WorkItemId"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"WorkItemId", type text}})
in
    #"Changed Type"
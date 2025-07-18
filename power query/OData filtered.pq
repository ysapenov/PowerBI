let
    Source = OData.Feed("https://connectionseducation.analytics.visualstudio.com/EnterpriseSoftwarePortfolio/_odata/v2.0/WorkItems?
$select=WorkItemId, AreaSK, IterationSK, Title, WorkItemType, ParentWorkItemId, Severity, Priority, State, Reason, ResolvedReason, Connections_DefectFoundPhase, Connections_OriginationCategorization
&$filter=(WorkItemType eq 'Bug' or WorkItemType eq 'Defect') 
and (CreatedDateSK gt 20220101)
", null, [Implementation="2.0",OmitValues = ODataOmitValues.Nulls,ODataVersion = 4]),
    #"Replaced Value" = Table.ReplaceValue(Source,null,"Other Defects",Replacer.ReplaceValue,{"Connections_DefectFoundPhase"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value",null,"Other",Replacer.ReplaceValue,{"Connections_OriginationCategorization"}),
    #"Added Conditional Column" = Table.AddColumn(#"Replaced Value1", "DevDone", each if [WorkItemType] = "Defect" then "Before Dev Done" else if [WorkItemType] = "Bug" then "After Dev Done" else null, type text),
    #"Added Conditional Column1" = Table.AddColumn(#"Added Conditional Column", "LiveState", each if [WorkItemType] = "Defect" then "Pre-Live" else if [Connections_OriginationCategorization] = "Incident Management" then "Live" else if [Connections_OriginationCategorization] = "RRT" then "Live" else "Pre-Live", type text),
    #"Added Conditional Column2" = Table.AddColumn(#"Added Conditional Column1", "Phase", each if [WorkItemType] = "Defect" then [Connections_DefectFoundPhase] else [Connections_OriginationCategorization], type text)
in
    #"Added Conditional Column2"
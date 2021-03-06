dotnet tool install -g Jetbrains.Resharper.GlobalTools

#Add check for correct solution name
New-Item -Path 'inspections.xml' -ItemType File
Write-Host $env:INPUTS_SEVERITY_LEVEL
jb inspectcode $env:INPUTS_SOLUTION_NAME --exclude=$env:INPUTS_EXCLUDE_LIST -s="$env:INPUTS_SEVERITY_LEVEL" -o="inspections.xml"
ls

[xml]$inspections = [xml](Get-Content -Path inspections.xml)
$errorIssueTypes = $inspections.Report.IssueTypes.IssueType | ? { $_.Severity -eq $env:INPUTS_SEVERITY_LEVEL } | % { $_.Id }
$errors = $inspections.Report.Issues.Project.Issue | ? { $errorIssueTypes -Contains $_.TypeId }
if ($errors.Count -ne 0 )
{
    echo "FAIL - Identified $($errors.Count) errors in solution."
    $errors | % { echo "ERROR - $($_.ParentNode.Name) - $($_.TypeId) - $($_.File) line $($_.Line) - $($_.Message)" }
    exit 1
}
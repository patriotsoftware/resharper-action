dotnet tool install --global Jetbrains.Resharper.GlobalTools --version "$env:INPUTS_TOOL_VERSION"

$inspectionsFile = "inspections.xml"
Write-Host $env:INPUTS_SEVERITY_LEVEL

jb inspectcode $env:INPUTS_SOLUTION_NAME --exclude="$env:INPUTS_EXCLUDE_LIST" --severity="$env:INPUTS_SEVERITY_LEVEL" --format="xml" --output="$inspectionsFile"

if ($LASTEXITCODE -ne 0) {
  Write-Host "Error: jb inspectcode command failed with exit code $LASTEXITCODE"
  exit $LASTEXITCODE
}

ls "$inspectionsFile"

[xml]$inspections = [xml](Get-Content -Path "$inspectionsFile")
$errorIssueTypes = $inspections.Report.IssueTypes.IssueType | ? { $_.Severity -eq $env:INPUTS_SEVERITY_LEVEL } | % { $_.Id }
$errors = $inspections.Report.Issues.Project.Issue | ? { $errorIssueTypes -Contains $_.TypeId }
if ($errors.Count -ne 0 )
{
  echo "FAIL - Identified $($errors.Count) errors in solution."
  $errors | % { echo "ERROR - $($_.ParentNode.Name) - $($_.TypeId) - $($_.File) line $($_.Line) - $($_.Message)" }
  exit 1
}

Write-Host "SUCCESS - No errors identified in solution."
exit 0

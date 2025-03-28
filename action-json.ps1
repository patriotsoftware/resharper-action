dotnet tool install --global Jetbrains.Resharper.GlobalTools --version "$env:INPUTS_TOOL_VERSION"

$inspectionsFile = "inspections.json"
Write-Host $env:INPUTS_SEVERITY_LEVEL

jb inspectcode $env:INPUTS_SOLUTION_NAME --exclude="$env:INPUTS_EXCLUDE_LIST" --sEverity="$env:INPUTS_SEVERITY_LEVEL" --format="json" --output="$inspectionsFile"

if ($LASTEXITCODE -ne 0) {
  Write-Host "Error: jb inspectcode command failed with exit code $LASTEXITCODE"
  exit $LASTEXITCODE
}

ls "$inspectionsFile"

$inspections = (Get-Content -Path inspections.json -Raw | ConvertFrom-Json)
$errors = $inspections.runs.results | ? { $_.level -eq "error" }

if ($errors.Length -ne 0 )
{
    echo "FAIL - Identified $($errors.Length) errors in solution."
    $errors | % { echo "ERROR - $($_.ruleId) - $($_.locations[0].physicalLocation.artifactLocation.uri) line $($_.locations[0].physicalLocation.region.startLine) - $($_.message.text)" }
    exit 1
}

Write-Host "SUCCESS - No errors identified in solution."
exit 0

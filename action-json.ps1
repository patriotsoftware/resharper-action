dotnet tool install -g Jetbrains.Resharper.GlobalTools

#Add check for correct solution name
New-Item -Path 'inspections.json' -ItemType File
Write-Host $env:INPUTS_SEVERITY_LEVEL
jb inspectcode $env:INPUTS_SOLUTION_NAME --exclude=$env:INPUTS_EXCLUDE_LIST -s="$env:INPUTS_SEVERITY_LEVEL" -o="inspections.json"
ls

$inspections = (Get-Content -Path inspections.json -Raw | ConvertFrom-Json)

$errors = $inspections.runs.results | ? { $_.level -eq "error" }

if ($errors.Length -ne 0 )
{
    echo "FAIL - Identified $($errors.Length) errors in solution."
    $errors | % { echo "ERROR - $($_.ruleId) - $($_.locations[0].physicalLocation.artifactLocation.uri) line $($_.locations[0].physicalLocation.region.startLine) - $($_.message.text)" }
    exit 1
}
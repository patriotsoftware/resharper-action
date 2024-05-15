# resharper-action
A GitHub Action for running ReSharper. We recommend using patriotsoftware/resharper-action@v1 to get the latest changes. If new features require breaking changes, we will release them to @v2. You can also use a full semantic version tag.

# Example Usage
```- uses: patriotsoftware/resharper-action@v1```
# Inputs
```
solution-name:
  This is the name of the solution file.
exclude-list:
  Semicolon separated list of values inside double quotes.
  These files will be ignored in the scan.
severity-level:
  Severity Level. What should fail the inspections?
file-type:
  Default is XML. Options (XML or JSON)
```


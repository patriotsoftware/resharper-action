# resharper-action
A GitHub Action for running ReSharper. We recommend using patriotsoftware/helm-upgradepaction@v1 to get the latest changes. If new features require breaking changes, we will release them to @v2. You can also use a full semantic version tag.

# Example Usage
```- uses: patriotsoftware/resharper-action@v1```
# Inputs
```
solution-name:
  This is the name of the solution file.
exclude-list:
  Semicolon separated list of values inside double quotes.
severity-level:
  Severity Level.
```


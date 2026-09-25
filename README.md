# ⚠️ DEPRECATED: resharper-action

**This action is deprecated and archived. Remove it from your workflows.** It will be deleted without further notice.

Until v1.2.0 this action passed `-s="ERROR"` to `jb inspectcode`. `-s` is `--settings`, not severity, so ReSharper aborted without inspecting anything and the action always passed.

`v1` is now a thin shim over [JetBrains/ReSharper-InspectCode](https://github.com/JetBrains/ReSharper-InspectCode). It emits a deprecation warning and runs inspections for information only; it never fails the build. That keeps existing callers working while ReSharper is removed from the runner images (DVO-1443).

## Migrating

- **You don't need ReSharper inspections:** delete the `uses: patriotsoftware/resharper-action@v1` step (and its job, if that's all the job does).
- **You do want them:** call [JetBrains/ReSharper-InspectCode](https://github.com/JetBrains/ReSharper-InspectCode) directly.

Lumyfycommerce - Development workflow
==================================

Workflow (simple, single-developer)
- Main rule: do all development work on the `develop` branch.
- `master` (main) is the stable production snapshot and must not be worked on directly.

When to sync from `master` to `develop`
- If `develop` breaks and you need a clean baseline, merge `master` into `develop` and continue working there.

Minimal commands
- Switch to develop:
  git checkout develop
  git pull origin develop

- Create a quick local change and push to remote develop:
  git add -A
  git commit -m "feat: short description"
  git push origin develop

- If you need to refresh develop from master (keep master untouched):
  git checkout develop
  git pull origin develop
  git merge --no-ff origin/master
  # resolve conflicts if any, run tests
  git push origin develop

Notes
- For small fixes you can commit directly to `develop`. For larger work you may create a feature branch off `develop` and merge back — optional.
- Keep backups and sensitive files out of git (.gitignore already configured).

If you want, I can also add this README to `master` (as a stable note) after you approve it.

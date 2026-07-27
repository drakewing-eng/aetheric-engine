# Aetheric Engine backups

## Live project
`/Users/babble/aetheric-engine` → symlink to  
`/Users/babble/ gemini/antigravity/playground/aetheric-engine`

## Git (primary recovery)
Local git repo on **main** branch.

```bash
cd "/Users/babble/aetheric-engine"
git log --oneline -10
git status
# undo uncommitted mess in one file:
git checkout -- path/to/file
# hard reset to last checkpoint (destroys uncommitted work):
# git reset --hard HEAD
```

Latest checkpoint commit: see `git log -1`

## Tarball snapshots
Files like `aetheric_checkpoint_YYYYMMDD_HHMMSS.tar.gz`

Restore example:
```bash
cd /tmp && tar -xzf "/Users/babble/ gemini/antigravity/playground/aetheric-engine/BACKUPS/aetheric_checkpoint_20260726_232802.tar.gz"
# then copy files back carefully
```

Created: 20260726_232802

## GitHub (cloud backup)

**Private repo:** https://github.com/drakewing-eng/aetheric-engine

```bash
cd "/Users/babble/aetheric-engine"
# after a work session:
./scripts/checkpoint.sh "checkpoint: description of what changed"
```

Clone on another machine:
```bash
gh repo clone drakewing-eng/aetheric-engine
```

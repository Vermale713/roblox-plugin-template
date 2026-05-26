[parallel]
dev: sourcemap plugin

plugin:
    argon build -p -w

sourcemap:
    argon sourcemap -o sourcemap.json -w

sync:
    git diff --quiet && git diff --cached --quiet || git stash && \
    git fetch template && \
    git merge template/main && \
    git stash list | grep -q "stash@{0}" && git stash pop
#!/bin/bash

# Navigate to the Git repository
# cd /path/to/your/git/repo || exit 1

# Fetch the latest branch information
git fetch --all || exit 1

# Function to recursively display branches with tree-like structure
display_branches() {
    local prefix="$1"
    local parent_branch="$2"

    git for-each-ref --format='%(refname:short)' --sort=-committerdate --merged "$parent_branch" refs/heads/ | \
    while IFS= read -r branch; do
        echo "$prefix$branch"
        display_branches "$prefix    " "$branch"
    done
}

# Display the root branches
display_branches "" "origin/main"

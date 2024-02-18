#!/bin/bash

# Navigate to the Git repository
# cd /path/to/your/git/repo

# Fetch the latest branch information
git fetch --all

# Function to recursively display branches with tree-like structure
display_branches() {
    local prefix="$1"
    local parent_branch="$2"
    local branches=()

    while IFS= read -r branch; do
        branches+=("$branch")
    done < <(git for-each-ref --format='%(refname:short)' --sort=-committerdate --merged "$parent_branch" refs/heads/)

    local count=${#branches[@]}
    
    for ((i=0; i<count; i++)); do
        local branch="${branches[i]}"
        local is_last=$((i == count - 1))

        echo -n "$prefix"
        echo -n "$([ $is_last ] && echo '└── ' || echo '├── ')"
        echo "$branch"

        if [ $is_last ]; then
            display_branches "$prefix    " "$branch"
        else
            display_branches "$prefix│   " "$branch"
        fi
    done
}

# Display the root branches
display_branches "" "origin/main"

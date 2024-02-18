#!/bin/bash

# Navigate to the Git repository
cd /path/to/your/git/repo

# Fetch the latest branch information
git fetch --all

# Display the branches in a tree-like structure
git branch -a --format='%(refname:short)' --sort=-committerdate | sed 's/[^/]*\//  /g' | sed 's/  ├─/  │/g' | sed 's/  └─/   /g'

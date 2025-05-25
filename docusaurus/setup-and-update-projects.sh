#!/bin/bash
# setup-and-update-projects.sh

echo "Setting up and updating projects..."

PROJECTS=(
  "perseverance-rover:https://github.com/apstrand/nokit-perseverance-rover.git"
)

# Ensure directories exist
mkdir -p _projects docs

for project_info in "${PROJECTS[@]}"; do
  IFS=':' read -r name repo <<< "$project_info"
  repo_path="_projects/${name}-repo"
  symlink_path="docs/${name}"
  
  # Add/update submodule
  if [ -d "$repo_path" ]; then
    echo "Updating submodule $name..."
    cd "$repo_path" && git pull && cd ../..
  else
    echo "Adding submodule $name..."
    git submodule add "$repo" "$repo_path"
  fi
  
  # Create symlink if it doesn't exist
  if [ ! -L "$symlink_path" ]; then
    echo "Creating symlink for $name..."
    ln -sf "../_projects/${name}-repo/docs" "$symlink_path"
  fi
done


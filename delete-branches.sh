#!/bin/bash

toPreserveFile="Branches-To-Be-Preserved-File"
toDeleteFile="Branches-To-Be-Deleted-File"
count=1

# Use expect script to add the SSH key (this will handle the passphrase)
./auto-password.expect

while IFS= read -r branch; do
  # Print the current branch for debugging purposes
#   count=$((count+1))
#   echo "Processing branch: $branch and count is ${count}"
  
  if grep -q "$branch" "$toPreserveFile"; then
    echo "This can't be deleted ${branch}!!!!! #####"
  else
    echo "This branch can be deleted ${branch}"
    git push origin --delete "$branch"
    if [[ $? -eq 0 ]]; then
      echo "Successfully deleted branch ${branch}"
    else
      echo "Failed to delete branch ${branch}"
    fi
  fi
done < "$toDeleteFile"
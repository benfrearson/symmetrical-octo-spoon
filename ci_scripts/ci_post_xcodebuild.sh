#!/bin/sh

# Ensure the script exits on first error
set -e

# Define the directory where TestFlight notes will be stored
TESTFLIGHT_DIR_PATH="../TestFlight"

# Check if the signed app path exists
#if [[ -d "$CI_APP_STORE_SIGNED_APP_PATH" ]]; then
  # Create the TestFlight directory if it doesn't exist
  mkdir -p $TESTFLIGHT_DIR_PATH

  echo "$CI_TAG" > $TESTFLIGHT_DIR_PATH/WhatToTest.en-GB.txt
  CI_TAG_PREFIX=${CI_TAG%%-*}

  echo "Fetching tags"
  # Fetch tags and history to ensure we have the data needed to compute the changelog
  git fetch --tags

  echo "Setting previous tag"
  PREVIOUS_TAG=$(git tag --list "$CI_TAG_PREFIX-*" | sort -V | tail -n 2 | head -n 1)

  echo "Previous tag: $PREVIOUS_TAG"

  if [ -n "$PREVIOUS_TAG" ]; then

    # Extract the date of the previous tag
    PREVIOUS_TAG_DATE=$(git show -s --format=%ci $PREVIOUS_TAG | cut -d ' ' -f 1)
    echo "Previous tag date: $PREVIOUS_TAG_DATE"

    # Fetch commits since the date of the previous tag
    git fetch --shallow-since="$PREVIOUS_TAG_DATE"

    PR_HISTORY=$(git log $PREVIOUS_TAG..HEAD --pretty=format:"%s" --merges --pretty=format:'%s %cn' --source | grep "GitHub$" | sed 's/.\{7\}$//')
    echo $PR_HISTORY
    echo "$PR_HISTORY" > $TESTFLIGHT_DIR_PATH/WhatToTest.en-GB.txt

  else
  echo "Could not find previous tag with prefix $CI_TAG_PREFIX. Returning last 5 merge commits."
    git log -5 --pretty=format:"%s" --merges > $TESTFLIGHT_DIR_PATH/WhatToTest.en-GB.txt
  fi

  echo "\nChangelog generated in $TESTFLIGHT_DIR_PATH/WhatToTest.en-GB.txt"
#fi

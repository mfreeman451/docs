#!/bin/bash

# Directory containing the .mdx files
DIRECTORY="./alerting/"

# Iterate over each .mdx file in the directory
for FILE in "$DIRECTORY"/*.mdx; do
    # Extract the title from the filename
    TITLE=$(basename "$FILE" .mdx | sed -e 's/-/ /g' -e 's/f5/F5/g')

    # YAML content to prepend
    YAML_CONTENT="---
title: \"$TITLE\"
description: \"$TITLE\"
---

## Overview
"

    # Temp file for the new content
    TEMP_FILE=$(mktemp)

    # Write YAML content to the temp file
    echo "$YAML_CONTENT" > "$TEMP_FILE"

    # Append the original file content to the temp file
    cat "$FILE" >> "$TEMP_FILE"

    # Move the temp file back to the original file
    mv "$TEMP_FILE" "$FILE"
done


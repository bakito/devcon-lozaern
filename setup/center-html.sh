#!/usr/bin/env bash
#
# Centers the content of a presenterm-exported HTML file.
#
# Presenterm exports HTML with a fixed-size body (726×480) that scales to fit
# the window but stays anchored to the top-left corner. This script modifies
# the CSS so the scaled content is centered both horizontally and vertically.
#
# Usage:
#   ./setup/center-html.sh <file.html>
#
# The file is modified in place.

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <file.html>" >&2
    exit 1
fi

FILE="$1"

if [[ ! -f "$FILE" ]]; then
    echo "Error: file '$FILE' not found" >&2
    exit 1
fi

# Check if already processed to avoid double-processing
if grep -q 'transform-origin: center center' "$FILE"; then
    echo "File '$FILE' is already centered."
    exit 0
fi

# Create a backup
cp "$FILE" "${FILE}.bak"

# The key changes:
# 1. Change the body's transform-origin from 'top left' to 'center center'
#    so scaling happens from the center of the element.
# 2. Add CSS to center the body within the viewport using flexbox on html.
# 3. Update the scaler JS to also apply a translate to center the body.

# Step 1: Replace transform-origin in the body CSS
sed -i 's/transform-origin: top left;/transform-origin: center center;/' "$FILE"

# Step 2: Add html centering CSS before the closing </style> tag
# We insert a new rule that makes html a flex container and centers body
sed -i '/<\/style>/i\
\
        html {\
            margin: 0;\
            padding: 0;\
            width: 100vw;\
            height: 100vh;\
            display: flex;\
            justify-content: center;\
            align-items: center;\
            overflow: hidden;\
            background-color: #040312;\
        }' "$FILE"

echo "Centered content in '$FILE' (backup saved as '${FILE}.bak')."

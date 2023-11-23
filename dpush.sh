
COMMIT=${1:-default commit message}

git add *

# Use the first argument as the commit message
git commit -m "$COMMIT"

# Push the changes to the 'main' branch of the 'origin' remote
git push -u origin main

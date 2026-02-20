#!/bin/bash

if [ ! -f package.json ]; then
    echo "build-frontend.sh: Please run this script from the root of the repository"
    exit 1
fi

# Remove broken symlinks that won't resolve during the buikdpack build.
rm ./video2commons/frontend/static/ssu
rm ./video2commons/frontend/static/uploads

# Build frontend with gulp.
npm run build:gulp

if [ $? -ne 0 ]; then
    echo "build-frontend.sh: Failed to build frontend"
    exit 1
fi

# Restore broken symlinks to the previous state.
git checkout -- ./video2commons/frontend/static/ssu
git checkout -- ./video2commons/frontend/static/uploads

echo "build-frontend.sh: Successfully built frontend"

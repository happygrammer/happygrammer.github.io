#cp -rp ./content ./public

hugo -t hugo-theme-minos
cd public
git add .
git commit -m "commit"

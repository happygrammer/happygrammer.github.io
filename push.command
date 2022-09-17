cd /Users/smarthome/happygrammer.github.io
cp -rp ./content ./public
hugo -t hugo-theme-minos
cd public
git add .
git commit -m "commit"
#git remote add origin https://github.com/happygrammer/happygrammer.github.io.git
git push -u origin master

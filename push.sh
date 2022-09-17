#cp -rp ./content ./public
hugo -t hugo-theme-minos
cd public
git add .
git commit -m "commit"
#git remote add origin https://github.com/happygrammer/happygrammer.github.io.git
# token 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
# 아래와 같이 입력하면 자동 인증이 가능함. 토큰..
# git remote set-url origin https://happygrammer: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@github.com/happygrammer/happygrammer.github.io
git push -u origin master

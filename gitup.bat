git commit -am "update"
git checkout --orphan tmp
git branch -D master
git checkout --orphan master
git commit -am "update"
git branch -D tmp
git push origin HEAD -f
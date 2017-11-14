for branch in `git branch -a | grep -v HEAD | grep -v master `; do
   git branch --track ${branch#remotes/origin/} $branch
done

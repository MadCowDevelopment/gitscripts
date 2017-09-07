#!/bin/bash
echo ---------------------------------------------
echo - fix: This command will fix a local branch -
echo ---------------------------------------------



if [ -z "$1" ]
  then
    echo "No branch name supplied!"
	echo "Usage: fix [branch]"
	exit
fi

echo fix: Fetching latest changes...
git fetch

echo fix: Checking out $1...
git checkout $1

OLDPARENT=`git merge-base master $1`
NEWPARENT=`git rev-parse origin/master`

echo fix: Please review the following command:
echo fix: git rebase --onto $NEWPARENT $OLDPARENT
read -rsp $'fix: Press any key to rebase...\n' -n 1 key
git rebase --onto $NEWPARENT $OLDPARENT

read -rsp $'fix: Do you want to reset master to origin/master (y/n)?\n' -n 1 key
if [ "$key" = "y" ]; then
	git checkout master
	git reset --hard origin/master
fi

echo fix: If there were no errors your branch should be fine now.
echo fix: Don\'t forget to force push the changes to the remote.

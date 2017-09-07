#!/bin/bash
echo ------------------------------------------------------------------------
echo - GET LATEST: This command will rebase latest changes from Integration -
echo ------------------------------------------------------------------------

ORIGINAL_MASTER=`git rev-parse master`
echo GET: --> Original master rev is: "$ORIGINAL_MASTER"

read -rsp $'--> Press any key to fetch latest changes from remote...\n' -n 1 key
git fetch

read -rsp $'--> Press any key to pull latest changes for master...\n' -n 1 key
git checkout master
git pull 

read -rsp $'--> Press any key to pull latest changes for integration...\n' -n 1 key
git checkout integration
git pull

read -rsp $'--> Press any key to rebase master onto integration...\n' -n 1 key
git checkout master
git rebase integration

read -rsp $'--> WARNING: Do you want to force push to the remote (y/n)?\n' -n 1 key
if [ "$key" = "y" ]; then
	git push --force
	read -rsp $'--> Press any key to reset local master to "$ORIGINAL_MASTER"...\n' -n 1 key
	git reset --hard $ORIGINAL_MASTER
fi


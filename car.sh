#!/bin/bash

MAX_COUNT=`git rev-list --count $(git merge-base head master)..head`
CA_COMMIT_MESSAGE="--DISABLED_CODE_ANALYSIS--"
CA_COMMIT=`git log --grep="$CA_COMMIT_MESSAGE" -n $MAX_COUNT --format=%H`

if [ -z "$CA_COMMIT" ]
then
      echo "Couldn't find commit that disabled code analysis."
else
      git rebase --onto $CA_COMMIT^ $CA_COMMIT
fi



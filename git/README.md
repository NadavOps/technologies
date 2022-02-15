Git
===========

<!--ts-->
  * [Git commands](#git-commands)
    * [Git config](#git-config)
    * [Git diff](#git-diff)
    * [Changing history](#changing-history)
    * [Git reset](#git-reset)
  * [Links](#links)
<!--te-->

Git commands
===

Git config
====
```
# set the user name and email
git config --global user.name "FIRST_NAME LAST_NAME"
git config --global user.email "MY_NAME@example.com"

git config --local user.name "FIRST_NAME LAST_NAME"
git config --local user.email "MY_NAME@example.com"
```
```
# set the remote origin URL
git remote set-url origin new.git.url/here
```

Git diff
====
```
git diff <unstaged_file>
git diff <branch_name> <branch_name2>
```

Changing history
===
```
git log; to find the desired commit
git rebase -i HEAD~3
git rebase -i <commit hash>
change the pick word
    s to squash
    edit to overall change
        while in edit it is possible to run:
        git commit --amend --author="Author user_name <email_address_include_brackets>"
```

Git reset
===
```
# taken from https://stackoverflow.com/questions/2845731/how-to-uncommit-my-last-commit-in-git
# the ^ character means the commit before, in our case the commit before the HEAD (can use hash commit instead)
git reset --soft HEAD^  -> uncommit
git reset HEAD^ -> Unstage
git reset --hard HEAD^ -> destroy work done 

# taken from https://stackoverflow.com/questions/7099833/how-to-revert-a-merge-commit-thats-already-pushed-to-remote-branch
git checkout your_branch_name
git reset <commit-hash-before-the-bad-one>
git reset --hard
```

Links
====
* [Set multiple ssh keys for multiple github accounts](https://gist.github.com/jexchan/2351996).
* [Changing history](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase).
* [Code academy git course](https://www.codecademy.com/learn/learn-git)
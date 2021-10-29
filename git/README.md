Git
===========

<!--ts-->
  * [Git config commands](#git-config-commands)
  * [Git diff commands](#git-config-commands)
  * [Changing history commands](#changing-history-commands)
  * [Links](#links)
<!--te-->

Git config commands
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

Git diff commands
====
```
git diff <unstaged_file>
git diff <branch_name> <branch_name2>
```

Changing history commands
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

Links
====
* [Set multiple ssh keys for multiple github accounts](https://gist.github.com/jexchan/2351996).
* [Changing history](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase).
* [Code academy git course](https://www.codecademy.com/learn/learn-git)
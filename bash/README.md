Bash
===========

<!--ts-->
  * [Process commands](#process-commands)
  * [Substrings](#substrings)
  * [References](#references)
  * [Links](#links)
<!--te-->

Process commands
====
Find process full command. [Taken from here](https://unix.stackexchange.com/questions/163145/how-to-get-whole-command-line-from-a-process).
```
process_full_command=$(ps -p [PID] -o args)
echo $process_full_command
```

Substrings
====
```
# Taken from https://github.com/bobbyiliev/introduction-to-bash-scripting/blob/main/ebook/en/content/008-bash-arrays.md
letters=( "A""B""C""D""E" ) 
echo "${letters:2:3}"  --> returns CDE
```

References
===
```
$?    --> last command status code
$@    --> all provided arguments
$0    --> the running script way to call its filename
$EUID --> Current userID (root user ID is 0)
```

Links
====
* [ShellCheck locally](https://github.com/koalaman/shellcheck)
* [jq manual](https://stedolan.github.io/jq/manual/)
* [Quiz API- to create a fun quiz tool](https://quizapi.io/docs/1.0/overview)
* [Parser for nginx/apache logs](https://github.com/bobbyiliev/introduction-to-bash-scripting/blob/main/ebook/en/content/020-nginx-and-apache-log-parser.md)
* [Sed Examples](https://linuxhint.com/50_sed_command_examples/#s43).
* [Conditional Expressions](https://github.com/bobbyiliev/introduction-to-bash-scripting/blob/main/ebook/en/content/009-bash-conditional-expressions.md)
* [Simple Case example](https://github.com/bobbyiliev/introduction-to-bash-scripting/blob/main/ebook/en/content/010-bash-conditionals.md#switch-case-statements)
* Shell Colors:
  * [Detailed #1](https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux).
  * [Detailed #2](https://unix.stackexchange.com/questions/148/colorizing-your-terminal-and-shell-environment).
  * [POSIX Compatability](https://unix.stackexchange.com/questions/461071/color-codes-for-echo-dont-work-when-running-a-script-over-ssh).
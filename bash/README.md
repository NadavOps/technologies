Bash
===========

<!--ts-->
  * [Process commands](#process-commands)
  * [Links](#links)
<!--te-->

Process commands
====
Find process full command. [Taken from here](https://unix.stackexchange.com/questions/163145/how-to-get-whole-command-line-from-a-process).
```
process_full_command=$(ps -p [PID] -o args)
echo $process_full_command
```

Links
====
* [Sed Examples](https://linuxhint.com/50_sed_command_examples/#s43).
* Shell Colors:
  * [Detailed #1](https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux).
  * [Detailed #2](https://unix.stackexchange.com/questions/148/colorizing-your-terminal-and-shell-environment).
  * [POSIX Compatability](https://unix.stackexchange.com/questions/461071/color-codes-for-echo-dont-work-when-running-a-script-over-ssh).
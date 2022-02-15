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
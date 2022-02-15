#!/bin/bash
# Find process full command. taken from https://unix.stackexchange.com/questions/163145/how-to-get-whole-command-line-from-a-process
process_full_command=$(ps -p [PID] -o args)
echo $process_full_command
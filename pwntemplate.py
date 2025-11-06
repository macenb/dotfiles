#!/usr/bin/env python3

from pwn import *

{bindings}

elf = context.binary = {bin_name}

gs = """
break main
continue
"""

# run with python3 solve.py REMOTE
if args.REMOTE:
    p = remote("IP/URL", 13337)

# run with python3 solve.py GDB
elif args.GDB:
    context.terminal = ["tmux", "splitw", "-h"]
    p = gdb.debug({bin_name}.path, gdbscript=gs)

# run with python3 solve.py
else:
    p = elf.process({proc_args}[1:])


### START HERE ###


p.interactive()

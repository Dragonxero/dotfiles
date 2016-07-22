#!/usr/bin/env python2.7

"""1-byte opcode list grouped by octet.

So, pretty much http://www.sandpile.org/x86/opc_1.htm but worse!

Requires: capstone, colorama (windows), click
"""
import capstone
import click
    
engine = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_32)

line = click.style(''.join(['\txx%01o' % c for c in range(8)]), bold=1)
for c in range(256):
    isn = list(engine.disasm(chr(c), 1))

    if not c&7: # high octets
        if line: click.echo(line)
        line = click.style('    %02ox ' % (c >> 3), bold=1)

    if len(isn) == 1: # 1-byte opcode found
        txt = isn[0].mnemonic + ' ' + isn[0].op_str
        if len(txt) >= 8: txt = isn[0].mnemonic
        line += click.style(txt, fg='green')
    elif len(isn) == 0: # check if it's a 2-byte opcode+arg
        guesses = [list(engine.disasm(chr(c) + chr(d), 1)) for d in range(256)]
        mnemonics = [g[0].mnemonic for g in guesses if len(g)>0]
        if len(set(mnemonics)) == 1: # all mnemonics the same
            line += click.style(mnemonics[0], 
                        fg='yellow' if len(mnemonics) == 256 else 'red')
        else: # couldn't disassemble a consistent opcode
            line += '-'
    line += '\t'

click.echo(line)
click.secho('\tno argument', fg='green')
click.secho('\thas argument', fg='yellow')
click.secho('\thas argument, couldn''t disasm some values', fg='red')



ANMachineAssembler
==================

This is a small command-line tool for assembling ANMachine programs using a custom, straight-forward assembly language. You can check out the main ANMachine repository [here](https://github.com/unixpickle/ANMachine).

Example
=======

Here is a sample Hello World program:

	set %1, message
	set %11, $1
	set %12, $0
	:printNext
	readreg %2, %1
	print %2
	cmp %2, %12
	je end
	add %1, %11
	ajmp printNext
	:message
	data %0x68 %0x65 %0x6C %0x6C %0x6F %0x2C %0x20 %0x77 %0x6F %0x72 %0x6C %0x64 %0x21 %0x00
	:end
	hlt

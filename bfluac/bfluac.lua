--Compiler args. Sort of...
local memLimit = (2^8) - 1
local memBlocks = 17
local dbgSleep = .005
local dbg = false
local printMem = false

local args = { ... }
local w, h = term.getSize()
local x, y = 0, 0;
local instCnt = 0
local semStr = " "
local memBlockStr = ""

local function interpet(code)
	print("Creating memory table...")
	for i = 1, memBlocks do
		memBlockStr = table.concat({memBlockStr, "0,"}, "")
	end

	local soFar = 1
	local o = fs.open(args[1] .. ".bf.lua", "w")
		print("Writing common vars...")
		o.writeLine([[
--CC bfluac!
local mem = {]] .. memBlockStr .. [[}
local ptr = 1;
]])

		if printMem then
			o.writeLine([[local memStr = ""]])
		end

		if yieldMore then
			semstr = "os.sleep(0)"
		end

		if dbg then
			print("Writing debug functions...")

			semstr = "drawMemory() sleep(" .. dbgSleep .. ") "
			o.writeLine([[
local w, h = term.getSize()
local x, y = 0, 0;
local drewInst = 0;

local function drawBFInst(c)
	x, y = term.getCursorPos()
	term.setCursorPos(1 + drewInst, h)
	drewInst = drewInst + 1

	if drewInst == w then
		term.clearLine()
		drewInst = 1
		term.setCursorPos(1, h)
	end
	write(c)
	term.setCursorPos(x, y)
end

local function drawMemory()
	x, y = term.getCursorPos()
	term.setCursorPos(1, h - 3)
	term.clearLine()
	term.setCursorPos(1, h - 2)
	for i = 1, #mem do
		if ptr == i then
			_x, _ = term.getCursorPos()
			term.setCursorPos(_x, h - 3)
			write("v")
			term.setCursorPos(_x, h - 2)
		end
		write(mem[i] .. ",")
	end
	term.setCursorPos(x, y)
end
drawMemory()
]])
		else
			o.writeLine([[local function drawBFInst(c) end --Unused]])
			semstr = " "
		end

		write("Interpeting: ")
		code:gsub(".", function(c)
			if c == ">" then
				o.writeLine(semstr .. " ptr = ptr + 1 drawBFInst('" .. c .. "')")
				write(c)
			elseif c == "<" then
				o.writeLine(semstr .. " ptr = ptr - 1 drawBFInst('" .. c .. "')")
				write(c)
			elseif c == "+" then
				o.writeLine(semstr .. " mem[ptr] = mem[ptr] + 1 if mem[ptr] >= " .. memLimit .. " then mem[ptr] = 0 + (mem[ptr] - " .. memLimit .. ") end drawBFInst('" .. c .. "')")
				write(c)
			elseif c == "-" then
				o.writeLine(semstr .. " mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = " .. memLimit .. " - mem[ptr] end drawBFInst('" .. c .. "')")
				write(c)
			elseif c == "." then
				o.writeLine(semstr .. " if mem[ptr] >= " .. memLimit .. " then mem[ptr] = 0 + (mem[ptr] - " .. memLimit .. ") end write(string.char(mem[ptr])) drawBFInst('" .. c .. "')")
				write(c)
			elseif c == "," then
				o.writeLine(semstr .. " mem[ptr] = read() drawBFInst('" .. c .. "')")
				write(c)
			elseif c == "[" then
				o.writeLine(semstr .. " while mem[ptr] ~= 0 do drawBFInst('" .. c .. "')")
				write(c)
			elseif c == "]" then
				o.writeLine(semstr .. " end drawBFInst('" .. c .. "')")
				write(c)
			end
		end)

		if dbg then
			write("\nAppending memory display cleaner...")
			o.writeLine([[local x, y = term.getCursorPos()
term.setCursorPos(1, h) term.clearLine()
term.setCursorPos(1, h - 2) term.clearLine()
term.setCursorPos(1, h - 3) term.clearLine()
term.setCursorPos(x, y)]])
		end
		if printMem then
			write("\nAppending memory printing...")
			o.writeLine([[for i = 1, #mem do
				memStr = memStr .. mem[i] .. ", "
			end
			print(memStr)]])
		end
		print("\nAppending source...")
		o.writeLine("-- Original: " .. code .. "")
	o.close()
	print("Done.")
end

if #args >= 1 then
	print("bfluac 1.0.0 by Admicos")
	print("Checking args...")
	for i = 1, #args do
		if args[i] == "-memLimit" then
			memLimit = tonumber(args[i + 1])
			i = i + 1
			print("memLimit set to " .. memLimit)
		elseif args[i] == "-memBlocks" then
			memBlocks = tonumber(args[i + 1])
			i = i + 1
			print("memBlocks set to " .. memBlocks)
		elseif args[i] == "-dbgSleep" then
			dbgSleep = tonumber(args[i + 1])
			i = i + 1
			print("dbgSleep set to " .. dbgSleep)
		elseif args[i] == "+dbg" then
			dbg = true
			print("Debugging turned on.")
		elseif args[i] == "-printMem" then
			printMem = true
			print("Memory printing turned on.")
		elseif args[i] == "-yieldMore" then
			yieldMore = true
			print("Yielding more...")
		end
	end

	local f = fs.open(fs.combine(shell.dir(), args[1]), "r")
		local code = f.readAll()
	f.close()

	interpet(code)
else
	print([[bfluac -- convert bf to lua

HOW TO USE
    bfluac.lua <file containing bf code> [extra arguments]
    This will save the lua code to <filename>.bf.lua

ARGUMENTS
    -memLimit <number> allows you the set maximum value of a memory block (default 28-1)
    -memBlocks <number> allows you the set how many memory blocks will be available for the program. Too low might cause crashes (default: 2^8-1)
    -dbgSleep <number> how many seconds should the program wait before executing the next instruction (debug only) (default: 0.005)
	-printMem prints bf memory at the end of program
	+dbg enables debug mode for the program]])
end

--CC bfluac!
local mem = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}
local ptr = 1;

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

drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  while mem[ptr] ~= 0 do drawBFInst('[')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  while mem[ptr] ~= 0 do drawBFInst('[')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  ptr = ptr - 1 drawBFInst('<')
drawMemory() sleep(0.005)  ptr = ptr - 1 drawBFInst('<')
drawMemory() sleep(0.005)  ptr = ptr - 1 drawBFInst('<')
drawMemory() sleep(0.005)  ptr = ptr - 1 drawBFInst('<')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  end drawBFInst(']')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  while mem[ptr] ~= 0 do drawBFInst('[')
drawMemory() sleep(0.005)  ptr = ptr - 1 drawBFInst('<')
drawMemory() sleep(0.005)  end drawBFInst(']')
drawMemory() sleep(0.005)  ptr = ptr - 1 drawBFInst('<')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  end drawBFInst(']')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  ptr = ptr - 1 drawBFInst('<')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  ptr = ptr - 1 drawBFInst('<')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] - 1 if mem[ptr] <= -1 then mem[ptr] = 255 - mem[ptr] end drawBFInst('-')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
drawMemory() sleep(0.005)  ptr = ptr + 1 drawBFInst('>')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  mem[ptr] = mem[ptr] + 1 if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end drawBFInst('+')
drawMemory() sleep(0.005)  if mem[ptr] >= 255 then mem[ptr] = 0 + (mem[ptr] - 255) end write(string.char(mem[ptr])) drawBFInst('.')
local x, y = term.getCursorPos() 
term.setCursorPos(1, h) term.clearLine()
term.setCursorPos(1, h - 2) term.clearLine()
term.setCursorPos(1, h - 3) term.clearLine()
term.setCursorPos(x, y)
--[[ Original: ++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.]]

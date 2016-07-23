local chatBox = peripheral.wrap("back")
local chatEvent = nil
local carg = nil
local ccmd = nil
local running = true
local admin = "Admicos"
local outBuf = ""

local function split(str, splitter)
  local t = {}
  local function helper(line) table.insert(t, line) return "" end
    helper((str:gsub("(.-)" .. splitter, helper)))
  return t
end

local function runbf(bfcode, sender)
  local bffile = fs.open(".bf-" .. sender, "w")
    bffile.write(bfcode)
  bffile.close()

  oWR = write
  oPR = print

  shell.run("bfluac .bf-" .. sender .. " -printMem -yieldMore")

  write = function(a) outBuf = outBuf .. a end
  print = function(a) chatBox.say(sender .. "> " .. outBuf) outBuf = a end

  chatBox.say("----RUNNING----")
  shell.run(".bf-" .. sender .. ".bf.lua")

  write = oWR
  print = oPR

  fs.delete(".bf-" .. sender .. ".bf.lua")
  fs.delete(".bf-" .. sender)

  chatBox.say(sender .. "> " .. outBuf)
  outBuf = ""

end

local function main()
  chatBox.setName("bfluac - Admicos")
  chatBox.say("bfluac chat edition started, have fun!")
  chatBox.say("\"__bf\" for more info")

  local log = fs.open("bfchat.log", "w")
  while running do
    chatEvent = {os.pullEvent("chat_message")}

    carg = split(chatEvent[4], " ")   --Command Args
    cprx = table.remove(carg, 1) --Chat prefix
    ccmd = table.remove(carg, 1) --Command

    if cprx == "__bf" then
      if carg == nil or ccmd == nil then
        log.writeLine("[" .. chatEvent[3] .. ":help]")
          chatBox.say("__bf <run> <bf code> --WIP")
      else
        log.writeLine("[" .. chatEvent[3] .. ":" .. ccmd .. "] " .. (unpack(carg) or ""))
        if ccmd == "stop" then
          if chatEvent[3] == admin then
            running = false
          else
            chatBox.say("Hey! You're not " .. admin .. "!")
          end
        elseif ccmd == "run" then
          runbf(carg[1], chatEvent[3])
        else
          chatBox.say(ccmd .. " is not a bfluac command")
        end
      end
    end

   -- print(chatEvent[3] .. "> " .. chatEvent[4])
  end
  log.close()
  chatBox.say("Goodbye!")
end main()

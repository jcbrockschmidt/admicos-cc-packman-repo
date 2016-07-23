local chatBox = peripheral.wrap("back")
local chatEvent = nil
local carg = nil
local ccmd = nil
local running = true
local admin = "Admicos"
local outBuf = ""
local oWR = write
local oPR = print

local function split(str, splitter)
    local t = {}
    local function helper(line) table.insert(t, line) return "" end
    helper((str:gsub("(.-)" .. splitter, helper)))
    return t
end

local function safeString(text)
   local newText = {}
   for i = 1, #text do
       local val = text:byte(i)
       newText[i] = (val > 31 and val < 127) and val or 63
   end
   return string.char(unpack(newText))
end



local function runbfraw(sender)
    loadfile(".bf-" .. sender .. ".bf.lua")()
end

local function compilebf(sender)
    shell.run("bfluac .bf-" .. sender .. " -printMem -yieldMore")

    chatBox.say("----RUNNING----")

    write = function(a) outBuf = outBuf .. a end
    print = function(a)
        chatBox.say("§6" .. sender .. "> §f" .. safeString(outBuf))
        --chatBox.say("|6" .. sender .. "> |f" .. safeString(outBuf))
        outBuf = a
    end

    local ok, err = pcall(runbfraw, sender)

    write = oWR
    print = oPR

    if not ok then
        errMsg = split(err, ":")
        errMsg = errMsg[#errMsg]

        chatBox.say(("§6" .. sender .. ">§c" .. errMsg):gsub(" ", "§c "))
        if term.isColor() then term.setTextColor(colors.red) end
        print(err)
        if term.isColor() then term.setTextColor(colors.white) end
    else
        chatBox.say("§6" .. sender .. "> §f" .. safeString(outBuf))
        --chatBox.say("|6" .. sender .. "> |f" .. safeString(outBuf))
        outBuf = ""
    end

    fs.delete(".bf-" .. sender .. ".bf.lua")
    fs.delete(".bf-" .. sender)
end

local function runbfpaste(paste, sender)
    local pastefile = http.get("http://pastebin.com/raw/" .. textutils.urlEncode(paste))
        if not pastefile then
            chatBox.say("§6" .. sender .. ">§c Paste: " .. paste .. " not found!")
            return;
        end

        local bfcode = pastefile.readAll()
    pastefile.close()

    local bffile = fs.open(".bf-" .. sender, "w")
        bffile.write(bfcode)
    bffile.close()
    compilebf(sender)
end

local function runbf(bfcode, sender)
    local bffile = fs.open(".bf-" .. sender, "w")
        bffile.write(bfcode)
    bffile.close()
    compilebf(sender)
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
                chatBox.say("__bf <run OR runpaste> <bf code OR paste code> --Mostly done at this point")
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
                elseif ccmd == "runpaste" then
                    runbfpaste(carg[1], chatEvent[3])
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

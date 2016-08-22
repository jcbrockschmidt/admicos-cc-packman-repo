local repos = nil
local w, h = term.getSize()

local function check(args)
    if args == nil then --viewing help
        return false
    elseif args["get-dir"] == nil then
        print("\"pachax -h\" for help.")
        return false
    end

    return true
end

local function repo_parsefile(repofilepath)
    if repofilepath == nil then repofilepath = "/etc/repolist" end

    if not repos then
        local rf = fs.open(repofilepath, "r")
            repos = rf.readAll()
        rf.close()

        local repos_ = stringStuff.split(repos, "\n")
        repos = {}
        for i = 1, #repos_ do
            local k = stringStuff.split(repos_[i], " ")
            repos[k[1]] = k[2]
        end
    end

    return repos
end

local function repo_geturl(repo)
    for k, v in pairs(repo_parsefile()) do
        if k == repo then return v end
    end

    return false
end

local function repo_get_package_files(rurl, package)
    --print(rurl .. "/" .. package .. "/files.phx")
    local pkg_req = http.get(rurl .. "/" .. package .. "/files.phx")
    local fileList = nil
    if pkg_req == nil then
        error([[A connection error occured. This might be due to:

* A issue with the connection
* The package doesn't have a file list
* The repo layout isn't configured for pachax
* The package doesn't exist]])
    else
        fileList = pkg_req.readAll()
        pkg_req.close()
    end

    local _l = stringStuff.split(fileList, "\n")
    local type = table.remove(_l, 1)
    local lines = {}
    local targets = {}
    for i = 1, #_l do
        local spl = stringStuff.split(_l[i], " ")

        lines[i] = spl[1]
        targets[i] = spl[2]
    end

    return type, lines, targets
end

local function repo_download_url(url, fname)
    local downloaded = http.get(url)
        if not fs.isDir(fs.getDir(fname)) then fs.makeDir(fs.getDir(fname)) end
        if not downloaded then error("Cannot download url:\n" .. url) end

        if not fs.exists(fname) then fs.delete(fname) end
        local saved = fs.open(fname, "w")
            if not saved then error("Cannot save file:\n" .. fname) end

            saved.write(downloaded.readAll())
        saved.close()
    downloaded.close()
end

local function repo_download_url_list(urls, targets)
    print(#urls .. " files are downloading...")
    for i = 1, #urls do
        print("[" .. i .. "/" .. #urls .. "] ..." .. targets[i] .. " => " .. targets[i])
        repo_download_url(urls[i], targets[i])
    end
end

local function repo_download_files(rurl, package, files, target)
    for i = 1, #files do
        print("[" .. i .. "/" .. #files .. "] " .. files[i] .. " => " .. target[i] .. "/" .. files[i])
        repo_download_url(rurl .. "/" .. package .. "/" .. files[i], target[i])
    end
end

local function main(args)
    if not check(args) then return end

    local pkg = stringStuff.split(args["get-dir"], "/")
    local repo_url   = repo_geturl(pkg[1])
    local repo_url_s = stringStuff.split(repo_url, "/")

    repo_url = repo_url:sub(1, -(#repo_url_s[#repo_url_s] + 1))
    if not repo_url then
        error(pkg[1] .. " is not a packman repo!")
    end

    local ftype, files, targets = repo_get_package_files(repo_url, pkg[2])

    if ftype == "list" then
        repo_download_files(repo_url, pkg[2], files, targets)
    elseif ftype == "url" then
        repo_download_url_list(files, targets)
    else
        error("file list is incorrect!")
    end
end

if not getopt then os.loadAPI("getopt") end
if not stringStuff then
    stringStuff = {}
    stringStuff.split = function(str, splitter)
    	local t = {}
    	local function helper(line) table.insert(t, line) return "" end
    		helper((str:gsub("(.-)" .. splitter, helper)))
    	return t
    end
end

main(getopt.init("pachax", "Some utilities to use with packman repos.", {
	["get-dir"] = {"Get directory from repo", "d", "repo/package"},
}, { ... }))

api_version = "1.12.0.0"

local gmatch, lower = string.gmatch, string.lower

------------- Discord Webhook Link -------------
local url = "LINK WEBHOOK";

------------- Port from your server -------------
local port = "2313";

--DLL import DWebhooks.dll
ffi = require("ffi")
ffi.cdef[[
int sendMessage(const char *url, const char *username, const char *team, const char *message);
int commandUsage(const char* url, const char* admin, const char* command, const char* objetive, const char* reason, const char* port);
int commandReport(const char* url, const char* user, const char* message, const char* port);
]]
http_client = ffi.load("DWebhooks.dll")

function OnScriptLoad()
	register_callback(cb["EVENT_COMMAND"], "ChatCommand")
end

local function Split(cmd)
    local Args = { }
    for Params in gmatch(cmd, "([^%s]+)") do
        Args[#Args + 1] = lower(Params)
    end
    return Args
end

local function IsAdmin(Ply, level)
    return (tonumber(get_var(Ply, "$lvl")) >= level) or (Ply == 0)
end

function ItsMe(Admin, Ply)
    if Admin == Ply then
		return true
	else
		return false
	end
end

function ChatCommand(Ply, MSG, _, _)
        local Args = Split(MSG)
        if (Args) then
			if (Args[1] == "r") then
				if IsAdmin(Ply, -1) and (Args[2]) then
					local y = table.concat(Args, " ", 2)
					y = string.gsub(y, '%"', "'")
					cprint("Report "..http_client.commandReport(url, get_var(Ply, "$name"), y, port))
					rprint(Ply, "Report sended Successfully! ["..y.."]")
					return false
				end
			end
			if Args[1] == "timeban" then
				if IsAdmin(Ply, 2) and (Args[2]) and (Args[3]) then
					if ItsMe(Ply, Args[2]) == false then
						local y = table.concat(Args, " ", 3)
						y = string.gsub(y, '%"', "")
						cprint("Embed "..http_client.commandUsage(url, get_var(Ply, "$name"), "timeban", get_var(Args[2], "$name"), y, port))
						return false
					end
				elseif IsAdmin(Ply, 2) and (Args[2]) then
					if ItsMe(Ply, Args[2]) == false then
						local y = table.concat(Args, " ", 3)
						y = string.gsub(y, '%"', "")
						cprint("Embed "..http_client.commandUsage(url, get_var(Ply, "$name"), "timeban", get_var(Args[2], "$name"), "**Without Reaseon**", port))
						return false
					end
				end
			elseif Args[1] == "timemute" then
				if IsAdmin(Ply, 2) and (Args[2]) and (Args[3]) then
					if ItsMe(Ply, Args[2]) == false then
						local y = table.concat(Args, " ", 3)
						y = string.gsub(y, '%"', "")
						cprint("Embed "..http_client.commandUsage(url, get_var(Ply, "$name"), "timemute", get_var(Args[2], "$name"), y, port))
						return false
					end
				elseif IsAdmin(Ply, 2) and (Args[2]) then
					if ItsMe(Ply, Args[2]) == false then
						local y = table.concat(Args, " ", 3)
						y = string.gsub(y, '%"', "")
						cprint("Embed "..http_client.commandUsage(url, get_var(Ply, "$name"), "timemute", get_var(Args[2], "$name"), "**Without Reaseon**", port))
						return false
					end
				end
			elseif Args[1] == "k" then
				if IsAdmin(Ply, 2) and (Args[2]) and (Args[3]) then
					if ItsMe(Ply, Args[2]) == false then
						local y = table.concat(Args, " ", 3)
						y = string.gsub(y, '%"', "")
						cprint("Embed "..http_client.commandUsage(url, get_var(Ply, "$name"), "k", get_var(Args[2], "$name"), y, port))
						return false
					end
				elseif IsAdmin(Ply, 2) and (Args[2]) then
					if ItsMe(Ply, Args[2]) == false then
						local y = table.concat(Args, " ", 3)
						y = string.gsub(y, '%"', "")
						cprint("Embed "..http_client.commandUsage(url, get_var(Ply, "$name"), "k", get_var(Args[2], "$name"), "**Without Reaseon**", port))
						return false
					end
				end
			elseif Args[1] == "freeze" then
				if IsAdmin(Ply, 3) and (Args[2]) and (Args[3]) then
					if ItsMe(Ply, Args[2]) == false then
						local y = table.concat(Args, " ", 3)
						y = string.gsub(y, '%"', "")
						cprint("Embed "..http_client.commandUsage(url, get_var(Ply, "$name"), "freeze", get_var(Args[2], "$name"), y, port))
						return false
					end
				elseif IsAdmin(Ply, 3) and (Args[2]) then
					if ItsMe(Ply, Args[2]) == false then
						local y = table.concat(Args, " ", 3)
						y = string.gsub(y, '%"', "")
						cprint("Embed "..http_client.commandUsage(url, get_var(Ply, "$name"), "freeze", get_var(Args[2], "$name"), "**Without Reaseon**", port))
						return false
					end
				end
			end
        end
end
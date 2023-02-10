--[[
util.AddNetworkString("FSendToClient") 
util.AddNetworkString("FSendToServer")
]] 
--[[ 
    Добавляет указанную string(строку) в table(таблицу), которая автоматически кэширует ее 
    и передает по сети всем клиентам.
    Всякий раз, когда нужно создать сетевое сообщение с помощью net.Start, надо добавить имя
    этого сообщения в виде сетевой строки с помощью этой функции.
    Каждое уникальное сетевое networ(сетевое) name(имя) необходимо объявить один раз -
    не помещайть вызов функции ни в какие другие функции, если используется постоянная строка.
]]
print("sv_weapons загружен")
--[[
local function SendToClient()
    
    local tabletest = {
        "Sol",
        "Bad",
        "Guy",
        45,
    }
    
    net.Start("FSendToClient")
        net.WriteString("Sol")
        net.WriteTable(tabletest)
    net.Broadcast() -- отправляет всем клиентам
   -- net.Send( ply ) -- отпровляет игроку
end

net.Receive( "FSendToServer", function()
    local ply = net.ReadEntity() -- принимание отосланное значение
    print(ply)
    local name = net.ReadString()
    print(name)
end)

hook.Add( "PlayerSay", "FSend", function( ply, text, public )
    if (string.lower(text) == "send") then
        SendToClient()
        return ""
    end
end)
]]

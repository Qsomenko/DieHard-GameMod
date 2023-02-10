util.AddNetworkString("open_lobby") -- функция библиотеки util.
util.AddNetworkString("start_game") -- создаем ссылку/имя для обмена данными между файлами

local chekopen = 0

function enterLobby() -- открывает derma на клиенте если игрок заспавнился, активация по hook
    if chekopen >= 1 then return end
    net.Start("open_lobby")
    net.Broadcast()
    chekopen = chekopen + 1
end


net.Receive("start_game", function(len, ply) -- добавлены аргументы
    
    beginRound() -- После активации игроком кнопки в лобби спавна на сервер передоется сигнал для функции старта игры, которая в файле round
    ply:GiveLoadout() -- функция в init
end)

hook.Add("PlayerInitialSpawn", "Openplayerlobby", enterLobby) -- когда игрок спавнится

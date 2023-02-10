--[[
    в папке gamemodes/ должно быть всего три файла:
    cl.init.lua
    init.lua -- запускается первым
    shared.lua
]]

util.AddNetworkString( "f4menu" ) -- панель кнопки F4 - cl_menumr
util.AddNetworkString( "SayPlayerF" ) -- панель диалогов - cl_caht_f

--[[
    GM: -- хуки, доступные для всех игровых режимов на основе базового игрового режима.
]]
-- поставить на загрузку клиенту:
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua") 
-- Поставить на загрузку другие скрипты
AddCSLuaFile("round_controller/cl_round_controller.lua") -- надо проверять верность написание 
AddCSLuaFile("lobby_manager/cl_lobby.lua")
AddCSLuaFile("lobby_manager/Weapon_cheack/cl_FLoadout.lua")
AddCSLuaFile("Menu_manager/cl_menumr.lua")
AddCSLuaFile("vgui/menu_main.lua")
AddCSLuaFile("vgui/Vox_menu_panel.lua")
AddCSLuaFile("chat_manager/cl_chat_F.lua")
AddCSLuaFile("playerstats.lua")
AddCSLuaFile("cl_scoreboard.lua") 
-- Подключить серверу файлы:
include("shared.lua")
include("round_controller/sv_round_controller.lua")
include("lobby_manager/sv_lobby.lua")
include("chat_manager/sv_chat_F.lua")
include("lobby_manager/Weapon_cheack/sv_FLoadout.lua")
include("Team_manager/teamsetup.lua")
include("playerstats.lua")

--[[
    -- Добавляет регенерацию здоровья после спавна 
function GM:PlayerSpawn( ply )
    timer.Create( "HPregen" .. ply:UserID(), 1, 10, function() -- для индификаци персонально к игроку клиенту добавлен ID
        
        ply:SetHealth( math.Clamp(ply:Health() + 1, 0, ply:GetMaxHealth() ) ) -- функция "лечения"
        -- "HPregen" .. ply:UserID() - название таймера
        PrintMessage( HUD_PRINTTALK, "Reps Left: " .. timer.RepsLeft( "HPregen" .. ply:UserID() ) )
        PrintMessage( HUD_PRINTTALK, "Time Left Next Rep: " .. timer.TimeLeft( "HPregen" .. ply:UserID() ) )

        -- функции timer.RepsLeft; timer.TimeLeft - возвращают значение цифровое

    end)
    
    timer.Simple( 11, function() PrintMessage( HUD_PRINTTALK, ply:Name()) end)

    -- timer.Pause( "HPregen" .. ply:UserID() ) -- приостановить
    -- timer.UnPause( "HPregen" .. ply:UserID() ) --
    -- timer.Toggle( "HPregen" .. ply:UserID() ) -- запустить

    timer.Adjust( "HPregen" .. ply:UserID(), 2, 0, function()
        ply:SetHealth( math.Clamp(ply:Health() + 1, 0, ply:GetMaxHealth() ) )
    end )
    
end

function GM:PlayerDisconnected( ply )
    -- Exists(Существует); timer.Exists() - фукция проверка на существование
    if( timer.Exists( "HPregen" .. ply:UserID() ) ) then
        timer.Remove( "HPregen" .. ply:UserID() )
    end
    
end
]]
--[[
function GM:PlayerSpawn( ply )
    if getRoundStatus() >= 1 then
        return true
    end
    GAMEMODE:PlayerSpawnAsSpectator( ply )
end
]]
-- _____________________
-- Loadout:

local statWeapon = {
    "arccw_bo1_uzi",
    "arccw_bo1_kiparis",


} -- таблица с оружием

local ply = FindMetaTable("Player") -- присвоить переменной ply значение из метатаблицы(таблицы игрока)

function ply:GiveLoadout() -- имя функции переменная? 
    
    self:Give(statWeapon[math.random(1, table.Count(statWeapon))])
    --[[
    for k, v in pairs(statWeapon) do -- таблица оружия выше
        self:Give(v) -- аргумент в скобках "v" - variables(переменная); в переменной v значение из табилцы statWeapon
    end
    ]]
    self:SetupTeam( math.random( 0,1 ) )
end
-- _____________________

-- Нажатие клавишь и функции

function GM:ShowHelp( ply ) -- предположительно кнопка F1
    ply:SetHealth( math.Clamp( ply:Health() + 25, 0, ply:GetMaxHealth() ) )
    ply:SetArmor( math.Clamp( ply:Armor() + 25, 0, ply:GetMaxArmor() ) )
end

function GM:ShowTeam( ply )
    
    ply:SetHealth( ply:Health() - 50 ) -- присвоить здроровье в размере текущего здоровья мину 50
    if( ply:Health() <= 0) then
        ply:Kill()
    end

end

function GM:ShowSpare1( ply )
    print(" Press ShowSpare1, " .. ply:Nick() ) -- Press нажать
end

function GM:ShowSpare2( ply ) -- активатор F4
    net.Start( "f4menu" )
    net.Send( ply ) -- отправляем игроку, который активировал
end

function GM:KeyPress( ply, key ) -- хук получает значения игрока и кнопку, которую нажали
   
    if( key == IN_JUMP ) and ply:Team() == 1 then  
        ply:SetVelocity( ply:GetVelocity() + Vector( 0, 0, 1000 ) )
    elseif( key == IN_DUCK ) then
        -- ply:EmitSound( "vo/Citadel/br_laugh01.wav") -- то что нужно для функции чатсай(когда командой в чате можно вызвать звук)
        net.Start( "SayPlayerF" )
        net.Send( ply )
    end
end

-- _____________________
--[[
-- еще варианты lodout:
function GM:PlayerLoadout( pl ) -- GM: - что-то из таблицы, которую может прочитать файл init.lua
    pl:Give("weapon_pistol") -- переменная pl получает значение из таблицы; :Give функция доступная для таблцы player
    pl:Give("weapon_smg1")
    pl:Give("weapon_crowbar")
    
    pl:GiveAmmo(111, "pistol")
    pl:GiveAmmo(111, "smg1")

end
]] 
-- _____________________
--[[
    Тут используем "Hook Add" метод:
function SpawnF( ply )
    ply:ChatPrint( "You have spawned!")
end
hook.Add("PlayerSpawn", "hookname", SpawnF)
]]
-- _____________________
--[[
    Preferred Method:
function GM:PlayerSpawn( ply )
    ply:ChatPrint( "You have spawned!")
end
]]
-- _____________________
--[[
-- Два метода передачи аргументов:
function ply:heal()
    print( self:Name() .. " has been healed!")
    self:SetHealt( self:GetMaxHealth() )
end
--
function GM:PlayerSpawn( plys ) 
    ply:Heal()
end
]]
--[[
function GM:PlayerShouldTakeDamage( ply, attacker )
    
    local att -- обьявление пустой переменной(variable)
    if ( attacker:IsPlayer() ) then
        att = attacker
        elseif( attacker:IsNPC() ) then
            return true -- если true значит урон пройдет
        elseif( attacker:IsWorld() ) then
            return true
        else
            att = attacker:GetOwner()
    end

    if( ply:Team() == att:Team() ) then
        return false -- если игроки из одной команды, то урона не будет
    end

    return true -- в любом другом случае урон (возврта истины)

end
]]

function GM:PlayerDeath( ply ) -- если игрок умирает, то он получает 55 опыта
    ply:StatsAddXp( 55 ) -- функцию можно вызвать в любом месте и указать аргумент с нужным значением
end

-- _____________________
--[[
function GM:PlayerCanSeePlayersChat( text, teamOnly, listener, speaker)
    -- функция срабатывает за счет возврата значений
    local dist = listener:GetPos():Distance( speaker:GetPos() )

    if( dist <= 200 ) then
        print( "You have been heard.")
        return true -- прерывает функцию; возврат истины
    end
    -- часть вне условия, а в функции
    print( "You have not been heard.")
    return false
end
]]



net.Receive( "ClientMsg", function( len, ply )
    local srt = net.ReadString()
    print( str )
end )

-- _____________________
-- Простые функции:
function GM:PlayerConnect(name, ip) -- ип адрес подключившегося игрока
    print("Player " .. name .. " connected with IP (" .. ip ..")")
end

function GM:PlayerInitialSpawn( ply ) -- имя подключившегося игрока
    print("Player " .. ply:Name() .. " has spawned")
    ply:StatsLoad() -- функция загрузски данных
    -- ply:SetNWInt( "Level", ply:GetNWInt( "Level" ) + 2 ) -- каждый раз при подключение + 1 уровень
    print( "Level: " .. ply:GetNWInt( "Level" ) )
    print( "XP: " .. ply:GetNWInt( "XP" ) )
end

function GM:PlayerDisconnected( ply )
    ply:StatsSave() -- функция сохранения данных если игрок отлючился( если сервер(ушел с сервера))
end
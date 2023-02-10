-- Подключить основные файлы:
include("shared.lua")
-- Подключить дополнительные файлы:
include("round_controller/cl_round_controller.lua")
include("lobby_manager/cl_lobby.lua")
include("lobby_manager/Weapon_cheack/cl_FLoadout.lua")
include("Menu_manager/cl_menumr.lua")
include("vgui/menu_main.lua")
include("vgui/Vox_menu_panel.lua")
include("chat_manager/cl_chat_F.lua")
include("cl_scoreboard.lua") 

-- Font
surface.CreateFont( "MyFont", {
    font = "Arial",
    size = 30,
    weight = 500,
} ) -- если создать здесь, то будет виден в других файлах? 
-- ________________

--[[
function GM:HUDShouldDraw( name ) -- отключение hud default
    local hud = {
        "CHudHealth",
        "CHudBattery",
    }
    for k, element in pairs( hud ) do
        if name == element then return false end
    end
    return true -- если либой другой бар возвращает истину

end
]]

net.Receive( "ServerMsg", function( len ) -- ServerMsg - Это индификатор
    
    local str = net.ReadString() -- присвоить значение полученное из функции считывания стрингового значения
    -- надо соблюдать порядок получения 
    local num = net.ReadInt( 12 ) 
    local bool = net.ReadBool()
    if( bool ) then return end
    
    print( str .. num .. ".")
    

end)
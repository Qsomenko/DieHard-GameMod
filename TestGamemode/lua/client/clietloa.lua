print('clietn loa loading')
--[[
function RaudeBoxHook()
    draw.RoundedBox( 8, 5, ScrH()-105, 250, 100. Color(0, 0, 0, 100))
end
hook.Add("HUDPaint", "any identifier", RaudeBoxHook())
]]

surface.CreateFont( "MyFont2", {
    font = "Arial",
    size = 100,
    weight = 500,
} ) -- создание шрифта

local message = "Sol say Text"

-- ScrW() -- фукнция 

hook.Add( "HUDPaint", "anyidentifier", function()
    -- расположение draw.RoundedBox определяет их порядок отображения
    -- draw.RoundedBox( 5, ScrW()-100, ScrH()-100, 127, 127, Color(0, 150, 0, 100)) -- целеный квадрат
    -- draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color(105, 0, 0, 59)) -- сильно прозначный красный экран
    -- draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), Color( math.Rand(0, 255), math.Rand(0, 255), math.Rand(0, 255), 50)) -- мерцание экрана

    draw.SimpleText("SimpleText", "Default", ScrW()/2, ScrH()/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    -- TEXT_ALIGN_CENTER - выравнивает по центру, потому что без этих параметров немного криво

    surface.SetAlphaMultiplier( 1 ) -- переключение альфа(прозрачности текста)

    surface.SetDrawColor( 200, 200, 100, 125 )

    surface.DrawOutlinedRect( 10, 10, 100, 100 ) -- квадрат из линий
    surface.DrawCircle( 120, 60, 50, Color( 100, 200, 200, 125 ) )
    surface.DrawLine( 230, 10, 330, 110 )
    surface.DrawRect( 110, 10, 100, 100 )

    surface.SetTexture( 2 )
    surface.DrawTexturedRect( 10, 120, 100, 100 )

    local width, height = surface.GetTextSize( message ) -- Get(получить)

    surface.SetFont( "MyFont2" )
    surface.SetTextPos( ScrW()/2 - width/2, ScrH()/2 - height/2 )
    surface.SetTextColor( 100, 100, 200, 125)
    surface.DrawText( message )
    
end)

local function fHUDhide( myhud )
    for k, v in pairs{ "CHudHealth", "CHudBattery", "CHudAmmo" } do
        if myhud == v then return false end
    end 

end

hook.Add("HUDShouldDraw", "HudHide", fHUDhide)

local x = 15
local y = ScrH() - 150


surface.CreateFont("123firsfong", { 
    font = "CloseCaption_Bold", 
    size = 20,
    weight = 600
} )

--[[
local function firsHud()
    local ply = LocalPlayer() -- записываем таблюцу игрока в переменную
    local hp = ply:Health() or 0 -- значение из таблицы игрока записываем в другую переменную
    local maxhp = ply:GetMaxHealth() or 0
    local arm = ply:Armor() or 0
    local nameT = ply:Name()

    local FFAtime = CurTime()

    draw.RoundedBox( 3, x-10, y-30, 220, 180, Color( 14, 73, 19, 140) )

    draw.RoundedBox( 3, x, y+75, 200, 45, Color( 14, 73, 19, 180) )
    draw.RoundedBox( 3, x, y+5, 200, 45, Color( 14, 73, 19, 180) )

    if hp <=100 then
        draw.RoundedBox( 2, x+x2, y+y2, math.Clamp(hp, 0, 180)*1.8, 30, Color( 212, 23, 23, 235) )
    else
        draw.RoundedBox( 2, x+x2, y+y2, 180, 30, Color( 212, 23, 23, 235) )
    end
    draw.RoundedBox( 2, x+x2, y+y2, 180, 30, Color( 138, 133, 133, 100) )


    draw.RoundedBox( 2, x+x2, y+y3, 180, 30, Color( 14, 71, 177, 235) )
    draw.RoundedBox( 2, x+x2, y+y3, 180, 30, Color( 138, 133, 133, 100 ) )
    
   

    draw.SimpleText( "HP: " .. hp .. '/' .. maxhp, "123firsfong", x+25, y+10, Color( 141, 29, 29), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText( "AR: " .. arm, "123firsfong", x+25, y+80, Color( 89, 55, 168), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText( nameT, "123firsfong", x+100, y+120, Color( 104, 24, 24), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    draw.SimpleText( "Time: " .. FFAtime, "123firsfong", x+80, y+40, Color( 18, 47, 128), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end

hook.Add( "HUDPaint", "firsthud", firsHud)
]]
--[[

hook.Add( "OnPlayerChat", "UNIQUEIDENT", function( ply, str, bteam, bdead )
    str = string.lower( str )
    if( str == "/print") then
        print( "Heeeeyyy Sol!!!1" )
        return true
    end
end)
]]

hook.Add( "OnPlayerChat", "UNIQUEIDENT", function( ply, str, bteam, bdead )
    
    if( string.lower( str ) == "/msg" ) then
        
        net.Start( "ClientMsg" ) -- начало 
            net.WriteString( "Hey server!1!")
        net.SendToServer() -- конец

        return true

    end

end)

hook.Add( "HUDPaint", "HUDIdent", function()
   
    local plyx = LocalPlayer() 
        local hp = plyx:Health() or 0 
        local maxhp = plyx:GetMaxHealth() or 0
        local arm = plyx:Armor() or 0
        local maxarm = plyx:GetMaxArmor() or 0
        local nameT = plyx:Name()

    surface.SetDrawColor( 50, 50, 50, 255 ) -- цвет будет присвоин ко всему созданому ниже
    --[[
    for i = 1, 11 do -- цикл создающий текстуры за счет умнажения значения на значение из переменной i
        surface.SetTexture( i )
        surface.DrawTexturedRect( 10 + 100 * i, 10, 100, 100 )
        surface.SetTexture( 11 + i )
        surface.DrawTexturedRect( 10 + 100 * i, 110, 100, 100 )
        surface.SetTexture( 22 + i )
        surface.DrawTexturedRect( 10 + 100 * i, 210, 100, 100 )
        surface.SetTexture( 33 + i )
        surface.DrawTexturedRect( 10 + 100 * i, 310, 100, 100 )
        surface.SetTexture( 44 + i )
        surface.DrawTexturedRect( 10 + 100 * i, 410, 100, 100 )
        surface.SetTexture( 55 + i )
        surface.DrawTexturedRect( 10 + 100 * i, 510, 100, 100 )
    end
    ]]

    
    
    

    -- ХП бар:
    surface.DrawRect( 30 -2, ScrH() - 170 - 2, 300 + 4, 30 + 4)
    
    surface.SetDrawColor( 190, 35, 35)
    surface.SetTexture( 10 )
    surface.DrawTexturedRect( 30, ScrH() - 170, 300 * ( hp / maxhp ), 30 )
    --_____________
    -- Броня:
    surface.SetDrawColor( 50, 50, 50, 255 ) 
    surface.DrawRect( 30 -2, ScrH() - 70 - 2, 300 + 4, 30 + 4)
   
    surface.SetDrawColor( 35, 76, 190)
    surface.SetTexture( 10 )
    surface.DrawTexturedRect( 30, ScrH() - 70, 300 * ( arm / maxarm ), 30 )

    draw.SimpleText( "HP: " .. hp .. '/' .. maxhp, "123firsfong", 35, ScrH() - 171, Color( 165, 158, 158), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText( "AR: " .. arm, "123firsfong", 35, ScrH() - 71, Color( 178, 178, 179), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText( nameT, "123firsfong", 30, ScrH() - 40, Color( 104, 24, 24), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

end)
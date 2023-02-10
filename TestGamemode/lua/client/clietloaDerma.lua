print('clietn derma loade')

local x = 10
local y = 10

surface.CreateFont("Font1", { 
    font = "Open Sans Bolt", 
    size = 20,
    weight = 600
} )
--
local function createMyDerma()
	
	local Frame = vgui.Create( "DFrame" )
	Frame:SetPos( 25, 425 ) 
	Frame:SetSize( 225, 350 )
	Frame:SetTitle( "UserCommand" ) 
	Frame:SetVisible( true ) 
	Frame:SetDraggable( false ) 
	Frame:ShowCloseButton( false ) 
	Frame:MakePopup()
-- Первая кнопка
		local Button1 = vgui.Create("DButton", Frame)
		Button1:SetText( "Help" )
		Button1:SetTextColor( Color(255,255,255) )
		Button1:SetPos( x+10, y+25 )
		Button1:SetSize( 100, 30 )
		Button1.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 23, 34, 41, 250) ) -- Draw a blue button
		end
		Button1.DoClick = function()
			print( "Button clicked!" )
		end
-- Вторая кнопка
		local Button2 = vgui.Create("DButton", Frame)
		Button2:SetText( "Test" )
		Button2:SetTextColor( Color(255,255,255) )
		Button2:SetPos( x+10, y+65 )
		Button2:SetSize( 100, 30 )
		Button2.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 23, 34, 41, 250) ) -- Draw a blue button
		end
		Button2.DoClick = function()
			print( "Button clicked!" )
			RunConsoleCommand( "kill" )
		end
end

--[[
local function Frame_open()
	Frame:SetVisible(true)
end
 
local function Frame_close()
	Frame:SetVisible(false)
end
]]--
--concommand.Add("-our_concommand", Frame_close)
--concommand.Add("+our_concommand", Frame_open)
--concommand.Add( "DermaCM", createMyDerma) -- создал консольную команду для вызова функции VGUI
-- timer.Simple(15, function() RunConsoleCommand( "DermaCM" ) end) -- таймер вызова консольной команды
-- usermessage.Hook( "call_vgui", createMyDerma ) -- не понял для чего это

-- hook.Add("Initialize","frame_create", createMyDerma) -- инициация дерма на старте 
local w = ScrW() / 2
local h = ScrH() / 2


function openLobby() -- функция срабатывает через net.Receive при событии, которое можно зафиксировать только на сервеной стороне
 
    print("recevied")

    local backframe = vgui.Create("DFrame")
    backframe:SetSize(ScrW(), ScrH())
    backframe:Center()
    backframe:SetVisible(true)
    backframe:ShowCloseButton(false)
    backframe:SetDraggable(false)
    backframe:SetTitle("")
    backframe.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color( 23, 51, 29))
    end

    backframe:MakePopup() -- поверх других окон

    local frame = vgui.Create("DFrame", backframe) -- прикрепил к панели позади
    frame:SetSize(w, h)
    frame:Center()
    frame:SetVisible(true)
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)
    frame:SetTitle("")
    frame.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color( 51, 165, 76))
    end

    frame:MakePopup()

    local startBut = vgui.Create("DButton", frame)
    startBut:SetSize( 200, 75 )
    startBut:SetPos(w/2 - 100, h/2 - (75/2))
    startBut:SetText("Test_Start_Game_Test_SetText")
    startBut.DoClick = function() -- по нажатию кнопки данные отсылаются на клиент в другой фаил
        
        net.Start("start_game")
        net.SendToServer()

        -- frame:Close() -- закрытие панели
        backframe:Close() -- теперь достаточно закрыть ключевую панель
        timer.Simple(10, FOpenLoadout)
    end
    
    local FPanel = vgui.Create("DLabel", backframe)
    FPanel:SetPos( 20, 20 )
    FPanel:SetText( "Hey, baybe!")
    FPanel:SetTextColor(Color(194, 71, 71))

end

net.Receive("open_lobby", openLobby) -- принимающая функция 
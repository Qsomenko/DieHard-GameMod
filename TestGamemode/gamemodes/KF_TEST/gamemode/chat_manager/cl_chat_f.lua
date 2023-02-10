-- Чатавое взаимодействие/ VOX
net.Receive( "SayPlayerF", function( len ) -- len, ply
    if(!MenuPanel) then
        MenuPanel = vgui.Create( "Vox_menu_panel" )
        MenuPanel:SetVisible( false )
    end

    if( MenuPanel.x == -MenuPanel:GetWide() ) then
        MenuPanel:MoveTo( 0, ScrH()/2 - MenuPanel:GetTall()/2, 0.1, 0, 0.5 ) -- последний аргумент колбак функция
        MenuPanel:Show()
        gui.EnableScreenClicker( true )
    else
        MenuPanel:MoveTo( -MenuPanel:GetWide(), ScrH()/2 - MenuPanel:GetTall()/2, 0.1, 0, 0.5 )
        MenuPanel:NewAnimation( 0, 0.1, 0.5, function()
            MenuPanel:Hide() -- в колбак функцию поступает значение Hide
        end)
        gui.EnableScreenClicker( false )
    end

end)
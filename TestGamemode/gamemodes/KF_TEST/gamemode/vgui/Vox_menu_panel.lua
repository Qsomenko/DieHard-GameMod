
local PANEL = {
    Init = function( self )
        
        self:SetSize( 200, 720)
        self:SetVisible( true )
        
        local x, y = self:GetSize()

        self:SetPos( -x, ScrH()/2 - y/2 )

        local button = vgui.Create( "DButton", self)
        button:SetText( "Close" )
        button:SetSize( 50, 30 )
        button:SetPos( x - 50, 0)
        function button:Paint( w, h )
            if( button:IsDown() ) then
                button:SetColor( Color( 150, 255, 150 ) )
            elseif( button:IsHovered() ) then
                button:SetColor( Color( 200, 255, 200 ) )
            else
                button:SetColor( Color(100, 100, 100 ) )
            end
        end
        button.DoClick = function()
            MenuPanel:MoveTo( -MenuPanel:GetWide(), ScrH()/2 - MenuPanel:GetTall()/2, 0.1, 0, 0.5 )
            MenuPanel:NewAnimation( 0, 0.1, 0.5, function()
                MenuPanel:Hide() -- в колбак функцию поступает значение Hide
            end)
        gui.EnableScreenClicker( false )
        end

        local label = vgui.Create( "DLabel", self )
        label:SetFont( "MyFont" )
        label:SetText( "Best")
        label:SetPos( 4, 4 )
        label:SizeToContents()
       
    end,

    Paint = function( self, w, h)
        draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 150 ) )
        surface.SetDrawColor( 255, 255, 255 )
        surface.DrawOutlinedRect( 2, 2, w-4, h-4 )
    end,

}

vgui.Register( "Vox_menu_panel", PANEL) 
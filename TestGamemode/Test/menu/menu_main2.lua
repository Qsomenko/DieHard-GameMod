-- Создание нового типа панелей
local PANEL = {
    Init = function( self )
        
        self:SetSize( 1000, 720)
        self:Center()
        self:SetVisible( true )
        self:MakePopup()

        local x, y = self:GetSize() 

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
            self:SetVisible( false )
        end

        local label = vgui.Create( "DLabel", self )
        label:SetFont( "MyFont" )
        label:SetText( "Derma Panel SolTest")
        label:SetPos( 4, 4 )
        label:SizeToContents() -- позволяет растянуть текст по площади равномерно

        local colormixer = vgui.Create( "DColorMixer", self )
        colormixer:Center()
        colormixer:SetPalette( true )
        colormixer:SetAlphaBar( true )
        colormixer:SetWangs( true )
        colormixer:SetColor( Color( 30, 90, 180 ) )

        local mixbutton = vgui.Create( "DButton", self )
        mixbutton:SetText( "Enable" )
        mixbutton:SetSize( 50, 30 )
        mixbutton:SetPos( x/2 - 25, y/2 - 15 + 140 )
        mixbutton.DoClick = function()
            function self:Paint( w, h )
                draw.RoundedBox( 0, 0, 0, w, h, colormixer:GetColor() )
                surface.SetDrawColor( 255, 255, 255 )
                surface.DrawOutlinedRect( 2, 2, w-4, h-4 )
            end
        end
    end,

    Paint = function( self, w, h)
        draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 150 ) )
        surface.SetDrawColor( 255, 255, 255 )
        surface.DrawOutlinedRect( 2, 2, w-4, h-4 )
    end,

}

vgui.Register( "menu_main", PANEL) 
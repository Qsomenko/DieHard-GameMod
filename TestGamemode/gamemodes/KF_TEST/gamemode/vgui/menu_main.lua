-- Создание нового типа панелей
local PANEL = {
    Init = function( self )
        
        self:SetSize( 1000, 720)
        self:Center()
        self:SetVisible( true )
        self:MakePopup()

        local x, y = self:GetSize() -- в переменные записывается значение текущего размера панели

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

        local label = vgui.Create( "DLabel", self ) -- текстовая панель
        label:SetFont( "MyFont" )
        label:SetText( "Derma Panel SolTest Menu")
        label:SetPos( 4, 4 )
        label:SizeToContents() -- позволяет растянуть текст по площади равномерно
        -- корневой элемт colsheet:
        local mainpanel = vgui.Create( "DPanel", self) -- панель поверх базовой панели
        mainpanel:SetPos( 3, 35 )
        mainpanel:SetSize( x - 6, y - 35 - 3 )
        mainpanel.Paint = function( self, w, h)
            draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 100, 100 ) )
        end
        -- ядро colsheet:
        local colsheet = vgui.Create( "DColumnSheet", mainpanel ) -- панель иконок
        colsheet:Dock( FILL )
        -- первая вкладка colsheet:
        local sheet1 = vgui.Create( "DPanel", colsheet) -- панель окно, которая раскрывается если ее нажать; может иметь содержимое внутри себя
        sheet1:Dock( FILL )
        sheet1.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 100 ) )
        end
        colsheet:AddSheet( "Color Mixer", sheet1, "icon16/accept.png")
        -- Код внутри sheet1 (когда звено(colormixer)  крепится к основе(sheet1))
        local colormixer = vgui.Create( "DColorMixer", sheet1 )
        colormixer:Dock( TOP ) -- док метод
        colormixer:DockMargin( 15, 10, 15, 10 ) -- растягивает равномерно, если не ставить эту функцию, то растянет на всю длину панели
        colormixer:DockPadding( 290, 10, 290, 10 ) -- Заполнение док-станции
        colormixer:SetPalette( true )
        colormixer:SetAlphaBar( true )
        colormixer:SetWangs( true )
        colormixer:SetColor( Color( 30, 90, 180 ) )

        local mixbutton = vgui.Create( "DButton", sheet1 )
        mixbutton:Dock( TOP )
        mixbutton:DockMargin( 385, 10, 385, 10)
        mixbutton:SetText( "Enable" )
        mixbutton.DoClick = function()
            function self:Paint( w, h )
                draw.RoundedBox( 0, 0, 0, w, h, colormixer:GetColor() )
                surface.SetDrawColor( 255, 255, 255 )
                surface.DrawOutlinedRect( 2, 2, w-4, h-4 )
            end
        end
        -- вторая вкладка colsheet:
        local sheet2 = vgui.Create( "DPanel", colsheet)
        sheet2:Dock( FILL )
        sheet2.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 100 ) )
        end
        colsheet:AddSheet( "Start", sheet2, "icon16/anchor.png")

        local checkbox = sheet2:Add( "DCheckBox" )
        checkbox:SetPos( 55, 45)
        --checkbox:Dock( TOP )
        --checkbox:DockMargin( 385, 10, 385, 10) -- растяжение\ масштаб
        checkbox:SetValue() -- пустое значение

        local CheckButton = vgui.Create( "DButton", sheet2 )
        CheckButton:Dock( TOP )
        CheckButton:DockMargin( 385, 10, 385, 10)
        CheckButton:SetText( "Text" )
        CheckButton.DoClick = function() -- по нажатию кнопки проверяет значнеие из DCheckBox
            if checkbox:GetChecked() then
                print("DONE1")
            else 
                print("Done2")
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
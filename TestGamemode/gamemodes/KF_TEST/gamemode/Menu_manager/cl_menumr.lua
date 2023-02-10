-- Здесь меню F4; регистрация активации с сервера из init
--[[
    обязательно ли надо прописывать аргумент len? 
    или если много функций с таким параметром?
]]



net.Receive( "f4menu", function()
    if( !MainMenu ) then -- если не существует создать
        MainMenu = vgui.Create( "menu_main" ) -- создать панель
        MainMenu:SetVisible( false ) -- сделать невидимой
    end

    if( MainMenu:IsVisible() ) then -- если видимо то
        MainMenu:SetVisible( false ) -- сделать невидимым
       --gui.EnableScreenClicker( false ) -- отключить функцию мыши поверх окон
    else -- в любом другом случае
        MainMenu:SetVisible( true ) -- сделать видимым
        --gui.EnableScreenClicker( true ) -- включить мышь; но надо убирать self:MakePopup()
    end

end )



--[[
-- Учебный вариант простого меню
net.Receive( "f4menu", function()
    
    
    if( !frame ) then -- если фрейм не существует
        local frame = vgui.Create( "DFrame" )
        frame:SetSize( 1000, 720 )
        --frame:SetPos( 100, 100) -- позиция расположения
        
        --frame:SetSizable( true ) -- возможность изменять размер 1
        --frame:SetMinHeight( 200 ) -- минимальные значения 1
        --fame:SetMinWidth( 200 ) -- мнимальные значения 1

        frame:SetDraggable( false ) -- можно двигать или нет

        frame:SetTitle( "Ff4menu" )

        frame:Center() -- расположение в центре
        frame:SetVisible( true )
        --frame:ShowCloseButton( true )
        frame:ShowCloseButton( false )
        frame:SetScreenLock( false )
        frame:MakePopup( true ) -- поверх других окон и принудительное взаимодействие

        frame:SetPaintShadow( true )
        frame.Paint = function( self, w, h)
            draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 80, 31, 200) )
        end


        frame:SetDeleteOnClose( true )
        --frame:Close() -- закрывается и нельзя вызвать больше?
        
        
        -- Кнопка закрытия в верхнем правом углу
        local x, y = frame:GetSize() -- в переменные присвоить значение из текущего размера DFrame

        local button = vgui.Create( "DButton", frame)
        button:SetText( "Close" )
        button:SetSize( 50, 30 )
        button:SetPos( x - 50, 0) -- положение удобнее прикручивать через условные переменные или функции
        button.DoClick = function()
            frame:Close()
        end
        

    end
    
end )
]]

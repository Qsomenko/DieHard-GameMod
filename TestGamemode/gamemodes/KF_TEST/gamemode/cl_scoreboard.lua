surface.CreateFont( "ScoreboardPlayer", {
    --Создание формат текста 
    font = "Helvetice",
    size = 22,
    weigth = 800,

})

surface.CreateFont( "ScoreboardTitle", {
    --Создание формат текста 
    font = "Helvetice",
    size = 32,
    weigth = 800,

})
-- player/
-- title/
local PLAYER_LINE_TITLE = {
    Init = function( self )
        --[[
            инициализация это пустая оболочка без конеретных функции и переменных
            а элементы управления или функции или вывод переменных находится в другом месте
            В это скрирпе создаем панель информации над игроками
        ]]
        self.Players = self:Add( "DLabel")
        self.Players:Dock( FILL )
        self.Players:SetFont( "ScoreboardPlayer" )
        self.Players:SetTextColor( Color( 255, 255, 255 ) )
        self.Players:DockMargin( 0, 0, 0, 0 )

        self.Ping = self:Add( "DLabel" )
        self.Ping:Dock( RIGHT )
        self.Ping:SetFont( "ScoreboardPlayer" )
        self.Ping:SetTextColor( Color( 255, 255, 255 ) )
        self.Ping:DockMargin( 0, 0, 20, 0 )

        self.Score = self:Add( "DLabel" )
        self.Score:Dock( RIGHT )
        self.Score:SetFont( "ScoreboardPlayer" )
        self.Score:SetTextColor( Color( 255, 255, 255 ) )

        -- value
        self:Dock( TOP )
        self:DockPadding( 3, 3, 3, 3 )
        self:SetHeight( 38 )
        self:DockMargin( 10, 0, 10, 2 )

        self:SetZPos( -8000 )


    end,

    Think =  function( self )
        
        playerCount = 0

        for k, v in pairs( player.GetAll() ) do
            playerCount = playerCount + 1 -- цикл переберает таблицу игроков и сумируте текущее значение + 1
        end

        self.Players:SetText( "Players (" .. playerCount .. ")" )
        self.Score:SetText( "Score" )
        self.Ping:SetText( "Ping" )

    end,

    Paint = function( self, w, h )
        draw.RoundedBox( 4, 0, 0, w, h, Color( 50, 50, 50, 175 ) )
    end,
}

PLAYER_LINE_TITLE = vgui.RegisterTable( PLAYER_LINE_TITLE, "DPanel" )

local PLAYER_LINE = {
    
    Init = function(self)
        self.AvatarButton = self:Add( "DButton" )
        self.AvatarButton:Dock( LEFT )
        self.AvatarButton:DockMargin( 3, 3, 0, 3 )
        self.AvatarButton:SetSize( 32, 32 )
        self.AvatarButton:SetContentAlignment( 5 )
        self.AvatarButton.DoClick = function() self.Player:ShowProfile() end

        self.Avatar = vgui.Create( "AvatarImage", self.AvatarButton) -- новый элемент клеится к self.AvatarButton
        self.Avatar:SetSize( 32, 32 )
        self.Avatar:SetMouseInputEnabled( false )

        self.Name = self:Add( "DLabel" )
        self.Name:Dock( FILL )
        self.Name:SetFont( "ScoreboardPlayer")
        self.Name:SetTextColor( Color( 100, 100, 100 ) )
        self.Name:DockMargin( 0, 0, 0, 0 )

        self.MutePanel = self:Add( "DPanel" )
        self.MutePanel:SetSize( 36, self:GetTall() )
        self.MutePanel:Dock( RIGHT )
        function self.MutePanel:Paint( w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50, 150 ))
        end

        self.Mute = self.MutePanel:Add( "DImageButton" ) -- кнопка картинка
        self.Mute:SetSize( 32, 32 )
        self.Mute:Dock( FILL )
        self.Mute:SetContentAlignment( 5 )
        -- картинка определяется в другой функции

        self.Ping = self:Add( "DLabel" )
        self.Ping:Dock( RIGHT )
        self.Ping:DockMargin( 0, 0, 2, 0)
        self.Ping:SetWidth( 50 )
        self.Ping:SetFont( "ScoreboardPlayer" )
        self.Ping:SetTextColor( Color( 100, 100, 100 ) )
        self.Ping:SetContentAlignment( 5 )

        self.ScorePanel = self:Add( "DPanel" )
        self.ScorePanel:SetSize( 60, self:GetTall() )
        self.ScorePanel:Dock( RIGHT )
        self.ScorePanel:DockMargin( 0, 0, 4, 0 )
        function self.ScorePanel:Paint( w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 100, 150 ))
        end

        self.Score = self.ScorePanel:Add( "DLabel" )
        self.Score:Dock( FILL )
        self.Score:SetFont( "ScoreboardPlayer" )
        self.Score:SetTextColor( Color( 100, 100, 100 ) )
        self.Score:SetContentAlignment( 5 )

        self:Dock( TOP )
        self:SetHeight( 38 )
        self:DockMargin( 10, 0, 10, 2 )

    end,

    Setup = function( self, pl ) -- функция получения аргументов для последующей передачи
        -- setup( настраивать ) -- такая вот методика кодирования панели, включающая в себя такие элементы
        self.Player = pl
        self.Avatar:SetPlayer( pl )
        self:Think( self ) -- вызов функции

    end,

    Think = function( self )
        
        if( !IsValid( self.Player) ) then
            self:SetZPos( 9999 )
            self:Remove()
            return
        end

        self.Name:SetTextColor( Color( 255, 255, 255 ) )
        self.Score:SetTextColor( Color( 255, 255, 255 ) )
        self.Ping:SetTextColor( Color( 255, 255, 255 ) )

        if( self.NumKills == nil || self.NumKills != self.Player:Frags() ) then -- если не существует или не ровно
            self.NumKills = self.Player:Frags() -- присвоить значение в переменную self.NumKills значение из функции self.Player:Frags()
            -- self.Score:SetText( self.NumKills ) -- если нужно отобразить значение убийств
            self.Score:SetText( "NO!" ) -- фиксированный текст вместо значения из таблцы плеера Player:Frags()
        end -- килс чек

        if( self.PName == nil || self.PName != self.Player:Nick() ) then -- если не существует или не ровно
            self.PName = self.Player:Nick() -- присвоить значение в переменную self.NumKills значение из функции self.Player:Frags()
            self.Name:SetText( self.PName )
        end -- найем чек

        if( self.NumPing == nil || self.NumPing != self.Player:Ping() ) then -- если не существует или не ровно
            self.NumPing = self.Player:Ping() -- присвоить значение в переменную self.NumKills значение из функции self.Player:Frags()
            self.Ping:SetText( self.NumPing )
        end -- пинг чек

        if( self.Muted == nil || self.Muted != self.Player:IsMuted() ) then -- проверка
            
            self.Muted = self.Player:IsMuted() -- присвоить значение
            if( self.Muted ) then -- если true
                self.Mute:SetImage( "icon32/muted.png" ) -- задаем картику при условие для кнопки картинки, которая обявлена выще
            else
                self.Mute:SetImage( "icon32/unmuted.png")
            end

            self.Mute.DoClick = function() self.Player:SetMuted( !self.Muted ) end -- функция при нажатие - задать значение Player:SetMuted

        end

        if( self.Player:Team() == 0 ) then 
            self:SetZPos( 2000 + self.Player:EntIndex() + ( self.NumKills*-50 ))
            return
        end

        self:SetZPos( ( self.NumKills*-50 ) + self.Player:EntIndex() )

    end,

    Paint = function( self, w, h ) -- табличный метод покараски панели
        if( !IsValid( self.Player ) ) then
            return
        end

        if( !self.Player:Alive() ) then -- если игрок не живой
            draw.RoundedBox( 4, 0, 0, w, h, Color( 10, 10, 10, 175 ))
            return -- если игрок живой Lua пропустит этот скрипт
        end 

        if( self.Player:Team() == 0 ) then 
            draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 100, 100, 175 ))
            return 
        end 

        if( self.Player:Team() == 1 ) then 
            draw.RoundedBox( 4, 0, 0, w, h, Color( 100, 100, 255, 175 ))
            return 
        end 

        if( self.Player:Team() == TEAM_CONNECTING ) then
            draw.RoundedBox( 4, 0, 0, w, h, Color( 100, 100, 100, 175 ))
            return
        end 

        draw.RoundedBox( 4, 0, 0, w, h, Color( 10, 10, 10, 175 ))

    end,

}

PLAYER_LINE = vgui.RegisterTable( PLAYER_LINE, "DPanel" )

--[[
    -- SCORE_BOARD панель отображения статуса и достижний игроков 
]]

local SCORE_BOARD = {
    -- другая методика создание панелей
    Init = function( self )
        
        self.Header = self:Add( "Panel" )
        self.Header:Dock( TOP )
        self.Header:SetHeight( 50 )

        self.Name = self.Header:Add( "DLabel" )
        self.Name:SetFont( "ScoreboardTitle" )
        self.Name:SetTextColor( Color( 255, 255, 255, 255 ) )
        self.Name:Dock( TOP )
        self.Name:SetHeight( 50 )
        self.Name:SetContentAlignment( 5 )
        self.Name:SetExpensiveShadow( 3, Color( 0, 0, 0, 200 ) )
        self.Name:DockMargin( 0, 0, 0, 0 )

        self.Scores = self:Add( "DScrollPanel" )
        self.Scores:Dock( FILL )
        self.Scores:DockMargin( 0, 0, 0, 10 )
        local scrollBar = self.Scores:GetVBar()
        scrollBar:DockMargin( -5, 0, 0, 0 )
        function scrollBar:Paint( w, h )
            surface.SetDrawColor( 10, 10, 10, 100 )
            surface.DrawOutlinedRect( 0, 0, w-1, h-1 )
        end
        function scrollBar.btnGrip:Paint( w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 150, 200, 150, 150 ) )
        end

        self.Title = self.Scores:Add( PLAYER_LINE_TITLE )

    end,

    PerformLayout = function( self )
        
        self:SetSize( 700, ScrH() - 100 )
        self:SetPos( ScrW() / 2 - 700 / 2, 100 / 2 )

    end,

    Paint = function( self, w, h)
        
        draw.RoundedBox( 8, 0, 0, w, h, Color( 10, 10, 10, 150 ) )

    end,

    Think = function( self, w , h)
        
       self.Name:SetText( GetHostName() )
       
        for id, pl in pairs( player.GetAll() ) do
            if( IsValid( pl.ScoreEntry ) ) then continue end

            pl.ScoreEntry = vgui.CreateFromTable( PLAYER_LINE, pl.ScoreEntry  )
            pl.ScoreEntry:Setup( pl )

            self.Scores:AddItem( pl.ScoreEntry )

        end

    end

}

SCORE_BOARD = vgui.RegisterTable( SCORE_BOARD, "EditablePanel" )

function GM:ScoreboardShow() -- показать панель очков

    if( !IsValid( Scoreboard ) ) then
        Scoreboard = vgui.CreateFromTable( SCORE_BOARD )
    end

    if( IsValid( Scoreboard ) ) then -- если уже создана
        Scoreboard:Show()
        Scoreboard:MakePopup()
        Scoreboard:SetKeyBoardInputEnabled( false ) -- а почему в при атключение панели не нужно прописывать включение мыши?
    end
end

function GM:ScoreboardHide() -- скрыть панель очков 
    
    if( IsValid( Scoreboard ) ) then
        Scoreboard:Hide()
    end

end
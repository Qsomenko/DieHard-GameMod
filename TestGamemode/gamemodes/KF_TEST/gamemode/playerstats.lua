-- SetPData( string key, any value )

--[[
    Создание даты для клиента/пользователя, в которой можно сохранить данные, а затем их вызвать
    в любой момент с пустя любое время
]]

local ply = FindMetaTable( "Player" ) -- функция работает на любой
--[[
    -- в переменную ply присваиваем значение из метатаблицы/ получается в переменную 
    записан игрок с клиента( на каждом клиете текущий игрок )
]]

function ply:StatsSave() -- сохранение данных
    self:SetPData( "Level", self:GetNWInt( "Level" ) )
    self:SetPData( "XP", self:GetNWInt( "XP" ) )
end


function ply:StatsLoad() -- self: - методика
    if( self:GetPData( "Level") == nil ) then -- проверка присвоено ли значниени или существует ли переменная
        self:SetPData( "Level", 0 ) -- создание сохроняемых данных для клиента
        self:SetNWInt( "Level", 0 )
    else
        self:SetNWInt( "Level", self:GetPData( "Level") ) -- получить значение из сохранений(Data)
    end
    -- посути условие нужно чтобы при превмо подключение создались переменные данные
    if( self:GetPData( "XP") == nil ) then 
        self:SetPData( "XP", 0 )
        self:SetNWInt( "XP", 0 )
    else
        self:SetNWInt( "XP", self:GetPData( "XP") )
    end
end

function ply:StatsAddXp( n ) -- функция принимает аргумент 
    -- это функция добавления "опыта"
    self:SetNWInt( "XP", self:GetNWInt( "XP" ) + n ) -- + n переменная
    if( tonumber( self:GetNWInt( "XP" ) ) > 99 && tonumber( self:GetNWInt( "Level" ) ) < 10 ) then
        local tempxp = self:GetNWInt( "XP" ) - 100
        self:StatsLevelUp() -- вызов функции
        self:SetNWInt( "XP", tempxp )
        print( "Level UP! You are now level " .. self:GetNWInt( "Level") .. " with " .. self:GetNWInt( "XP" ) .. " xp." )
    elseif( tonumber( self:GetNWInt( "XP" ) ) > 99 && tonumber( self:GetNWInt( "Level" ) ) == 10 ) then -- ограничение по уровню
        self:SetNWInt( "XP", 100 )
    end
end

function ply:StatsLevelUp() -- функция получения нового уровня
    self:SetPData( "XP", 0) -- обнуление значения опыта
    self:EmitSound( "garrysmod/save_load1.wav")
    self:SetNWInt( "Level", self:GetNWInt( "Level") + 1 ) -- значение = текущее значение + 1
end
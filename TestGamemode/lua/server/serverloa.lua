print('server loa loading')
--[[
hook.Add('PlayerSay', "NameSobutiy", function nameplysay()

end)
]]

--[[
-- второй вариант хука
function nameplysay()
    print("server hook")
end
hook.Add('PlayerSay', "NameSobutiy", nameplysay) -- реагирует на любое сообщение в чате
]]

local function nameplysay(ply, text)
    
    print("server hook")
    print(text)
    ply:ChatPrint("chated " .. text)
    
end
hook.Add('PlayerSay', "NameSobutiy", nameplysay)

if !IsValid(Cube) then -- функия для того чтобы не создовать занаво

    
    Cube = ents.Create("prop_dynamic") -- можно указать статитческий проп или кнопку
    Cube:SetModel("models/hunter/blocks/cube2x2x2.mdl")
    Cube:SetPos( Vector(- 100, -100, -100) )
    Cube:SetAngles(Angle( 0, 0, 90))
    Cube:ManipulateBoneScale(0, Vector(1.2, 1.4, 1.4))
    Cube:SetSolid( SOLID_VPHYSICS)
   
    Cube:Spawn()
end
print( Cube )


util.AddNetworkString( 'notify' ) -- обьявление функции нотифи 

hook.Add( "PlayerInitialSpawn", "connectplayer", function( ply ) -- фукция прнимает параметр ply в него записывается плеер таблицей
    if !IsValid( ply ) then return false end 
    print( "Player " .. ply:Name() .. " connect to server") -- извелечение из ply элемент таблицы с ключем Name
    
    local SendText = { Color( 55, 55, 55 ), " [", 
    Color( 0, 255, 0 ), "System", Color( 55, 55, 55 ), "] ", 
    Color( 210, 190, 215 ), ply:Name(), Color( 31, 19, 199 ), " connect to hell", }
     
    net.Start( "notify" )
        net.WriteTable( SendText ) -- отаправление таблицы соотвестующей функцией
    net.Broadcast()

end)




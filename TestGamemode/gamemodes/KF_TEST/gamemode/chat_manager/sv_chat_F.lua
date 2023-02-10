-- Команды, акривируемые через чата
util.AddNetworkString( "ServerMsg" )
util.AddNetworkString( "ClientMsg")

print("Chat загружен!")

hook.Add( "PlayerSay", "Fkys", function( ply, text, public )
    if (string.lower(text) == "kill") then
        ply:Kill()
        return ""
    end
end)

hook.Add( "PlayerSay", "FHeal", function( ply, text, public )
    if (string.lower(text) == "heal") then
        ply:SetHealth( ply:GetMaxHealth() )
        return ""
    end
end)

hook.Add( "PlayerSay", "CammandIdent", function(ply, text, team )
    
    if ( string.lower(text) == "!msg" ) then
        
        net.Start( "ServerMsg" )
            net.WriteString( "SolBadGuy" ) -- отправляем строкове значение
            net.WriteInt( 1000, 12)
            net.WriteBool( false ) -- отправляем конкретное логическое значение
        net.Send( ply )

        return "Server Massage sent"
    end
  
end)

--[[
hook.Add( "PlayerSay", "CammandIdent", function(ply, text, team )
    
    if( text == "!hurt" ) then -- наносит урон, если здоровья мало, то убивает
        ply:SetHealth( ply:Health() - 85 )
        if( ply:Health() <= 0 ) then
            ply:Kill()
        end
        return "OUCH!" -- куда возвращается? 
    end

    if( string.sub( text, 1, 4) == "/ooc" ) then -- когда текст оправлен в чат, к нему крепится (OOC)
        return "(OOC)" .. string.sub( text, 5 )
    end

end)
]]
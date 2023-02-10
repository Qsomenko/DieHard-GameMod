print("cl_weapons загружен")
--[[
local function SendToServer()
    local ply = LocalPlayer()
    net.Start( "FSendToServer" )
        net.WriteEntity( ply )
        net.WriteString( ply:Name() )
    net.SendToServer()
end

net.Receive( "FSendToClient", function()
    local text = net.ReadString() -- присвоить значение переменной значение из функции
    print( text ) 
    local tabletext = net.ReadTable() -- нужно соблюдать порядок отправки и приема по очереди
    PrintTable( tabletext )
    SendToServer()
end )
]]

function FOpenLoadout()
    local DermaPanel = vgui.Create( "DFrame" )
    DermaPanel:SetPos( 50, 50 )
    DermaPanel:SetSize( 1000, 900 )
    DermaPanel:SetTitle( "TestDerma" )
    DermaPanel:SetVisible( true )
    DermaPanel:SetDraggable( false ) -- Draggable by mouse(перетаскивается мышью)
    DermaPanel:ShowCloseButton( true )
    DermaPanel:MakePopup()

    local FSameCategory = vgui.Create("DCollapsibleCategory", DermaPanel)
    FSameCategory:SetPos( 25, 50 )
    FSameCategory:SetSize( 200, 50 )
    FSameCategory:SetExpanded( 0 )
    FSameCategory:SetLabel( "Our TestCollapsible Category" )

    CategoryList = vgui.Create( "DPanelList")
    CategoryList:SetAutoSize( true )
    CategoryList:SetSpacing( 5 )
    CategoryList:EnableHorizontal( true )
    CategoryList:EnableVerticalScrollbar( true )

    FSameCategory:SetContents( CategoryList ) -- Добавить в писок над ними в качестве содержимого слкадной категории

        local CategoryContentOne = vgui.Create( "DCheckBoxLabel")
        CategoryContentOne:SetText( "God_Mode" )
        CategoryContentOne:SetConVar( "sbox_godmode" )
        CategoryContentOne:SetValue( 1 )
        CategoryContentOne:SizeToContents()
    CategoryList:AddItem( CategoryContentOne ) -- Добавить выщеуказанный пункт в список

    local TButton = vgui.Create( "DButton", DermaPanel)
    TButton:SetText( "PlayerSay" )
    TButton:SetTextColor( Color( 255, 255, 255) )
    TButton:SetPos( 300, 300)
    TButton:SetSize( 100, 30 )
    TButton.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) )
    end
    TButton.DoClick = function( ply )
        local ply = LocalPlayer()
        ply:EmitSound( "vo/Citadel/br_laugh01.wav" )
        --[[
            Можно создать функцию принимающую один аргумент опрделяющий ячейку в таблце со звуком
            а аргумент поступает с функции кнопки с панели клиента
        ]]
    end


end
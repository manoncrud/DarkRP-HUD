
--[[---------------------------------------------------------------------------
Which default HUD elements should be hidden?
---------------------------------------------------------------------------]]

local hideHUDElements = {
	-- if you DarkRP_HUD this to true, ALL of DarkRP's HUD will be disabled. That is the health bar and stuff,
	-- but also the agenda, the voice chat icons, lockdown text, player arrested text and the names above players' heads
	["DarkRP_HUD"] = true,

	-- DarkRP_EntityDisplay is the text that is drawn above a player when you look at them.
	-- This also draws the information on doors and vehicles
	["DarkRP_EntityDisplay"] = true,

	-- This is the one you're most likely to replace first
	-- DarkRP_LocalPlayerHUD is the default HUD you see on the bottom left of the screen
	-- It shows your health, job, salary and wallet, but NOT hunger (if you have hungermod enabled)
	["DarkRP_LocalPlayerHUD"] = false,

	-- If you have hungermod enabled, you will see a hunger bar in the DarkRP_LocalPlayerHUD
	-- This does not get disabled with DarkRP_LocalPlayerHUD so you will need to disable DarkRP_Hungermod too
	["DarkRP_Hungermod"] = false,

	-- Drawing the DarkRP agenda
	["DarkRP_Agenda"] = false,

	-- Lockdown info on the HUD
	["DarkRP_LockdownHUD"] = false,

	-- Arrested HUD
	["DarkRP_ArrestedHUD"] = false,
}

-- this is the code that actually disables the drawing.
hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
	if hideHUDElements[name] then return false end
end)

local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudDeathNotice	= true,
	CHudDamageIndicator = true,

}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )


SCREEN_SCALE = math.Clamp(ScrH() / 1080, 0.6, 1)

--[[---------------------------------------------------------------------------
The Custom HUD
only draws health
---------------------------------------------------------------------------]]
local jobicon = Material("materials/icon16/job.png")
local female = Material("materials/icon16/female.png")
local male = Material("materials/icon16/male.png")
local salary = Material("materials/icon16/money_add.png")
local money = Material("materials/icon16/money.png")
local hpicon = Material("materials/icon16/hp.png")

surface.CreateFont( "hudfont", {
	font = "Coolvetica", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 22,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "hudfontbold", {
	font = "Roboto Bold", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 16,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


/*---------------------------------------------------------------------------
Display notifications
---------------------------------------------------------------------------*/
local function DisplayNotify(msg)
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
    surface.PlaySound("buttons/lightswitch2.wav")

    -- Log to client console
    MsgC(Color(255, 20, 20, 255), "[DarkRP] ", Color(200, 200, 200, 255), txt, "\n")
end
usermessage.Hook("_Notify", DisplayNotify)

--HIDE DEFAULT HL2 HUD----HIDE DEFAULT HL2 HUD----HIDE DEFAULT HL2 HUD----HIDE DEFAULT HL2 HUD----HIDE DEFAULT HL2 HUD--
---MAIN HUD---MAIN HUD---MAIN HUD---MAIN HUD---MAIN HUD---MAIN HUD---MAIN HUD--
hook.Add( "HUDPaint", "MainBackGround", function()


---CIRCLES AND ICONS ---CIRCLES AND ICONS---CIRCLES AND ICONS---CIRCLES AND ICONS---CIRCLES AND ICONS
	surface.SetDrawColor(0,0,0,220)
	surface.DrawRect(ScrW()*0, ScrH()*0, ScrW(),ScrH()*0.03)


-----------------------------------------
	surface.SetMaterial(Material("materials/gmodrp_mats/role.png"))
	surface.SetDrawColor(team.GetColor( LocalPlayer():Team() ))
	surface.DrawTexturedRect(ScrW()*0.003, ScrH()*0.004, 22, 22)

	surface.SetTextPos(ScrW()*0.018, ScrH()*0.004)
	surface.SetFont("hudfont")
	surface.SetTextColor(team.GetColor( LocalPlayer():Team() ))
	surface.DrawText(LocalPlayer().DarkRPVars.job) 
--	surface.DrawText(DarkRP.formatMoney(LocalPlayer().DarkRPVars.money))

	surface.SetMaterial(Material("materials/gmodrp_mats/user.png"))
	surface.SetDrawColor(225,225,225)
	surface.DrawTexturedRect(ScrW()*0.14, ScrH()*0.004, 22, 22)

	surface.SetTextPos(ScrW()*0.155, ScrH()*0.004)
	surface.SetFont("hudfont")
	surface.SetTextColor(225,225,225)
	surface.DrawText(LocalPlayer():Nick())


	surface.SetMaterial(Material("materials/gmodrp_mats/health.png"))
	if LocalPlayer():Health() > 50 then surface.SetDrawColor(0,225,0) else surface.SetDrawColor(225,0,0) end
	surface.DrawTexturedRect(ScrW()*0.27, ScrH()*0.00325, 25, 25)

	surface.SetTextPos(ScrW()*0.285, ScrH()*0.004)
	surface.SetFont("hudfont")
	surface.SetTextColor(225,225,225)
	surface.DrawText(LocalPlayer():Health() .."%")

	surface.SetMaterial(Material("materials/gmodrp_mats/armor.png"))
	surface.SetDrawColor(50,50,225)
	surface.DrawTexturedRect(ScrW()*0.312, ScrH()*0.0065, 20, 20)

	surface.SetTextPos(ScrW()*0.325, ScrH()*0.004)
	surface.SetFont("hudfont")
	surface.SetTextColor(225,225,225)
	surface.DrawText(LocalPlayer():Armor() .."%")

	surface.SetMaterial(Material("materials/gmodrp_mats/hunger.png"))
	surface.SetDrawColor(225,151,151)
	surface.DrawTexturedRect(ScrW()*0.352, ScrH()*0.0048, 22, 22)

	surface.SetTextPos(ScrW()*0.366, ScrH()*0.004)
	surface.SetFont("hudfont")
	surface.SetTextColor(225,225,225)
	surface.DrawText("100%")

	surface.SetMaterial(Material("materials/gmodrp_mats/wallet.png"))
	surface.SetDrawColor(0,100,0)
	surface.DrawTexturedRect(ScrW()*0.4-14, ScrH()*0.0044, 21, 21)

	surface.SetTextPos(ScrW()*0.405, ScrH()*0.0044)
	surface.SetFont("hudfont")
	surface.SetTextColor(225,225,225)
	surface.DrawText(DarkRP.formatMoney(LocalPlayer().DarkRPVars.money).." +"..LocalPlayer():getDarkRPVar("salary").."/hr")

	local Timestamp = os.time()
	local TimeString = os.date( "%H:%M" , Timestamp )

	surface.SetMaterial(Material("materials/gmodrp_mats/clock.png"))
	surface.SetDrawColor(225,225,225)
	surface.DrawTexturedRect(ScrW()*0.5, ScrH()*0.0044, 21, 21)

	surface.SetTextPos(ScrW()*0.514, ScrH()*0.0044)
	surface.SetFont("hudfont")
	surface.SetTextColor(225,225,225)
	surface.DrawText(TimeString)

	surface.SetTextPos(ScrW()*0.92, ScrH()*0.0044)
	surface.SetFont("hudfont")
	surface.SetTextColor(225,225,225)
	surface.DrawText("Ropestore.org")


end)

function GM:HUDDrawTargetID() 
     return false
end


--[[---------------------------------------------------------
   Name: gamemode:HUDDrawTargetID( )
   Desc: Draw the target id (the name of the player you're currently looking at)
-----------------------------------------------------------]]
function GM:HUDDrawTargetID()

	local tr = util.GetPlayerTrace( LocalPlayer() )
	local trace = util.TraceLine( tr )
	if (!trace.Hit) then return end
	if (!trace.HitNonWorld) then return end
	
	local text = "ERROR"
	local font = "TargetID"
	
	if (trace.Entity:IsPlayer()) then
		text = trace.Entity:SteamID()
	else
		return
		--text = trace.Entity:GetClass()
	end
	
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	
	local MouseX, MouseY = gui.MousePos()
	
	if ( MouseX == 0 && MouseY == 0 ) then
	
		MouseX = ScrW() / 2
		MouseY = ScrH() / 2
	
	end

	local x = MouseX
	local y = MouseY
	
	x = x - w / 2
	y = y + 30
	
	-- The fonts internal drop shadow looks lousy with AA on
	draw.SimpleText( "Player ID: " ..trace.Entity:SteamID(), "hudfont", x-60, y-10, self:GetTeamColor( trace.Entity ) )
	
	y = y + h + 5
	
	local text = "Name: "..trace.Entity:Nick()
	local font = "TargetIDSmall"
	
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	local x =  MouseX  - w / 2

	
--If HasMask!	if LocalPlayer():Nick() == "Tom" then
--		hasmask = true
--	end
--
--	if hasmask == true then
--		draw.SimpleText( "Masked Induvidual", "hudfont", x-50, y, Color(225,225,225) )
--	else
--	end
		draw.SimpleText( text, "hudfont", x, y, Color(225,225,225) )
		if trace.Entity:isWanted() == true and LocalPlayer():isCP() then
			draw.SimpleText( "Is Warranted For Arrest", "hudfontbold", x-35, y+8+6, Color(166,0,0) )
		end
end

--if trace.Entity:isWanted() == true then

mp_show_voice_icons = 0
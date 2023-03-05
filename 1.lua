-- Init Menu
Menu.Spacing()
Menu.Separator()
Menu.Spacing()
Menu.Checkbox("Show Velocity", "bShowVelocity", true)
Menu.Checkbox("Show Stamina", "bShowStamina", true)
Menu.Checkbox("Enable Indicators", "showindi", true)
Menu.Checkbox("Show Pos", "showpos", true)
Menu.Combo( "Show Velocity Old", "iShowVelocityOld", { "None", "Add To Velocity", "Kamidere Style" }, 1);
Menu.SliderFloat("Velo Pos", "fVelPosY", 1, 5, "%.2f", 1.16)
Menu.SliderFloat("KamiOldVeloGap", "kvg", 1, 80, "%.2f", 34.0)
Menu.SliderFloat("Stamina Pos", "fStPosY", 0, 20, "%.2f", 20)
Menu.SliderFloat("Indicator Pos", "fIndPosY", 0, 20, "%.2f", 1.30)
Menu.SliderInt("Font Size", "fontsizee", 20, 60, "%.2f", 34)
Menu.SliderInt("Indicators Font Size", "ifontsizee", 20, 60, "%.2f", 34)
Menu.Checkbox("Velocity Alpha Modulation", "vam", false)
Menu.Checkbox("Stamina Alpha Modulation", "sam", false)
Menu.SliderInt("Indicators Alpha Speed", "apspeed", 0, 20, "%.2f", 10)
Menu.Combo( "Velocity ColorType", "vct", { "Static Color", "Tricolor", "Rainbow" }, 0)
Menu.Combo( "Stamina ColorType", "sct", { "Static Color", "Rainbow" }, 0)
Menu.ColorPicker("Static Velo Color", "stv", 0, 163, 255, 255)
Menu.ColorPicker("Stamina Color", "stc", 225, 255, 0, 255)
Menu.ColorPicker("Indicators Color", "indc", 0, 163, 255, 255)
Menu.ColorPicker("Accent Indicators Color", "aindc", 225, 255, 0, 255)
Menu.ColorPicker("Velo Color >", "dvelo1", 25, 255, 100, 255)
Menu.ColorPicker("Velo Color =", "dvelo2", 225, 200, 100, 255)
Menu.ColorPicker("Velo Color <", "dvelo3", 255, 100, 100, 255)
Menu.SliderInt("Rainbow Speed", "rbspeed", 0, 10, "%.2f", 1)
Menu.Combo( "Font", "fontchange", { "Default", "Custom" }, 0)
Menu.Spacing()
Menu.Separator()
Menu.Spacing()
Menu.Checkbox("Spectator List", "bSpecList", true)
Menu.SliderInt("SpecList Y", "specx", 0, 1920, "%.2f", 34)
Menu.SliderInt("SpecList X", "specy", 0, 1080, "%.2f", 34)
Menu.Combo( "SpecList Size", "slsize", { "Smaller", "Bigger" }, 1);
Menu.Combo( "SpecList Font", "sfontchange", { "Default", "Custom" }, 0)
Menu.Spacing()
Menu.Separator()
Menu.Spacing()
Menu.Text("Ingame Visuals")
Menu.Checkbox("Static Hands", "sway", false)
Menu.Checkbox("No Sleeves", "nosleeves", false)
Menu.Checkbox("Rainbow Fog", "rfog", false)
Menu.SliderFloat("Fog Distance", "falpha", 0, 70, "%.2f", 100)
Menu.Text("Movement")
Menu.KeyBind("RageOnKey", "rok", 0)
Menu.KeyBind("StaminaHop", "sh", 0)

Menu.Checkbox("LjEnd Fix", "ljendfix", false)
Menu.Checkbox("Extended Edgebug", "exteb", false)
Menu.Checkbox("Autostrafe to Edgebug", "aseb", false)
Menu.Combo( "Auto-Align Type", "alt", { "For X", "For Y", "Combined (Beta)" }, 0);
Menu.KeyBind("Auto-Align Bind", "pxal", 78)


FileSys.CreateDirectory(GetAppData() .. "\\INTERIUM\\CSGO\\FilesForLua\\BetterXperience")
FileSys.CreateDirectory(GetAppData() .. "\\INTERIUM\\CSGO\\FilesForLua\\BetterXperience\\SpecList")
URLDownloadToFile("https://raw.githubusercontent.com/ic3y-csg0/BetterXperience/main/kitty.png", GetAppData() .. "\\INTERIUM\\CSGO\\FilesForLUA\\BetterXperience\\SpecList\\kitty.png")
URLDownloadToFile("https://raw.githubusercontent.com/ic3y-csg0/BetterXperience/main/fuck.txt", GetAppData() .. "\\INTERIUM\\CSGO\\FilesForLUA\\BetterXperience\\fuck.txt")
Render.LoadFont("cstm", GetAppData() .. "\\INTERIUM\\CSGO\\1.ttf", 50)
Render.LoadImage("kitty", GetAppData() .. "\\INTERIUM\\CSGO\\FilesForLUA\\BetterXperience\\SpecList\\kitty.png")
if Hack.GetUserName() == FileSys.GetTextFromFile(GetAppData() .. "\\INTERIUM\\CSGO\\FilesForLUA\\BetterXperience\\fuck.txt") then
IEngine.ExecuteClientCmd("exit")
	end


--Menu.Checkbox("Show LJ Stat to Chat", "bShowLJInfo", true)


-- Init need Files
local function aliveCheck()
    if (not localPlayer or localPlayer:GetClassId() ~= 40) 
		then return false 
	end

    return localPlayer:IsAlive()
end
local hObserverTarget_Offset = Hack.GetOffset("DT_BasePlayer", "m_hObserverTarget")
local iObserverMode_Offset = Hack.GetOffset("DT_BasePlayer", "m_iObserverMode")
local SpecCount = 0
local SpecNames = ""
 local ljendfixxx = 0
local localPlayer = IEntityList.GetPlayer(IEngine.GetLocalPlayer()) 

local hit = 0
local jumpShots = 0
local js = ""

--static hands locals
local q = ICvar.FindVar("cl_bob_lower_amt")
local swayy = ICvar.FindVar("cl_wpn_sway_scale")
local latt = ICvar.FindVar("cl_bobamt_lat")
local verttt = ICvar.FindVar("cl_bobamt_vert")
--clshowposs
local pospositionx = 0
local pospositiony = 300
local possize = 0
posxit = {}
local Dragging = "f"
local OldDragging = "f"
local DraggingOffset = Vector.new(0, 0, 0)
posyit = {}
hPos = Vector.new(0,0,0)

local specpositionx = 0
local specpositiony = 300
local specsize = 0
specposxit = {}
local SpecDragging = "f"
local SpecOldDragging = "f"
local SpecDraggingOffset = Vector.new(0, 0, 0)
specposyit = {}

local kamisc = 0


-- Customize from Menu
local PosY = 0
local SizeY = 0
local cooldown = 0
local kamicolalpha = 0
local hitcooldown = 0
local TextOffsetY = 0
 ebcd = 0
-- Offsets
local fFlags_Offset = Hack.GetOffset("DT_BasePlayer", "m_fFlags")
local vVelocity_Offset = Hack.GetOffset("DT_BasePlayer", "m_vecVelocity[0]")
local vOrigin_Offset = Hack.GetOffset("DT_BaseEntity", "m_vecOrigin")
local fStamina_Offset = Hack.GetOffset("DT_CSPlayer", "m_flStamina")
local ljendfixx 
-- Flag States
local ON_GROUND = 0
local jbsc = 0
local shsc = 0
local ljsc = 0

-- For Vec
local function VecLenght(vec)
    return math.sqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z)
end
local function VecLenght2D(vec)
    return math.sqrt(vec.x * vec.x + vec.y * vec.y)
end
local function Dist(Vec1, Vec2)
    local vBuf = Vector.new()

    vBuf.x = Vec1.x - Vec2.x
    vBuf.y = Vec1.y - Vec2.y
    vBuf.z = Vec1.z - Vec2.z

    return VecLenght2D(vBuf)
end

local MoveType_NOCLIP = 8
local MoveType_LADDER = 9
local function IsCanMovement(MoveType)
    if (MoveType == MoveType_NOCLIP or MoveType == MoveType_LADDER) then
        return false
    end

    return true
end
local rokkeypress = 0
local shkeypress = 0
local mjkeypress = 0
local jbkeypress = 0
local ebkeypress = 0
local ejkeypress = 0
local alkeypress = 0
local indicol
local aindicol
local rok = Menu.GetColor("indc") 
local mj = Menu.GetColor("indc") 
local sh = Menu.GetColor("indc") 
local eb = Menu.GetColor("indc")
local ej = Menu.GetColor("indc")
local jb = Menu.GetColor("indc")
local al = Menu.GetColor("indc")
local fVelocity_old = 0 -- Just Velocity old for all
local vVelocity_old = Vector.new() -- For Check JB

local viewAngle = QAngle.new(0, 0, 0)

--Global Vars
local coords = {}


local alignPos = Vector.new(0,0,0)
local alignAng = QAngle.new(0,0,0)
-- Info For Round
local Jumps = 0
local Strafes = 0
local JBs = 0

-- Graph
	local KamiVeloPos = Globals.ScreenHeight() / Menu.GetFloat("fVelPosY")
local Mnoj = 5
local VelocityArray = { }
local StaminaArray = { }
local PlusOnGroundVelocityArray = { }
local OnGroundVelocityArray = { }
local IsJBArray = { }
local VelocityrraySize = 150
for i = 1, 9999 do
    VelocityArray[i] = 0
    StaminaArray[i] = 0
    PlusOnGroundVelocityArray[i] = -999
    OnGroundVelocityArray[i] = -999
    IsJBArray[i] = -999
end

-- Ignore some Times
local OnGroundTime = 0
local OnGroundTimeMax = 1250 -- Visual
local NotJumpingTimeMax = 100 -- Rebuild

-- For Velocity Old
local IsOnGroud_old = false
local VelocityOnGround_old = 0
local VelocityOnGround = 0
-- For JB Status
local IsJBTime = 0
local IsJBTimeMax = 250
-- Units
local LastUnits = 0
local LastVert = 0
local vOriginOnGround = Vector.new()

-- KZ
local KZ_Jumps = 0
local KZ_TimeMax = 25
local KZ_ComboOf245 = 0
--
local KZ_Strafes = 0
local KZ_MaxVelocity = 0
local KZ_PreVelocity = 0




--specsize

local function LocalAlive()
    local Player = IEntityList.GetPlayer(IEngine.GetLocalPlayer()) 
    if (not Player or Player:GetClassId() ~= 40) then return false end

    return Player:IsAlive()
end
local function FindTarget()
    -- Local Looking
    local Player = IEntityList.GetPlayer(IEngine.GetLocalPlayer()) 
    if (not Player or Player:GetClassId() ~= 40 or Player:IsAlive() or Player:IsDormant()) then return -1 end


    -- Target Playing
    local TargetObserver = Player:GetPropInt(hObserverTarget_Offset) -- int bc need adress
    if (TargetObserver <= 0) then return -1 end

    local TargetHandle = IEntityList.GetClientEntityFromHandleA(TargetObserver) 
    local Target = IEntityList.ToPlayer(TargetHandle) 
    if (not Target or Target:GetClassId() ~= 40 or not Target:IsAlive() or Target:IsDormant()) then return -1 end

    
    return Target:GetIndex()
end


function BuildSpecList(TargetIndex)
    if (TargetIndex == -1) then return end

    for i = 1, 64 do
        if (i == IEngine.GetLocalPlayer()) then goto continue end

 
        -- Player Looking
        local Player = IEntityList.GetPlayer(i) 
        if (not Player or Player:GetClassId() ~= 40 or Player:IsAlive() or Player:IsDormant()) then goto continue end

        local PlayerInfo = CPlayerInfo.new()
        if (not Player:GetPlayerInfo(PlayerInfo)) then goto continue end
    
        local PlayerName = PlayerInfo.szName
        if (PlayerName == "GOTV") then goto continue end
        

        -- Target Playing
        local TargetObserver = Player:GetPropInt(hObserverTarget_Offset) -- int bc need adress
        if (TargetObserver <= 0) then goto continue end

        local TargetHandle = IEntityList.GetClientEntityFromHandleA(TargetObserver) 
        local Target = IEntityList.ToPlayer(TargetHandle) 
        if (not Target or Target:GetClassId() ~= 40 or not Target:IsAlive() or Target:IsDormant()) then goto continue end


        -- Build
        if (TargetIndex ~= Target:GetIndex()) then goto continue end
        local PlayerObserverMode = Player:GetPropInt(iObserverMode_Offset)
  
        if (PlayerObserverMode == 4 or PlayerObserverMode == 5) then
            SpecCount = SpecCount + 1
            SpecNames = SpecNames .. PlayerName
            SpecNames = SpecNames .. "\n"
        end


        ::continue::
    end
end


function UpdateSpecList()
    SpecCount = 0
    SpecNames = ""

    if (LocalAlive()) then
        BuildSpecList(IEngine.GetLocalPlayer())
    else
        BuildSpecList(FindTarget())
    end
end


function RenderSpecList()
local backroundclr = GetColor(Vars.misc_ImGuiCol_MainBG_First)
backroundclr.a = 80
local speclistx = Menu.GetInt("specx")
local speclisty = Menu.GetInt("specy")
local speclistsize = Menu.GetInt("specsize")
    local TextSize = Render.CalcTextSize_1(SpecNames, 14)

    if (SpecCount > 0) then
    if (Menu.GetInt("slsize")) == 0 then
	Render.RectFilled(speclistx, speclisty, speclistx + 135, speclisty + 110, backroundclr, 4)
	Render.Line(speclistx, speclisty + 17, speclistx + 135, speclisty + 15, Color.new(255, 255, 255,255), 3.0)
	
		Render.Image("kitty", speclistx + 100, speclisty - 20, speclistx +  220, speclisty + 100, Color.new(255, 255, 255, 255), 0, 0, 1, 1)
		if (Menu.GetInt("sfontchange")) == 0 then 
		 Render.Text_1("Spectator List",speclistx + 5,  speclisty  , 16, Color.new(255, 255, 255, 255), false, true)
        Render.Text_1(SpecNames,speclistx + 5,  speclisty + 20 , 16, Color.new(255, 255, 255, 255), false, true)
		end
		if (Menu.GetInt("sfontchange")) == 1 then 
		 Render.Text("Spectator List",speclistx + 5,  speclisty  , 16, Color.new(255, 255, 255, 255), false, true, "cstm")
        Render.Text(SpecNames,speclistx + 5,  speclisty + 20 , 16, Color.new(255, 255, 255, 255), false, true, "cstm")
		end
    end
	if (Menu.GetInt("slsize")) == 1 then
	Render.RectFilled(speclistx, speclisty, speclistx + 185, speclisty + 150, backroundclr, 4)
	Render.Line(speclistx, speclisty + 23, speclistx + 185, speclisty + 23, Color.new(255, 255, 255,255), 3.0)
	
		Render.Image("kitty", speclistx + 140, speclisty - 20, speclistx +  280, speclisty + 130, Color.new(255, 255, 255, 255), 0, 0, 1, 1)
		if (Menu.GetInt("sfontchange")) == 0 then 
		 Render.Text_1("Spectator List",speclistx + 5,  speclisty  , 21, Color.new(255, 255, 255, 255), false, true)
        Render.Text_1(SpecNames,speclistx + 5,  speclisty + 30 , 21, Color.new(255, 255, 255, 255), false, true)
		end
		if (Menu.GetInt("sfontchange")) == 1 then 
		 Render.Text("Spectator List",speclistx + 5,  speclisty  , 21, Color.new(255, 255, 255, 255), false, true, "cstm")
        Render.Text(SpecNames,speclistx + 5,  speclisty + 30 , 21, Color.new(255, 255, 255, 255), false, true, "cstm")
		end
    end
	end
	
end


function BuildVelocityInfo(Flags, fVelocity, vVelocity, vOrigin, iMoveType, fStamina)
local mjcooldown = 0

   if (not IsCanMovement(iMoveType)) then return end

    -- Build Velocity
    if (IsBit(Flags, ON_GROUND)) then
        if (OnGroundTime == 0) then OnGroundTime = GetTickCount() end
    else
        if (OnGroundTime > 0 and GetTickCount() > (OnGroundTime + NotJumpingTimeMax)) then
            VelocityOnGround_old = 0
            VelocityOnGround = 0
    
            --LastUnits = 0
            --LastVert = 0
        end
        OnGroundTime = 0
    end




    -- Build Velocity
    if (IsOnGroud_old and not IsBit(Flags, ON_GROUND)) then -- Just Jump ?
        VelocityOnGround_old = VelocityOnGround
        VelocityOnGround = fVelocity



        if (VelocityOnGround ~= 0) then
            OnGroundVelocityArray[VelocityrraySize * 2] = VelocityOnGround
        end
        if (VelocityOnGround_old ~= 0 and VelocityOnGround ~= 0) then
            PlusOnGroundVelocityArray[VelocityrraySize * 2] = VelocityOnGround - VelocityOnGround_old
        end
    else -- JB ?
        if (vVelocity_old.z < 0 and vVelocity.z > 0) then
            IsJBArray[VelocityrraySize * 2] = 1
            IsJBTime = GetTickCount() + IsJBTimeMax
            JBs = JBs + 1

            VelocityOnGround_old = VelocityOnGround
            VelocityOnGround = fVelocity
        
            if (VelocityOnGround ~= 0) then
                OnGroundVelocityArray[VelocityrraySize * 2] = VelocityOnGround
            end
            if (VelocityOnGround_old ~= 0 and VelocityOnGround ~= 0) then
                PlusOnGroundVelocityArray[VelocityrraySize * 2] = VelocityOnGround - VelocityOnGround_old
            end
        end
    end


    -- Save Units with with JB
    if (vVelocity_old.z < 0 and vVelocity.z > 0) then
        LastUnits = math.floor(Dist(vOriginOnGround, vOrigin) + 37 + 0.5)
        LastVert = math.floor((vOriginOnGround.z - vOrigin.z) * -1 + 3 + 0.5)
        vOriginOnGround = vOrigin
    end
    -- Save Units with Jumps
    if (not IsOnGroud_old and IsBit(Flags, ON_GROUND)) then
        LastUnits = math.floor(Dist(vOriginOnGround, vOrigin) + 37 + 0.5)
        LastVert = math.floor((vOriginOnGround.z - vOrigin.z) * -1 + 3 + 0.5)
    elseif (IsOnGroud_old and IsBit(Flags, ON_GROUND) or IsOnGroud_old and not IsBit(Flags, ON_GROUND)) then
        vOriginOnGround = vOrigin
    end

	if (LastUnits > 500) then
	    LastUnits = 0
        LastVert = 0
	end

    -- Delete OnGround Saves bc u r OnGround so long
    if (IsBit(Flags, ON_GROUND) and GetTickCount() > (OnGroundTime + OnGroundTimeMax)) then
        VelocityOnGround_old = 0
        VelocityOnGround = 0

        LastUnits = 0
        LastVert = 0
    end
end

function DrawVelocity(Flags, fVelocity, vVelocity, vOrigin, iMoveType, fStamina)
    -- Render Velocity or Velocity with Old Velocity [TYPE 1]
    local Text = tostring(fVelocity)
	local StaminaText = string.sub(fStamina,1,4)
	local StA = math.floor(fStamina)
	local fntsize = Menu.GetInt("fontsizee")
	local stc = Color.new(0,0,0,0)
    if (not Menu.GetBool("bShowVelocity")) then 
        Text = ""
    end
	local VeloPos = Globals.ScreenHeight() / Menu.GetFloat("fVelPosY")

local StaminaPos = Globals.ScreenHeight() / Menu.GetFloat("fStPosY")
	--rainbow stuff
	    local chromaSpeed = Menu.GetInt("rbspeed")
	local fogalpha = Menu.GetFloat("falpha")
    local r = math.floor(math.sin(IGlobalVars.realtime * chromaSpeed) * 127 + 128)
    local g = math.floor(math.sin(IGlobalVars.realtime * chromaSpeed + 2) * 127 + 128)
    local b = math.floor(math.sin(IGlobalVars.realtime * chromaSpeed + 4) * 127 + 128)
    local rfog = Color.new(r,g,b,255)
    local rbv = Color.new(r,g,b,255)
	local rbs = Color.new(r,g,b,255)
local col
  local ap = fVelocity
    -- velocity alpha modulation
	 
	
	
	
	if Menu.GetInt("vct") == 0 then
	col = Menu.GetColor("stv")
	if (Menu.GetBool("vam")) == true then 
	col.a = ap
	if (ap >= 255) then
	 col.a = 255
	 end
	 else col.a = 255
	 end
	elseif Menu.GetInt("vct") == 1 then
    if (fVelocity > fVelocity_old) then
       col = Menu.GetColor("dvelo1")
    elseif (fVelocity < fVelocity_old) then
       col = Menu.GetColor("dvelo3")
    else
        col = Menu.GetColor("dvelo2")
    end
	if Menu.GetBool("vam") == true then
	 if (fVelocity > fVelocity_old) then
       col = Menu.GetColor("dvelo1")
		col.a = ap
	 if (ap >= 255) then
	 col.a = 255
	 end
    elseif (fVelocity < fVelocity_old) then
       col = Menu.GetColor("dvelo3")
		col.a = ap
	 if (ap >= 255) then
	 col.a = 255
	 end
    else
        col = Menu.GetColor("dvelo2")
	 col.a = ap
	 if (ap >= 255) then
	col.a = 255
	end
	end
	end
	end
	
    
	 
	
	 
	 
	 if Menu.GetInt("vct") == 2 then
	 col = rbv
	 if (Menu.GetBool("vam")) == true then 
	col.a = ap
	if (ap >= 255) then
	 col.a = 255
	 end
	 else col.a = 255
	 end
	 end
	

   
	
    if Menu.GetInt("sct") == 0 then
	   stc = Menu.GetColor("stc")
		if (Menu.GetBool("sam")) == true then
		stc.a = StA * 13
		if stc.a >= 255 then
		stc.a = 255
		end
		end
		end
    if Menu.GetInt("sct") == 1 then
	stc = rbs
	if (Menu.GetBool("sam")) == true then
		stc.a = StA * 13
		if stc.a >= 255 then
		stc.a = 255
		end
		end
	end

	
	
	
	
	if (Menu.GetBool("rfog")) == true then
	SetBool(Vars.misc_Fog, true)
	SetColor(Vars.color_Fog, rfog)
	SetFloat(Vars.misc_FogAlpha, fogalpha)
	end
	
	if (Menu.GetBool("nosleeves")) == true then
	SetBool(Vars.chams_sleeve_enabled, true)
	SetInt(Vars.chams_sleeve_material_visible, 1)
	SetColor(Vars.color_chams_local_sleeve, Color.new(0,0,0,0))
	end
	
	if not (Menu.GetBool("bShowStamina")) == true then
	stc.a = 0
	end


     if (Menu.GetInt("iShowVelocityOld") == 2) then 
    local kamicol = Color.new(col.r, col.g, col.b, kamicolalpha)
   local kovg = Menu.GetFloat("kvg")
 if fVelocity >= 0 then
      KamiVeloPos = KamiVeloPos - 2    
end
if KamiVeloPos < VeloPos - kovg then
KamiVeloPos = VeloPos - kovg
if kamicolalpha > 0 and (not IsBit(Flags, ON_GROUND))  then
kamicolalpha = kamicolalpha - 1.5
else
kamicolalpha = 0
end
elseif KamiVeloPos > VeloPos - kovg  then
if kamicolalpha < 255 and (not IsBit(Flags, ON_GROUND)) then 
kamicolalpha = kamicolalpha + KamiVeloPos / 45
else
kamicolalpha = 255
end
end
if (IsBit(Flags, ON_GROUND)) then
	KamiVeloPos = VeloPos
	kamicolalpha = 0
	end
 kamicol.a = kamicolalpha
 if kamicolalpha == 255 then
kamicol.a = 255
end
  if (Menu.GetInt("fontchange")) == 0 then 
    if (VelocityOnGround > 0) then   
        Render.Text_1(VelocityOnGround , Globals.ScreenWidth() / 2, KamiVeloPos, fntsize + 1, kamicol, true, true)
        TextOffsetY = TextOffsetY + 22

    end
	else
	if (VelocityOnGround > 0) then   
        Render.Text(VelocityOnGround , Globals.ScreenWidth() / 2, KamiVeloPos, fntsize + 1, kamicol, true, true, "cstm")
        TextOffsetY = TextOffsetY + 22

    end
	end
end

    if (Menu.GetInt("fontchange")) == 0 then 
    if (Menu.GetInt("iShowVelocityOld") == 1 and VelocityOnGround > 0) then 
       

        Render.Text_1(Text, Globals.ScreenWidth() / 2 - Render.CalcTextSize_1("(" .. VelocityOnGround .. ")", fntsize).x / 2,  VeloPos, fntsize, col, true, true)
        Render.Text_1("(" .. VelocityOnGround .. ")", Globals.ScreenWidth() / 2 - Render.CalcTextSize_1("(" .. VelocityOnGround .. ")", fntsize).x / 2 + Render.CalcTextSize_1(Text, fntsize).x / 2 + 4, VeloPos, fntsize, col, false, true)
		Render.Text_1(StaminaText, Globals.ScreenWidth() / 2, VeloPos + StaminaPos,fntsize, stc, true, true)
    else
        Render.Text_1(Text, Globals.ScreenWidth() / 2, VeloPos, fntsize, col, true, true)
		
	
		Render.Text_1(StaminaText, Globals.ScreenWidth() / 2,VeloPos + StaminaPos,fntsize, stc, true, true)
		
    end
	end
	
    if (Menu.GetInt("fontchange")) == 1 then 
    if (Menu.GetInt("iShowVelocityOld") == 1 and VelocityOnGround > 0) then 
       

        Render.Text(Text, Globals.ScreenWidth() / 2 - Render.CalcTextSize_1("(" .. VelocityOnGround .. ")", fntsize).x / 2, VeloPos, fntsize, col, true, true, "cstm")
        Render.Text("(" .. VelocityOnGround .. ")", Globals.ScreenWidth() / 2 - Render.CalcTextSize_1("(" .. VelocityOnGround .. ")", fntsize).x / 2 + Render.CalcTextSize_1(Text, fntsize).x / 2 + 4, VeloPos, fntsize, col, false, true, "cstm")
		Render.Text(StaminaText, Globals.ScreenWidth() / 2, VeloPos + StaminaPos,fntsize, stc, true, true, "cstm")
    else
        Render.Text(Text, Globals.ScreenWidth() / 2, VeloPos, fntsize, col, true, true, "cstm")
		
	
		Render.Text(StaminaText, Globals.ScreenWidth() / 2, VeloPos + StaminaPos,fntsize, stc, true, true, "cstm")
		
    end
	end
	   
   
	


    TextOffsetY = TextOffsetY + 22
	
	end
	






function DrawIndicator(Flags, fVelocity, vVelocity, vOrigin, iMoveType, fStamina)
    

    -- Render JB Status
    if (GetTickCount() < IsJBTime) then 
        TextOffsetY = TextOffsetY + 22
        jbsc = 1
		else jbsc = 0
    end
 
	
	if InputSys.IsKeyDown(Menu.GetInt("sh")) then
	if VelocityOnGround_old >= fVelocity then
	shsc = 1
	else 
	shsc = 0
	end
	end
	
	if (InputSys.IsKeyDown(GetInt(Vars.misc_edgejump_key))) then
	ljsc = 1
	if (not IsBit(Flags, ON_GROUND)) then
	ljsc = 2
	end
	end
	
	end


local function SpecList()
    if (not Menu.GetBool("bSpecList")) then return end
    

    UpdateSpecList()
    RenderSpecList()
end
Hack.RegisterCallback("PaintTraverse", SpecList)
-- Ignore some TimesW
local VelocityTime = 0
local VelocityTimeToUpdate = 64

function PaintTraverse()

	
--watermark
   local fntsize = Menu.GetInt("fontsizee")
   TextOffsetY = 0
    PosY = Globals.ScreenHeight() / Menu.GetFloat("fVelPosY")
    if (not Utils.IsLocalAlive()) then return end
    local pLocal = IEntityList.GetPlayer(IEngine.GetLocalPlayer()) 
    if (not pLocal) then 
        return
    end




    local Flags = pLocal:GetPropInt(fFlags_Offset)
    local fVelocity = math.floor(VecLenght2D(pLocal:GetPropVector(vVelocity_Offset)) + 0.5)
    local vVelocity = pLocal:GetPropVector(vVelocity_Offset)
    local vOrigin = pLocal:GetPropVector(vOrigin_Offset)
    local iMoveType = pLocal:GetMoveType()
    local fStamina = pLocal:GetPropFloat(fStamina_Offset)

    BuildVelocityInfo(Flags, fVelocity, vVelocity, vOrigin, iMoveType, fStamina)

   

    DrawVelocity(Flags, fVelocity, vVelocity, vOrigin, iMoveType, fStamina)
    DrawOldVelocity(Flags, fVelocity, vVelocity, vOrigin, iMoveType, fStamina)

    DrawIndicator(Flags, fVelocity, vVelocity, vOrigin, iMoveType, fStamina)

    -- Save
    if (GetTickCount() - VelocityTime > VelocityTimeToUpdate) then
        fVelocity_old = fVelocity
        VelocityTime = GetTickCount()
    end

    IsOnGroud_old = IsBit(Flags, ON_GROUND)
    vVelocity_old = vVelocity



if (Menu.GetBool("sway") == true) then
swayy:SetFloat(0);
q:SetFloat(0);
latt:SetFloat(0);
verttt:SetFloat(0);
    
  end
  
	
 if (Menu.GetBool("exteb")) == true then
 
SetInt(Vars.misc_edgebug2_ticks, 256)

end
 local ljendfixx = 0
 
 if (Menu.GetBool("ljendfix")) == true then
  if(not IsBit(Flags, ON_GROUND)) then
ljendfixx = ljendfixx + 1
cooldown = IGlobalVars.realtime + 0.4
else
ljendfixxx = 0
end
   if ljendfixx == 1 and  (InputSys.IsKeyDown(GetInt(Vars.misc_edgejump_key))) then
   ljendfixxx = ljendfixxx + 1
 end
if ljendfixxx >= 1
then
SetBool(Vars.misc_longjump_end, true)

else
if IGlobalVars.realtime > cooldown then

SetBool(Vars.misc_longjump_end, false)
end
end
end







    local ifntsize = Menu.GetInt("ifontsizee")
	indicol = Menu.GetColor("indc")
	aindicol = Menu.GetColor("aindc")
	local alphaspeed = Menu.GetInt("apspeed")
    local PosY = Globals.ScreenHeight() / Menu.GetFloat("fIndPosY")
    local OffsetX = 0
	if hit == 1 then
	rok.g = aindicol.g
	rok.r = aindicol.r
	rok.b = aindicol.b
	end
	if hit == 0 then
	rok.g = indicol.g
	rok.r = indicol.r
	rok.b = indicol.b

	end
	if shsc == 1 then
	sh.g = aindicol.g
	sh.r = aindicol.r
	sh.b = aindicol.b
	end
	if shsc == 0 then
	sh.r = indicol.r
	sh.g = indicol.g
	sh.b = indicol.b

	end
    
	if ebcd >= IGlobalVars.realtime then
	eb.g = aindicol.g
	eb.r = aindicol.r
	eb.b = aindicol.b
	end
	if ebcd <= IGlobalVars.realtime then
	eb.r = indicol.r
	eb.g = indicol.g
	eb.b = indicol.b
	end
   if ljsc == 2 then
	ej.r = aindicol.r
	ej.g = aindicol.g
	ej.b = aindicol.b
	else
	ej.r = indicol.r
	ej.g = indicol.g
	ej.b = indicol.b
	end
	if  jbsc == 1 then
	jb.r = aindicol.r
	jb.g = aindicol.g
	jb.b = aindicol.b
	else
	jb.r = indicol.r
	jb.g = indicol.g
	jb.b = indicol.b
	end
	mj.r = indicol.r
	mj.g = indicol.g
	mj.b = indicol.b
	
	al.r = indicol.r
	al.g = indicol.g
	al.b = indicol.b
	
	
----------------------indicators section
if (Menu.GetBool("showindi") and InputSys.IsKeyDown(Menu.GetInt("pxal"))) then

           
			alkeypress = alkeypress + alphaspeed
		    else
			alkeypress = alkeypress - alphaspeed * 2
        end


if (Menu.GetBool("showindi") and InputSys.IsKeyDown(Menu.GetInt("rok"))) then

           
			rokkeypress = rokkeypress + alphaspeed
		    else
			rokkeypress = rokkeypress - alphaspeed * 2
        end


if (Menu.GetBool("showindi") and InputSys.IsKeyDown(Menu.GetInt("sh"))) then

           
			shkeypress = shkeypress + alphaspeed
		    else
			shkeypress = shkeypress - alphaspeed * 2
        end

	
    if (Menu.GetBool("showindi") and GetBool(Vars.misc_edgejump) and GetInt(Vars.misc_edgejump_enabletype) == 1) then
        if (InputSys.IsKeyDown(GetInt(Vars.misc_edgejump_key))) then
            
	
	 
           
			ejkeypress = ejkeypress + alphaspeed
		    else
			ejkeypress = ejkeypress - alphaspeed * 2
        end
    end
  
    if (Menu.GetBool("showindi") and GetBool(Vars.misc_jumpbug)) then
        if (InputSys.IsKeyDown(GetInt(Vars.misc_jumpbug_key))) then
            
            
			jbkeypress = jbkeypress + alphaspeed
			else
			jbkeypress = jbkeypress - alphaspeed * 2
			
        end
    end
     if (Menu.GetBool("showindi") and GetBool(Vars.misc_edgebug2)) then
        if (InputSys.IsKeyDown(GetInt(Vars.misc_edgebug2_key))) then
            
            
			ebkeypress = ebkeypress + alphaspeed
			else 
			ebkeypress = ebkeypress - alphaspeed * 2
        end
    end
    if (Menu.GetBool("showindi") and GetBool(Vars.misc_minijump)) then
        if (InputSys.IsKeyDown(GetInt(Vars.misc_minijump_key1))) then
            
            mjkeypress = mjkeypress + alphaspeed
		    else
			mjkeypress = mjkeypress - alphaspeed * 2
			
			
        end 
    end
	--rok	

	if rokkeypress > 255 then
	    rokkeypress = 255
	end
	if (Menu.GetInt("fontchange")) == 1 then 
	Render.Text("rage", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, rok, true, true, "cstm")
	else
	Render.Text_1("rage", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, rok, true, true)
	end
    if rokkeypress > 1 then
		OffsetX = OffsetX + 33
	end
	if rokkeypress <= 0 then
	    rokkeypress = 0
    end

	rok.a = rokkeypress

	--sh

	if shkeypress > 255 then
	    shkeypress = 255
	end
	if (Menu.GetInt("fontchange")) == 1 then 
	Render.Text("sh", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, sh, true, true, "cstm")
	else
	Render.Text_1("sh", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, sh, true, true)
	end
    if shkeypress > 1 then
		OffsetX = OffsetX + 33
	end
	if shkeypress <= 0 then
	    shkeypress = 0
    end

	sh.a = shkeypress

	--eb
	if ebkeypress > 255 then
	    ebkeypress = 255
	end
	if (Menu.GetInt("fontchange")) == 1 then 
	Render.Text("eb", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, eb, true, true, "cstm")
	else
	Render.Text_1("eb", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, eb, true, true)
	end
    if ebkeypress > 1 then
		OffsetX = OffsetX + 33
	end
	if ebkeypress <= 0 then
	    ebkeypress = 0
    end

	eb.a = ebkeypress
	
----------------------------------------------------ej
	 
	if ejkeypress > 255 then
	   ejkeypress = 255
	end
	if (Menu.GetInt("fontchange")) == 1 then 
	Render.Text("lj", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, ej, true, true, "cstm")
	else
	Render.Text_1("lj", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, ej, true, true)
	end
	if ejkeypress > 1 then
		OffsetX = OffsetX + 33
	end
	if ejkeypress < 0 then
	   ejkeypress = 0
	end
	
	ej.a = ejkeypress

----------------------------------------------------jb
	if jbkeypress > 255 then
	   jbkeypress = 255
	end
	if (Menu.GetInt("fontchange")) == 1 then 
	Render.Text("jb", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, jb, true, true, "cstm")
	else
	Render.Text_1("jb", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, jb, true, true)
	end
	if jbkeypress <= 0 then
	   jbkeypress = 0
	end
    if jbkeypress > 1 then
		OffsetX = OffsetX + 33
	end
	
	jb.a = jbkeypress
	
---------------------------------------------------mj
if mjkeypress > 255 then
	   mjkeypress = 255
	end
	if (Menu.GetInt("fontchange")) == 1 then 
	Render.Text("mj", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, mj, true, true, "cstm")
	else
	Render.Text_1("mj", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, mj, true, true)
	end
	if mjkeypress <= 0 then
	   mjkeypress = 0
	end
    if mjkeypress > 1 then
		OffsetX = OffsetX + 33
	end
	
	mj.a = mjkeypress
---------------------------------------------al
if alkeypress > 255 then
	   alkeypress = 255
	end
	if (Menu.GetInt("fontchange")) == 1 then 
	Render.Text("al", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, al, true, true, "cstm")
	else
	Render.Text_1("al", Globals.ScreenWidth() / 2 + 3, PosY + OffsetX, ifntsize, al, true, true)
	end
	if alkeypress <= 0 then
	   alkeypress = 0
	end
    if alkeypress > 1 then
		OffsetX = OffsetX + 33
	end
	
	al.a = alkeypress
	
		
	
if (Menu.GetBool("showpos")) then
local backroundclr = GetColor(Vars.misc_ImGuiCol_MainBG_First)
backroundclr.a = 80 

local cursor = InputSys.GetCursorPos()
local pospositiony1 = pospositiony + 3
local pospositiony2 = pospositiony + 30   
local posssizex =  pospositionx + 130
local posssizey =  pospositiony + 60
  if cursor.x >= pospositionx and cursor.x <= posssizex then
            if cursor.y >= pospositiony and cursor.y <= posssizey then
                if InputSys.IsKeyDown(1) then
                    Dragging = "t" --supposed to be a bool but I was way to fucking lazy to change it from my old string system (I did parsing be fucking proud atleast)
                else
                    Dragging = "f"
                end
            else
                if InputSys.IsKeyDown(0) or OldDragging == "f" then Dragging = "f" end
            end
        else
            if InputSys.IsKeyDown(0) or OldDragging == "f" then Dragging = "f" end
        end		
		
		
colx = Menu.GetColor("aindicol")
col2 = Menu.GetColor("indicol")

local alignx = positx -(math.ceil(positx))
if alignx == 0
then 
colx = aindicol

else
colx = indicol

end
local aligny = posity -(math.ceil(posity))
if aligny == 0
then 
coly = aindicol
else
coly = indicol

end




	
    Render.RectFilled(pospositionx,  pospositiony, posssizex, posssizey, backroundclr, 4)
	 if (Menu.GetInt("fontchange")) == 0 then 
	Render.Text_1("x:", pospositionx + 5, pospositiony1 + 3, 25, colx, false, true)
	Render.Text_1("y:", pospositionx + 5, pospositiony2 , 25, coly, false, true)
	Render.Text_1(tostring(positx), pospositionx + 25, pospositiony1 + 3, 25, colx, false, true)
	Render.Text_1(tostring(posity), pospositionx + 25, pospositiony2, 25, coly, false, true)
	else
	Render.Text("x:", pospositionx + 5, pospositiony1 + 3, 25, colx, false, true, "cstm")
	Render.Text("y:", pospositionx + 5, pospositiony2 , 25, coly, false, true, "cstm")
	Render.Text(tostring(positx), pospositionx + 25, pospositiony1 + 3, 25, colx, false, true, "cstm")
	Render.Text(tostring(posity), pospositionx + 25, pospositiony2, 25, coly, false, true, "cstm")
	end

end

end
Hack.RegisterCallback("PaintTraverse", PaintTraverse)

local IsX = 0
local function CreateMove(cmd, p_bSendPacket, send)


local pLocal = IEntityList.GetPlayer(IEngine.GetLocalPlayer())
	local vVelocity_Offset = Hack.GetOffset("DT_BasePlayer", "m_vecVelocity[0]")
    local Flags = pLocal:GetPropInt(fFlags_Offset)
    local fVelocity = math.floor(VecLenght2D(pLocal:GetPropVector(vVelocity_Offset)) + 0.5)
    local vVelocity = pLocal:GetPropVector(vVelocity_Offset)
    local vOrigin = pLocal:GetPropVector(vOrigin_Offset)
    local iMoveType = pLocal:GetMoveType()
    local fStamina = pLocal:GetPropFloat(fStamina_Offset)
	    if (not Utils.IsLocalAlive()) then return end
 npz = (vVelocity.z)
	
	


	
	


		hPos = pLocal:GetAbsOrigin()
		if hPos.x < 0 and hPos.x > -10 then
	positx = string.sub(hPos.x,1,5)
	elseif hPos.x < -10 and hPos.x > -100 then
	positx = string.sub(hPos.x,1,6)
	elseif hPos.x < -100 and hPos.x > -1000 then
	positx = string.sub(hPos.x,1,7)
	elseif hPos.x < -1000 and hPos.x > -10000 then
	positx = string.sub(hPos.x,1,8)
		elseif hPos.x > 0 and hPos.x < 10 then
	positx = string.sub(hPos.x,1,4)
	elseif hPos.x > 10 and hPos.x < 100 then
	positx = string.sub(hPos.x,1,5)
	elseif hPos.x > 100 and hPos.x < 1000 then
	positx = string.sub(hPos.x,1,6)
	elseif hPos.x > 1000 and hPos.x < 10000 then
	positx = string.sub(hPos.x,1,7)
	end
			if hPos.y < 0 and hPos.y > -10 then
	posity = string.sub(hPos.y,1,5)
	elseif hPos.y < -10 and hPos.y > -100 then
	posity = string.sub(hPos.y,1,6)
	elseif hPos.y < -100 and hPos.y > -1000 then
	posity = string.sub(hPos.y,1,7)
	elseif hPos.y < -1000 and hPos.y > -10000 then
	posity = string.sub(hPos.y,1,8)
		elseif hPos.y > 0 and hPos.y < 10 then
	posity = string.sub(hPos.y,1,4)
	elseif hPos.y > 10 and hPos.y < 100 then
	posity = string.sub(hPos.y,1,5)
	elseif hPos.y > 100 and hPos.y < 1000 then
	posity = string.sub(hPos.y,1,6)
	elseif hPos.y > 1000 and hPos.y < 10000 then
	posity = string.sub(hPos.y,1,7)
	end
	
			

	if (Menu.GetBool("aseb") and (InputSys.IsKeyDown(GetInt(Vars.misc_edgebug2_key))) and ebsc == 0) then
        SetBool(Vars.misc_autostrafe, true)
		

	else
	     SetBool(Vars.misc_autostrafe, false)
    end 		

 




if InputSys.IsKeyDown(Menu.GetInt("sh")) then
        SetBool(Vars.misc_bhop_chance_mode, true)
		SetInt(Vars.misc_bhop_delay_always_min, 1)
		SetInt(Vars.misc_bhop_delay_always_max, 2)
		SetInt(Vars.misc_bhop_jumps_min, 0)
		SetInt(Vars.misc_bhop_jumps_max, 100)
		SetInt(Vars.misc_bhop_delay_miss_min, 1)
		SetInt(Vars.misc_bhop_delay_miss_max, 2)
		
		SetFloat(Vars.misc_bhop_chance,0)

		else
		SetBool(Vars.misc_bhop_chance_mode, false)
    end 
	

	
	
	
	if InputSys.IsKeyDown(Menu.GetInt("rok")) then
        SetBool(Vars.ragebot_enabled, true)
		else
		SetBool(Vars.ragebot_enabled, false)
    end 
   
	local rage = 0



	

 local clientAng = QAngle.new(0,0,0)
        IEngine.GetViewAngles(clientAng)
		angx = clientAng.pitch
angy = clientAng.yaw
    local localPos = pLocal:GetAbsOrigin()
 

	
xdir = (vVelocity.x)
ydir = (vVelocity.y)
zdir = (vVelocity.z)
if (Menu.GetInt("alt")) == 0 then
if angy > -180 and angy < 0 then
if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposy = localPos.y 
lposx = math.ceil(localPos.x) 
end

if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposy = localPos.y 
lposx = math.floor(localPos.x) 
end
end
if angy < 180 and angy > 0 then
if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposy = localPos.y 
lposx = math.ceil(localPos.x) 
end

if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposy = localPos.y 
lposx = math.floor(localPos.x) 
end
end

end
 if (Menu.GetInt("alt")) == 1 then 
 if angy < -90 and angy > -180 then
if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.ceil(localPos.y) 
end
if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.floor(localPos.y) 

end
end
if angy < 180 and angy > 90 then
if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.ceil(localPos.y) 
end
if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.floor(localPos.y) 
end
end

if angy < 90 and angy > 0 then
if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.ceil(localPos.y) 
end
if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.floor(localPos.y) 

end
end
if (angy < 0 and angy > -90) then
if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.ceil(localPos.y) 
end
if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.floor(localPos.y) 
end
end

 end
 if (Menu.GetInt("alt")) == 2 then 
if xdir > ydir then
if angy > -180 and angy < 0 then
if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposy = localPos.y 
lposx = math.ceil(localPos.x) 
end

if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposy = localPos.y 
lposx = math.floor(localPos.x) 
end
end
if angy < 180 and angy > 0 then
if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposy = localPos.y 
lposx = math.floor(localPos.x) 
end

if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposy = localPos.y 
lposx = math.floor(localPos.x) 
end
end
end
if ydir > xdir then

if angy < -90 and angy > -180 then
if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.ceil(localPos.y) 
end
if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.floor(localPos.y) 

end
end
if angy < 180 and angy > 90 then
if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.ceil(localPos.y) 
end
if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.floor(localPos.y) 
end
end

if angy < 90 and angy > 0 then
if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.ceil(localPos.y) 
end
if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.floor(localPos.y) 

end
end
if (angy < 0 and angy > -90) then
if InputSys.IsKeyDown(65) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.ceil(localPos.y) 
end
if InputSys.IsKeyDown(68) then
lposz = localPos.z
lposx = localPos.x 
lposy = math.floor(localPos.y) 
end
end
end
end



    if InputSys.IsKeyDown(Menu.GetInt("pxal")) then
	
        local wAng = QAngle.new(0,0,0)
		alignPos.x = lposx
	alignPos.y =  lposy
	alignPos.z = lposz
        Math.VectorAngles(Vector.new(alignPos.x - localPos.x, alignPos.y - localPos.y, alignPos.z - localPos.z), wAng)
        
        local dist = Math.VectorDistance(localPos, alignPos)
        
        if dist < 0.08 then
            isAligning = false
           
        end
        
        local clientAng = QAngle.new(0,0,0)
        IEngine.GetViewAngles(clientAng)

       cmd.forwardmove = dist  + 10
        Utils.CorrectMovement(wAng, cmd, cmd.forwardmove, 0, false)
    end

end   
Hack.RegisterCallback("CreateMove", CreateMove)
local function CreateMovePredict() 
  ebsc = 0

   local vVelocity_Offset = Hack.GetOffset("DT_BasePlayer", "m_vecVelocity[0]")
    local pLocal = IEntityList.GetPlayer(IEngine.GetLocalPlayer()) 
    local vVelocity = pLocal:GetPropVector(vVelocity_Offset)
	 pz = (vVelocity.z)
if (pz > npz and pz < -6.0) then


     ebsc = 1
     ebcd = IGlobalVars.realtime + 0.2
	 

end
end
Hack.RegisterCallback("CreateMovePredict", CreateMovePredict)  





function FrameStageNotify(stage)
   

    if Dragging ~= "f" then
        local cursor = InputSys.GetCursorPos()
        if OldDragging == "f" then
            DraggingOffset = Vector.new(pospositionx - cursor.x, pospositiony - cursor.y, 0)
        end
        pospositionx = cursor.x + DraggingOffset.x
        pospositiony = cursor.y + DraggingOffset.y
    else
        DraggingOffset = Vector.new(0, 0, 0)
    end
    OldDragging = Dragging
	
	
	

    if SpecDragging ~= "f" then
        local cursor = InputSys.GetCursorPos()
        if SpecOldDragging == "f" then
            SpecDraggingOffset = Vector.new(specpositionx - cursor.x, specpositiony - cursor.y, 0)
        end
        specpositionx = cursor.x + SpecDraggingOffset.x
        specpositiony = cursor.y + SpecDraggingOffset.y
    else
        SpecDraggingOffset = Vector.new(0, 0, 0)
    end
    SpecOldDragging = SpecDragging
end
Hack.RegisterCallback("FrameStageNotify", FrameStageNotify)


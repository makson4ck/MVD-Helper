local ffi = require 'ffi'
local imgui = require 'mimgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8
local new = imgui.new
local faicons = require('fAwesome6')
local new, str = imgui.new, ffi.string
local sampev = require('lib.samp.events')
local sizeof = ffi.sizeof

function saveini(path,table)
    local file = io.open(path, "w+")
    if file then
        file:write(ini.encode(table))
        file:close()
        return true
    else
        file = io.open(path, "r")
    end
end

function loadini(path)
    local file = io.open(path)
    if file then
        local success, data = pcall(ini.decode, file:read('*a'))
        file:close()
        if success then
            if data then
                return data
            else
                return false
            end
        else
            saveini(path, {})
            return {}
        end
    else
        return false
    end
end

local inicfg = require 'inicfg'
local iniFile = 'Styles.ini'
local ini = inicfg.load({
	cfg = {
		theme = 0,
		style = 0
	}
}, iniFile)
if not doesDirectoryExist(getWorkingDirectory()..'\\config') then print('Creating the config directory') createDirectory(getWorkingDirectory()..'\\config') end
if not doesFileExist('moonloader/config/'..iniFile) then print('Creating/updating the .ini file') inicfg.save(ini, iniFile) end

local theme = new.int(ini.cfg.theme)
local style = new.int(ini.cfg.style)

local spawncar = false

local bSettings = {
    update = {
        version = "betta 1.0.0",
        needupdate = false,
        updateText = "������� �� \"��������� ����������\""
    },
}

local themesList, stylesList = {}, {}

imgui.OnInitialize(function()
	imgui.GetIO().IniFilename = nil
	for i, v in ipairs(themes) do table.insert(themesList, v.name) end
	for i, v in ipairs(styles) do table.insert(stylesList, v.name) end

	themes[theme[0]+1].func()
	styles[style[0]+1].func()
end)

local sizeX, sizeY = getScreenResolution()


function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(u8(text))
end
--���� �����

local ini = inicfg.load({
    cfg =
    {
mytag = "",
totag = ""
    }}, "Auto Tag MH.ini")
    
    local mytag = new.char[255](u8(ini.cfg.mytag))
local totag = new.char[255](u8(ini.cfg.totag))
local zk = "-"

local org = 0 
local rank = 0
function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
  for line in text:gmatch('[^\n]+') do
if line:find('���������: (.*)') then
    rank = line:gsub('{......}', ''):match('���������: (.*)')
end
   
if line:find('�����������: (.*)') then
    org = line:gsub('{......}', ''):match('�����������: (.*)')
end
end
end

--
local myID = select(2, sampGetPlayerIdByCharHandle(1))
local aidi = imgui.new.int(0)
local idsu = imgui.new.int(0)
local tab = 1
local WinState = new.bool()
local Roz = new.bool()

imgui.OnFrame(function()
    return Roz[0]
end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(500,500), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5)) -- ��������� ���� �� ������
    imgui.SetNextWindowSize(imgui.ImVec2(1000, 480), imgui.Cond.Always) -- ������ ����
    imgui.Begin(faicons('user_police') .. u8' Police Helper I ������ �������', Roz) -- �������� ����

    if imgui.Button(faicons('user_police') .. u8' ������', imgui.ImVec2(160, 60)) then
        tab = 1
    end

imgui.SetCursorPos(imgui.ImVec2(175, 33))
if imgui.BeginChild('Name', imgui.ImVec2(-1, -1), true) then



        if tab == 1 then
            if imgui.CollapsingHeader(faicons('keyboard') .. u8' ������������, ������, ���������') then 
		
                local _, changed = imgui.InputInt(u8'������� ID ������', aidi)
                    if changed then
                            aidi = imgui.new.int(aidi[0])
                        end
                        
        if imgui.Button(faicons('USER_CHECK') .. u8' 9.5�� ������������� ����� ��������� ����������, �������, ������������ ������������ ���� (���������� SWAT, FBI, LSPD, LSSD, SFPD; ��������������� ��� ���������� ������, ����������� �� �����; �����). * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 9.5 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' 9.6�� ����� ��� ��������� �� ������ ������ ����������� ����������� �����. * 2', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 2 9.6 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 10.2 ���������� ������������ ����������� ������� ������������ (SFPD, FBI, LSPD, LSSD, SWAT) ������� ����������, ��������� � ������������� ������� � �� ��������������� ������. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 10.2 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' ��5.10 ������� ������ � �������� ����. * 2', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 2 5.10 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 5.11 ��������/���������/�������������/���� ����������. * 4', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 4 5.11 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 5.12 ������/���������/������������� ������ ��� ������� ��������. * 4', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 4 5.12 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 5.14 ����������� �������/������� �������������� ������. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 5.14 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 6.1 ����/���������/��������/������������ ������������� �������. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 6.1 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 6.2 ����������� ����������. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 6.2 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 6.3 ������ ��� ������� ������� ������������� �������. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 6.3 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 6.4 �������/�������/��������/��������� ����� ����������. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 6.4 ��')
            end)
        end
    end

    if imgui.CollapsingHeader(faicons('keyboard') .. u8' ������������ ������ ����� � ��������, �������, ����������� ��������.') then 
		
        local _, changed = imgui.InputInt(u8'������� ID ������', aidi)
            if changed then
                    aidi = imgui.new.int(aidi[0])
                end

                if imgui.Button(faicons('USER_CHECK') .. u8' �� 3.1 ��������� �������� * 6', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 6 3.1 ��')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' �� 3.2 �������, �� ���� ��������������� �������� ������ ��������, ��������� ����� � ����������� ������� ���� ��� ����������� ��� ���������. * 2', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 2 3.2 ��')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' �� 3.3 �������, ������������ � ��������� �����������, ��������� �������� ���������� ���� � �������������� ������ ���������� ���������. * 4', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 4 3.3 ��')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' �� 3.4 �������, ����������� � ���������� ���� � ���������� ������������. * 3', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 3 3.4 ��')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' 3.5 ����������� ��� �������� ����� � ����������� ���������� �� �������������, �����������, ��������, ����������, �������� ��������. * 3', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' ')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' �� 3.6 ��������� ��� ��������������, ���� �� �������� ������������ ������������������ �����������, ������������ �������� �������������, ���������� ������������ �������. * 6', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 6 3.6 ��')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' �� 3.7 ���� ������ ���������� �� * 4', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 4 �� 3.7')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' �� 4.2 ������, �� ���� �������� ������� ������ ��������� ��������, �� �������������� ��������� ��� ����� � ��������. * 2', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 2 4.2 ��')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' ��  4.4 ������������� ���������� ����������� ��� ���� ������������ ��������� ��� ���� �������. * 2', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 2 4.4 ��')
                    end)
                end
                if imgui.Button(faicons('USER_CHECK') .. u8' 4.5 ������������� ���������� ����������� ��� ���� ������������ ��������� � ����� ������� ��� ��������� ������������ �������. * 3', imgui.ImVec2(-1, 25)) then 
                    lua_thread.create(function()
                        sampSendChat('/su '..aidi[0]..' 3 4.5 ��')
                    end)
                end
            end

            if imgui.CollapsingHeader(faicons('keyboard') .. u8' ������������ ������ ����������') then 
    
                local _, changed = imgui.InputInt(u8'������� ID ������', aidi)
                    if changed then
                            aidi = imgui.new.int(aidi[0])
                        end
                        
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.1 ������������� � ����� �� �� �� ���� ����� � ������������ ����, ���������, ����������� ���� ������� � ����� ������������������ ������������� ����������. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' ')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.2 ������, � ����� �������������� �� ����� �����, ��� ����� ����, ������������ � ����������� ����������, ���������, ��������, �����������, ��������� ��������, ��������� ����������� * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.2 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.3 ���������� � ����, ������������ � ����������� ���������� ��������� ��������������� ��� ���������� ����. * 1', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 1 8.3 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.4 �������� ���������� ����������, ���������� ��� ������ ��� ���������� ��� �������. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.4 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' ��  8.5 ����������� �������� ����������� � ��������� ��� ���������������� ���������������, ������� �����. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.5 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.6 ������ ���, ����������� � �������� ��������, � ����� ���� ��� ������� ���������� ��� ������ ���������. * 4', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 4 8.6 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.7 ���������� ������������ ���������� � �������� ���� ��������� ����, ������������� ��� ������������� ��� ��������� ������ � ����� ������������������ �� ����������. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.7 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' 8.8 �������� ���� ��� ����������� ����. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.8 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' 8.9 ������� � ����� ������������. * 4', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 4 8.9 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.10 ��������� �� �������������, ���������� � ����, ���������� ��������, ������� ���������� ���������������� �� ��������� �� ��������� ���������� ����� ��� ������ ��������� ��������������� * 4', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 4 8.10 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.11 ���� ������ ��������� �� ����� ���������� ��������� ��������. * 2', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 2 8.11 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.12 �� ������������ ��������� � ���� ����. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.12 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.13 �� ��������� � ������ �����/������� � ���� ����. * 2', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 2 8.13 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.14 �� �������/�������� �������� �������� � ���� ����. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.14 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.15 �� ����� �� ���������� �������� ���������� ����� �� ����� ��������� ���������. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 8.15 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.16 �� ������� ����� ��������� ���������. * 3', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 3 8.16 ��')
            end)
        end
        if imgui.Button(faicons('USER_CHECK') .. u8' �� 8.17 �� ���������/���������������/������ ����������� � ������� ����� ��� ������ ������ ��������� ���������. * 6', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
                sampSendChat('/su '..aidi[0]..' 6 8.17 ��')
            end)
        end
    end

    if imgui.CollapsingHeader(faicons('keyboard') .. u8' ��������� � ������������') then 
    
        local _, changed = imgui.InputInt(u8'������� ID ������', aidi)
            if changed then
                    aidi = imgui.new.int(aidi[0])
                end
                
if imgui.Button(faicons('USER_CHECK') .. u8' �� 11.1 ��������� � ������������� ����� �������. * 2', imgui.ImVec2(-1, 25)) then 
    lua_thread.create(function()
        sampSendChat('/su '..aidi[0]..' 2 11.1 ��')
    end)
end
if imgui.Button(faicons('USER_CHECK') .. u8' 11.2 ��������� � ������������� ������ �������. * 4', imgui.ImVec2(-1, 25)) then 
    lua_thread.create(function()
        sampSendChat('/su '..aidi[0]..' 4 11.2 ��')
    end)
end
if imgui.Button(faicons('USER_CHECK') .. u8' �� 11.3 ��������� � ���������������� �����. * 6', imgui.ImVec2(-1, 25)) then 
    lua_thread.create(function()
        sampSendChat('/su '..aidi[0]..' 6 11.3 ��')
    end)
end
if imgui.Button(faicons('USER_CHECK') .. u8' �� 11.4 ��������� � ������� ��� ��������� ���� � �������� ����������. * 6', imgui.ImVec2(-1, 25)) then 
    lua_thread.create(function()
        sampSendChat('/su '..aidi[0]..' 6 11.4 ��')
    end)
end
end
end
imgui.EndChild()
end
imgui.End()
end)

imgui.OnFrame(function()
    return WinState[0]
end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(500,500), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5)) -- �������� �� ��������� ���� �� ������
    imgui.SetNextWindowSize(imgui.ImVec2(1000, 480), imgui.Cond.Always) -- �������� �� ������ ����
    imgui.Begin(faicons('user_police') .. u8' Police Helper', WinState)
    
    if imgui.Button(faicons('user_police') .. u8' �������', imgui.ImVec2(160, 60)) then
        tab = 1
    end

    if imgui.Button(faicons('gears') .. u8' ���������', imgui.ImVec2(160, 60)) then
        tab = 6
    end

    if imgui.Button(faicons('keyboard') .. u8' ��������', imgui.ImVec2(160, 60)) then
        tab = 3
    end
    
    if imgui.Button(faicons('keyboard') .. u8' ����� ������������', imgui.ImVec2(160, 60)) then
        tab = 5
    end
    
    if imgui.Button(faicons('user') .. u8' ������� �������', imgui.ImVec2(160, 60)) then
        tab = 7
    end 

    if imgui.Button(u8' ���������� � ����������', imgui.ImVec2(160, 60)) then
        tab = 4
    end
     
imgui.SetCursorPos(imgui.ImVec2(175, 33))
if imgui.BeginChild('Name', imgui.ImVec2(-1, -1), true) then



        if tab == 1 then
        imgui.CenterText('��� ������� ����������: '..sampGetPlayerNickname(myID).. '[ ' ..myID.. ' ]') 
        imgui.CenterText('������� � �����������: ' ..org)
        imgui.CenterText('���������: ' ..rank)
        if imgui.Combo(u8'����', theme, new['const char*'][#themesList](themesList), #themesList) then 
			themes[theme[0]+1].func() 
			iniSave() 
		end
		if imgui.Combo(u8'�����', style, new['const char*'][#stylesList](stylesList), #stylesList) then 
			styles[style[0]+1].func() 
			iniSave() 
		end
		
		elseif tab == 6 then
				if imgui.CollapsingHeader(faicons('keyboard') .. u8' ���-����') then
imgui.Text(u8'10-1 - ������� ���� �������� �� ���������')
imgui.Text(u8'10-3 - ������������� (��� ������� ���������).')
imgui.Text(u8'10-4 - �������.')
imgui.Text(u8'10-5 - ��������� ��������� ���������')
imgui.Text(u8'10-6 - �� �������/�������/���.')
imgui.Text(u8'10-7 - ��������.')
imgui.Text(u8'10-8 - � ��������� ����� �����/�� ��������.')
imgui.Text(u8'10-9 - � ��������� ����� �����/�� �������� (��������� �� ��������).')
imgui.Text(u8'10-14 - ������ ��������������� (������� ������� � ���� ���������������).')
imgui.Text(u8'10-15 - ������������� ���������� (������� ���-�� �������������, �������).')
imgui.Text(u8'10-18 - ��������� ��������� �������������� ������.')
imgui.Text(u8'10-20 - �������.')
imgui.Text(u8'10-21 - ��������� � ������� � ���������������, �������� ��������.')
imgui.Text(u8'10-22 - ������������� � ������� (��������� � ����������� �������).')
imgui.Text(u8'10-27 - ����� ���������� ������� (������� ������ � ����� ����������).')
imgui.Text(u8'10-30 - �������-������������ ������������.')
imgui.Text(u8'10-40 - ������� ��������� ����� (4 � ������).')
imgui.Text(u8'10-41 - ����������� ����������.')
imgui.Text(u8'10-46 - ������� �����.')
imgui.Text(u8'10-55 - ������� ����')
imgui.Text(u8'10-66 - ��������� ����������� ����� (���� ��������, ��� ������������� � ���� ��������/�������� ������������. ���� ��������� ��������� ����� ������).')
imgui.Text(u8'10-70 - ������ ��������� (������� ���������� ������, ���).')
imgui.Text(u8' 10-71 - ������ ����������� ���������.')
imgui.Text(u8'10-99 - �������� �������������.')
end
				if imgui.CollapsingHeader(faicons('keyboard') .. u8' ������������ ����') then
				
imgui.Text(u8'CODE 1 - ������ (�������) �� ������� �� ������ / ����� ������� (�������).')
imgui.Text(u8'CODE 2 - �������� �����, ��� ������� � ����. ��������, ������ ���������� ���.')
imgui.Text(u8'CODE 3 - ������� �����, � ������� � ����. ���������, �������������...')
imgui.Text(u8'...��������� ������� ��� �������� ��.')
imgui.Text(u8'CODE 4 - �� ��������� ������ �� �������� / �������� ��������.')
imgui.Text(u8'CODE 6 - ���������� ������� ��������� �� ��������, �������� ������������ ��������.')
imgui.Text(u8'CODE 7 - ������ �� ������ �� ������ �� ����� ������ ���������� ������� ������� (��������� ������� � �.�.)...')
imgui.Text(u8'...��� ��������� ������� ��������� ��������� ������ ���� ����������� � ��������������� ������ ���� � ����������.')
imgui.Text(u8'CODE 20 - ����� ������� ����� ��������� �������� � (���) ����� ����� ���������� �������������� ����� ���.')
imgui.Text(u8'CODE 37 - ��������� �� ����������� ��������� ������������� �������� � ��������� ����������� � ��� ��������.')
imgui.Text(u8'CODE 100 - ��������� ���� ������ �������������� ��������� ��� ����������� ���������� ������� � ��������� �������.')
imgui.Text(u8'CODE ROBERT RIFLE - ������ ����������� �������� ��� ��������������� ������� ������������ ��������� �� ���� �������.')
imgui.Text(u8'CODE ROBERT SLUG - ������ ����������� ����� (��������) ��� ��������������� ������� ������������...')
imgui.Text(u8'...������ (����������) �� ���� �������.')
imgui.Text(u8'CODE TOM - ������ ����������� ��������������� ������� ������������ TASER-�� �� ���� �������.')
end
		elseif tab == 7 then
        imgui.CenterText('/asu - ������ ���� ������ �������(������ ��� 05)')
        imgui.CenterText('/on - ��������� ������')
        imgui.CenterText('/of - ���������� ������')
        imgui.CenterText('/testyes - ���� ����� � ������ �������������')
        imgui.CenterText('/testno - ���� ����� � ������ �������������')
        imgui.CenterText('/testlabyes - ���� ����� � ����������� �������������')
        imgui.CenterText('/testlabno - ���� ����� � ������������ �������������')
        imgui.CenterText('/testweap - ������ ���������� ������� � ������')
        imgui.CenterText('/doproson - ��������� ������������ � ���������')
        imgui.CenterText('/doprosof - ���������� ������������ � ���������')
        imgui.CenterText('/unbomb - �������������� �����')
        imgui.CenterText('/pas - �������������� ��� �������')
        imgui.CenterText('/pasf - �������������� ��� ���')
        imgui.CenterText('/arm - ����� � ����������')
        imgui.CenterText('/drug - ������������� ����� ��� ���������� �������')
        imgui.CenterText('/miranda - �������')
        imgui.CenterText('/probiv - ������ �������� ����������')
        imgui.CenterText('/secretfbi - �������� � �������������')
        imgui.CenterText('/fakepas - ���� ��������')
        imgui.CenterText('/delo - ��������� ���� �� ��')
        elseif tab == 5 then
            if imgui.CollapsingHeader(u8"���������") then
    imgui.InputText(u8"��� ���", mytag, 255)
    ini.cfg.mytag = u8:decode(str(mytag))
    cfg_save()
    
    imgui.InputText(u8"��� ���������", totag, 255)
    ini.cfg.totag = u8:decode(str(totag))
    cfg_save()
    
    if imgui.Button(u8"�������� �����") then
    zk = "�.�."
    ini.cfg.zk = u8:decode(str(zk))
    end
    
    if imgui.Button(u8"�������� �����") then
    zk = "-"
    ini.cfg.zk = u8:decode(str(zk))
    end
    
    if zk == "-" then
    imgui.Text(u8"������ �������� �����")
    end
    
    if zk == "�.�." then
    imgui.Text(u8"������ �������� �����")
    end
    end
    
    if imgui.CollapsingHeader(u8"�� �����") then
    if imgui.Button(u8"������� �� �����") then
    sampSendChat("/d ["..ini.cfg.mytag.."] "..zk.." ["..ini.cfg.totag.."]: �� �����!")
    end
    if imgui.Button(u8"������� �� ����� [ ������ ]") then
    sampSendChat("/d ["..ini.cfg.mytag.."] "..zk.." ["..ini.cfg.totag.."]: �� �����! *��������*")
    end
    end
    
    if imgui.CollapsingHeader(u8"�����") then
    if imgui.Button(u8"�������� ���������") then
    sampSendChat("/d ["..ini.cfg.mytag.."] - [ALL]: ���.���������!")
    end
    end
    
    if imgui.CollapsingHeader(u8"����� �����") then
    if imgui.Button(u8"����� �����") then
    sampSendChat("/d ["..ini.cfg.mytag.."] "..zk.." ["..ini.cfg.totag.."]: ����� �����")
    end
    
    if imgui.Button(u8"������ �� �������") then
    sampSendChat("/d ["..ini.cfg.mytag.."] "..zk.." ["..ini.cfg.totag.."]: ������ �� �������, ����� �����")
    end
    end
	     
        elseif tab == 3 then

		if imgui.CollapsingHeader(faicons('keyboard') .. u8' ������ ��.������') then 
		
		local _, changed = imgui.InputInt(u8'������� ID ������', aidi)
            if changed then
                    aidi = imgui.new.int(aidi[0])
                end
                
                                          if imgui.Button(faicons('USER_CHECK') .. u8' �����', imgui.ImVec2(-1, 25)) then 
                                lua_thread.create(function()
                             sampSendChat('/me ������ ������ � ������� ������� ������ ����� �������� � ������� �� �� ����')
            wait(1500)
            sampSendChat('/do �������� ������.')
            wait(1500)
            sampSendChat('/me �������� ������ �� ������� ����� ����')
            wait(1500)
            sampSendChat('/me ��������� �������, �������� ������ �� �����')
            wait(1500)
            sampSendChat('/frisk '..aidi[0])
        end)
    end
    imgui.Separator()
if imgui.Button(faicons('USER_CHECK') .. u8' ������� �� ����� ', imgui.ImVec2(-1, 25)) then 
lua_thread.create(function()
            sampSendChat('/me ������� ������ ���� ����������')
            wait(1500)
            sampSendChat('/me ����� ���������� �� �����')
            wait(1500)
            sampSendChat('/gotome '..aidi[0])  
       end)	 
    end
  imgui.Separator()  
if imgui.Button(faicons('USER_CHECK') .. u8' �� ����� �� ����� ', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat('/me �������� ������ ���� �����������')
            wait(1500)
            sampSendChat('/do ���������� ��������.')
            wait(1500)
            sampSendChat('/ungotome '..aidi[0])
        end)
    end
   imgui.Separator() 
if imgui.Button(faicons('USER_CHECK') .. u8' ������ ���������', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
                            sampSendChat('/me ����� ����� ��������������, ������ ������� �� �������� ��������� ...')
                            wait(1500)
                            sampSendChat('/me ... �, �������� ���� �������������� ������� �� �� ����.')
                            wait(1500)
                            sampSendChat('/cuff '..aidi[0])
        end)
        end 
   imgui.Separator()     
if imgui.Button(faicons('USER_CHECK') .. u8' ����� ���������', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat('/do ���� �� ���������� � �������.')
            wait(1500)
             sampSendChat('/me ��������� ������ ���� ������ �� ������� ���� � ������ ���������')
            wait(1500)
            sampSendChat('/do ���������� ��������.')
            wait(1500)
            sampSendChat('/uncuff '..aidi[0])
        end)
    end
imgui.Separator()
if imgui.Button(faicons('USER_CHECK') .. u8' �������', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
                            sampSendChat('/me ������� ���� �� ���������� ��������� ����������, ����� ����� �� ���� ������ �� �����')
                            wait(1000)
                            sampSendChat('/pursuit '..aidi[0])
                            wait(1000)
                            sampSendChat('/me ����� ���, �������� ����� �������� � ������� ������������ �� GPS')
        end)
    end
  imgui.Separator()  
     if imgui.Button(faicons('USER_CHECK') .. u8' ������', imgui.ImVec2(-1, 25)) then 
   lua_thread.create(function()
            sampSendChat('/do ����� ����� � ������� �����.')
            wait(1500)
            sampSendChat('/me ����� ������ �� ����� � ������� � �������� �����������')
            wait(1500)
            sampSendChat('/do �����������: �������, �������� ���� ��������.')
            wait(1500)
            sampSendChat('/do �� ������� ������� 2 �������, ����� �������� �����������.')
            sampSendChat('/arrest '..aidi[0])
        end)
    end
 imgui.Separator()   
if imgui.Button(faicons('USER_CHECK') .. u8' ���������', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat('/do ������� ��������� � ��������.')
            wait(1500)
            sampSendChat('/me ������ ������� �� ��������, ������ ��� � ��� � ����� ��������')
            wait(1500)
            sampSendChat('/m �������� ������������� ��������, ���������� � ������� � ��������� ���������...')
            wait(1500)
            sampSendChat('/m ...���� ������� �� ����. � ������ ������������, �� ��� ����� ������ �����')
            wait(1500)
            sampSendChat('/me �������� �������� � ����� ������� � ��������')
        end)
    end
imgui.Separator()
if imgui.Button(faicons('USER_CHECK') .. u8' �������', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat('�� ������ ����� ������� ��������.')
            wait(2000)
            sampSendChat('��, ��� �� �������, �� ����� � ����� ������������ ������ ��� � ����.')
            wait(2000)
            sampSendChat('�� ������ ����� �� �������� � �� ���� ���������� ������.')
            wait(2000)
            sampSendChat('���� � ��� ��� ��������, ����������� ����������� ��� ��������, ������� �������� �� ������� � ���� ����.')
        end)
    end
  imgui.Separator()  
if imgui.Button(faicons('USER_CHECK') .. u8' ����� ����� �����������', imgui.ImVec2(-1, 25)) then 
            lua_thread.create(function()
            sampSendChat('/do �� ������ ����������� ����� ���������')
            wait(1500)
            sampSendChat('/me ������ ����� � ����������� � ����� �� �� ���')
            sampSendChat('/unmask '..aidi[0])
        end)
    end
  imgui.Separator()  
if imgui.Button(faicons('USER_CHECK') .. u8' ������������� �� ����������', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat('������������, ��������� ������������ ������� �����, ��� - '..sampGetPlayerNickname(myID))
            wait(1000)
            sampSendChat('/do ����� �� ����� ����� ������������, ������ - ������� ������� � ��������.')
            wait(1000)
            sampSendChat('/showbadge '..aidi[0])
            wait(1000)
            sampSendChat('����� ���������� �������� �������������� ���� ��������.')
        end)
     end
  imgui.Separator()
  if imgui.Button(faicons('USER_CHECK') .. u8' ������������� �� ��������', imgui.ImVec2(-1, 25)) then 
    lua_thread.create(function()
        sampSendChat('������� ������� �����, ��� ��������� ��������� FBI.')
        wait(1000)
        sampSendChat('/do �� ����� ����� FBI.')
        wait(1000)
        sampSendChat('������ ����� ������������ ���� ����������� ����������, �������')
        end)
    end
end
        if imgui.CollapsingHeader(faicons('keyboard') .. u8' ������ �����������') then

    local _, changed = imgui.InputInt(u8'������� ID ������', aidi)
        if changed then
                aidi = imgui.new.int(aidi[0])
        end

      if imgui.Button(faicons('USER_CHECK') .. u8' ������ �������(�.�)', imgui.ImVec2(-1, 25)) then
                    lua_thread.create(function()
                        sampSendChat('/do �� ����� ��������� ���.')
                        wait(1000)
                        sampSendChat('/me ������� ��� � ����� � �������� ������ �������� ���.')
                        wait(1500)
                        sampSendChat('/me ������� � ���� ����������� � �������� �������,����� ���� �������� �� ������ ������ ��������.')
                        wait(1500)
                        sampSendChat('/me ��������� ��� � ������ ������� �� ����.')
                        sampSendChat('/fwarn '..aidi[0])
                    end)
                end
if imgui.Button(faicons('USER_CHECK') .. u8' ����� �������', imgui.ImVec2(-1, 25)) then
                    lua_thread.create(function()
                        sampSendChat('/do �� ����� ��������� ���.')
                        wait(1000)
                        sampSendChat('/me ������� ��� � ����� � �������� ������ �������� ���.')
                        wait(1500)
                        sampSendChat('/me ������� � ���� ����������� � �������� �������,����� ���� �������� �� ������ ������ ��������.')
                        wait(1500)
                        sampSendChat('/me ��������� ��� � ������ ������� �� ����.') 
                        sampSendChat('/unfwarn '..aidi[0])
    end)
end 
if imgui.Button(faicons('USER_CHECK') .. u8' ��������(��������� ��� ������ �����)', imgui.ImVec2(-1, 25)) then
                    lua_thread.create(function()
                     sampSendChat('/do �� ����� ��������� ���.')
                     wait(1500)
                     sampSendChat('/me ������� ��� � ����� � �������� ������ �������� ���.')
                     wait(1500)
                     sampSendChat('/me ������� � ���� ����������� � ������ ���������, ����� ���� ������ ��� ������� �� ����.')
                     wait(1500)
                     sampSendChat('/todo ����� ����� � ��������*�������� �������� � ������� �����')
        end)
    end
end

		if imgui.CollapsingHeader(faicons('keyboard') .. u8' �������������') then

            local _, changed = imgui.InputInt(u8'������� ID ������', aidi)
            if changed then
                    aidi = imgui.new.int(aidi[0])
            end

		if imgui.Button(faicons('USER_CHECK') .. u8' ��������� ���������', imgui.ImVec2(-1, 25)) then
		lua_thread.create(function()
		sampSendChat('������������, ���� �� �� �������������.')
		wait(1500)
        sampSendChat('���������� ����������� ����� ���������:')
        wait(1500)
        sampSendChat('�������, ���.�����, ��������.')
        wait(1500)
        sampSendChat('/b /showpass ' ..myID.. '  /showmc ' ..myID.. ' /showlic ' ..myID)
		end)
		end
		if imgui.Button(faicons('USER_CHECK') .. u8' ����� �������� �������', imgui.ImVec2(-1, 25)) then
		lua_thread.create(function()
		sampSendChat('/me ����� ��������� ���� ���� ������� �� ��� ��������')
		wait(1500)
        sampSendChat('/me ������ �������, ����� ������ ������� ���������')
        sampSendChat('/offer')
		end)
		end
		if imgui.Button(faicons('USER_CHECK') .. u8' ����� �������� ���-�����', imgui.ImVec2(-1, 25)) then
         lua_thread.create(function()
         sampSendChat('/me ����� ��������� ���� ���� ���.����� �� ��� ��������')
         wait(1500)
         sampSendChat('/me ����� ������� ���.�����')
         wait(1500)
         sampSendChat('/me ������ ���.�����, ����� � ���������')
         sampSendChat('/offer')
		end)
		end
		if imgui.Button(faicons('USER_CHECK') .. u8' ����� �������� ��������', imgui.ImVec2(-1, 25)) then
		lua_thread.create(function()
		sampSendChat('/me ����� ��������� ���� ���� ���.����� �� ��� ��������')
		wait(1500)
        sampSendChat('/me ����� ������� ���.�����')
        wait(1500)
        sampSendChat('/me ������ ���.�����, ����� � ���������')
        sampSendChat('/offer')
        end)
        end
		if imgui.Button(faicons('USER_CHECK') .. u8' ������� ������ �������������(������)', imgui.ImVec2(-1, 25)) then 
		lua_thread.create(function()
            sampSendChat('�������! �� � ��� ���������, ������ �� ��� ���������!')
            wait(1500)
		    sampSendChat('/do ��� ������� ��������� ������')
            wait(1500)
            sampSendChat('/do ����� � �������...')
            wait(1500)
            sampSendChat('/me ����� ���� � ������, ����� ���� ���� ����� � ������� � ����')
            wait(1500)
            sampSendChat('/me ������� ����� � �������')
            wait(1500)
            sampSendChat('/todo ����� �������������*�������� ������� �� ����� ����������')
            wait(1500)
            sampSendChat('/invite '..aidi[0])
        end)
    end
end

    if imgui.CollapsingHeader(faicons('user_police') .. u8' ������ ����������� FBI') then
    if imgui.Button(faicons('USER_CHECK') .. u8' ���������� ���������� � ������ �������������', imgui.ImVec2(-1, 25)) then 
        lua_thread.create(function()
            sampSendChat("/me ������ �������� ���������� ������ ����� � ���������� ������������")
            wait(1500)
            sampSendChat("/me ������ ���, ���� �� ������ �������� � �������� �������")
            wait(1500)
            sampSendChat("/me ������� � �������� �������� ��������")
            wait(1500)
            sampSendChat ("/me ������� � �������� ���� �����-����-10")
            wait(1700)
            sampSendChat("/me ������� ���������� ����������� ��������")
            wait(1700)
            sampSendChat("/do ���� ��� ������������� ���������, �������� �������� ����������.")
               end)
            end
            if imgui.Button(faicons('USER_CHECK') .. u8' ���������� ���������� � ������ �������������', imgui.ImVec2(-1, 25)) then 
                lua_thread.create(function()
                    sampSendChat("/me ������ �������� ����������, ������ ����� ���������� �����������.")
                    wait(1500)
                    sampSendChat("/me ������ ���, ���� �� ������ �������� � �������� �������")
                    wait(1500)
                    sampSendChat("/me ������� � �������� �������� ��������")
                    wait(1500)
                    sampSendChat ("/me ������� � �������� ���� �����-����-10")
                    wait(1700)
                    sampSendChat("/me ������� ���������� ����������� ��������")
                    wait(1500)
                    sampSendChat("/do ���� ��� ������������� ���������, �������� �� �������� ����������. ")
                       end)
                    end
                    if imgui.Button(faicons('USER_CHECK') .. u8' ���������� ���������� � ����������� �������������', imgui.ImVec2(-1, 25)) then 
                        lua_thread.create(function()
                            sampSendChat("/do �� ����� ����� ���������, ����� � ��� ����� ��������� �������� � ����� ����.")
                                wait(1500)
                                sampSendChat("/do �� ���������� ������� ����� ������� ����������� ��������.")
                                wait(1500)
                                sampSendChat("/do ����� �� ����� ����� ��������� ����� � �����, � ������ �� ����� �������.")
                                wait(1500)
                                sampSendChat("/do ����� �� ����� ����� ��������� ����� � �����, � ������ �� ����� �������.")
                                wait(1500)
                                sampSendChat("/me ..������� ��� ���������� �� ����, ������� �� ����� ����� �����")
                                wait(1500)
                                sampSendChat("/do ���� ���������� ��� ���������� ������� ����������.")
                                wait(1500)
                                sampSendChat("/me �������� ���������� ��� ���� ���������� ������ ��-��� ���������� � ������� �� ���� ���� ����������..")
                                wait(1500)
                                sampSendChat("/me ..�������� � �����, ����� ���� ���� �������, �������� � ����� � ������ ������ ��������")
                                wait(1500)
                                sampSendChat("/me ������ ������� ������� ������� � ��������, ������� ���������� ������ ��� ��������� � ����� �������� �������..")
                                wait(1500)
                                sampSendChat("/me ..����������, ������ � ����� ����������")
                                wait(1500)
                                sampSendChat("/me �� ������� ������� �� ������ ����������, ���� �� ����� ����� � ����������� ����� ������� � ��������, ...")
                                wait(1500)
                                sampSendChat("/me ..��������� �������� � ����� � ������������ �� ������ ����������")
                                wait(1500)
                                sampSendChat("/do ����� ����������� ������ ��� ����� � ����� �������� ����������, ��� �������� ���� ����������.")
                                wait(1500)
                                sampSendChat("/me ������������� �� ����������, ������� ����� �� ����, ����� ���� ������� ���������� ��� ������..")
                                wait(1500)
                                sampSendChat("/me ..�� ���������� ������� ��� � ������������� ���, ����� � ���� ������������ ������� ���, ��� �������� - ��������.")
                               end)
                            end
                            if imgui.Button(faicons('USER_CHECK') .. u8' ���������� ���������� � ����������� �������������', imgui.ImVec2(-1, 25)) then 
                                lua_thread.create(function()
                                    sampSendChat("/do �� ����� ����� ���������, ����� � ��� ����� ��������� �������� � ����� ����.")
                                        wait(1500)
                                        sampSendChat("/do �� ���������� ������� ����� ������� ����������� ��������.")
                                        wait(1500)
                                        sampSendChat("/do ����� �� ����� ����� ��������� ����� � �����, � ������ �� ����� �������.")
                                        wait(1500)
                                        sampSendChat("/do ����� �� ����� ����� ��������� ����� � �����, � ������ �� ����� �������.")
                                        wait(1500)
                                        sampSendChat("/me ..������� ��� ���������� �� ����, ������� �� ����� ����� �����")
                                        wait(1500)
                                        sampSendChat("/do ���� ���������� ��� ���������� ������� ����������.")
                                        wait(1500)
                                        sampSendChat("/me �������� ���������� ��� ���� ���������� ������ ��-��� ���������� � ������� �� ���� ���� ����������..")
                                        wait(1500)
                                        sampSendChat("/me ..�������� � �����, ����� ���� ���� �������, �������� � ����� � ������ ������ ��������")
                                        wait(1500)
                                        sampSendChat("/me ������ ������� ������� ������� � ��������, ������� ���������� ������ ��� ��������� � ����� �������� �������..")
                                        wait(1500)
                                        sampSendChat("/me ..����������, ������ � ����� ����������")
                                        wait(1500)
                                        sampSendChat("/me �� ������� ������� �� ������ ����������, ���� �� ����� ����� � ����������� ����� ������� � ��������, ...")
                                        wait(1500)
                                        sampSendChat("/me ..��������� �������� � ����� � ������������ �� ������ ����������")
                                        wait(1500)
                                        sampSendChat("/do ����� ����������� ������ ��� ����� � ����� �������� ����������, ��� �������� �� ���� ����������.")
                                        wait(1500)
                                        sampSendChat("/me ������������� �� ����������, ������� ����� �� ����, ����� ���� ������� ���������� ��� ������..")
                                        wait(1500)
                                        sampSendChat("/me ..�� ���������� ������� ��� � ������������� ���, ����� � ���� ������������ ������� ���, ��� �������� - �� ��������.")
                                       end)
                                    end
                                    if imgui.Button(faicons('USER_CHECK') .. u8' ������ ���� ��������', imgui.ImVec2(-1, 25)) then 
                                        lua_thread.create(function()
                                            sampSendChat("/do �� ����� ����� ������ ��� ����������.")
                                                wait(1500)
                                                sampSendChat("/me ���� � ����� ��� , ����� ��������� ��������...")
                                                wait(1500)
                                                sampSendChat("/me ... �� ��� ����, ID-����� , �������� � ������")
                                                wait(1500)
                                                sampSendChat("/do �� ������ ��� ����������� ��� ���������� � ��������.")
                                        end)
                                    end
                                    if imgui.Button(faicons('USER_CHECK') .. u8' �������� � �������������', imgui.ImVec2(-1, 25)) then 
                                        lua_thread.create(function()
                                            sampSendChat("/do �� ����� ����� ��������: �������� � ������������� ������������ ���.")
                                                wait(1500)
                                                sampSendChat("/do ����� � ���������� ��������� ����������� ����� � ������� ����������� ���.")
                                                wait(1500)
                                                sampSendChat("/do � ��������� ��������: �, (��� / �������), ������� ������� ������ ��, ��� �����, ����, � ���� ������.")
                                                wait(1500)
                                                sampSendChat("/do ���� ��������: ����� ����� ������ ���������������, � � ������ ������ �������������, ...")
                                                wait(1500)
                                                sampSendChat("/do ... ����� ���� ������������ � ������������ �� ���������, ��� ������� �������.")
                                                wait(1500)
                                                sampSendChat("/do ��� ���� ��������: ����: ; �������: .")
                                                wait(1500)
                                                sampSendChat("/me ������� �������� � ������ ��������")
                                                wait(1500)
                                                sampSendChat("��������� ���������� �������� � ������� ��� ���, � ������ ������!")
                                        end)
                                    end
                                    if imgui.Button(faicons('USER_CHECK') .. u8' �������������� �����', imgui.ImVec2(-1, 25)) then 
                                        lua_thread.create(function()
                                            sampSendChat("/do � ����� ��� ���� �����, ��� �������������� �����.")
                                                wait(2500)
                                                sampSendChat("/me ������� ���� �� ���, �������� ���������� ��� ������ ��� � ���� � ������ ���� �������")
                                                wait(2500)
                                                sampSendChat("/do � ����� ���� ���� ��������: �����, �����, �������, ������ � �������.")
                                                wait(2500)
                                                sampSendChat("/me ����������� ������ �������� ����������, ����� ��������� ������ �������, ������� ����� �..")
                                                wait(2500)
                                                sampSendChat("/me .. ������ ��������� �����, ����������� ����� ����� ������� ��")
                                                wait(2500)
                                                sampSendChat("/todo ���� ������.*��������� ��������� ������ ������ �����")
                                                wait(2500)
                                                sampSendChat("/removebomb")
                                                wait(100)
                                                sampSendChat("/do ����� �����������, ������ �� ��� �����������, � ����� ������� ������������.")
                                                wait(2500)
                                                sampSendChat("/me �������� ���������� ��� ������� ������� � ����, ����� ���� ���� ����� � ��� ����...")
                                                wait(2500)
                                                sampSendChat("/me ...� ������� � � ����������� ����� � ����� �����, ������ �������� ��� � ���� � ����� ����")
                                        end)
                                    end

                                    local _, changed = imgui.InputInt(u8'������� ID ������', aidi)
                                    if changed then
                                    aidi = imgui.new.int(aidi[0])
                                    end

                                    if imgui.Button(faicons('USER_CHECK') .. u8' ������(�.�.�)', imgui.ImVec2(-1, 25)) then 
                                        lua_thread.create(function()
                                            sampSendChat("/do � ������ ������� ���� ��������� ���.")
                                                wait(1500)
                                                sampSendChat("/me ������ ��� �� ������� �������, ����� ����� ��������� �� ���� ������ ���������� ����� ����, ID ����� � �����")
                                                wait(1500)
                                                sampSendChat("/do �� ������ ��� ��������� ������ ���������� � ����������.")
                                                wait(1500)
                                                sampSendChat("/me ����� �� ������ ������� �� ���. �����������")
                                                wait(1500)
                                                sampSendChat("/demoute "..aidi[0].." �.�.�")
                                                wait(1500)
                                                sampSendChat("/do "..sampGetPlayerNickname(aidi[0]).." ��� ������ �� ������ ���. �����������.")
                                        end)
                                    end
                                end

 		if imgui.CollapsingHeader(faicons('keyboard') .. u8' �� ��������� ������� � ��') then 
 
            local _, changed = imgui.InputInt(u8'������� ID ������', aidi)
            if changed then
                    aidi = imgui.new.int(aidi[0])
            end

            if imgui.Button(faicons('USER_CHECK') .. u8' �������� �������', imgui.ImVec2(-1, 25)) then 
                lua_thread.create(function()
                    sampSendChat("/do ����� ����� �� �����.")
                    wait(1500)
                    sampSendChat("/me ������ ��������� ���� ������ ����� � ����� �������")
                    wait(1500)
                    sampSendChat("/me ������ ���� �� ����� ����� �������� � ������ ����")
                    wait(1500)
                    sampSendChat("/do ������� � ������ ����.")
                    wait(1500)
                    sampSendChat("/todo �������*��������� �������� ��������")
                    sampSendChat('/showpass '..aidi[0])
                    end)
                    end
                             if imgui.Button(faicons('USER_CHECK') .. u8' �������� ��������', imgui.ImVec2(-1, 25)) then 
                lua_thread.create(function()
                sampSendChat("/do ����� ����� �� �����.")
                wait(1500)
                sampSendChat("/do ����� � ���������� ��������� � �����.")
                    wait(1500)
                    sampSendChat("/me ������� ��������� ������ ���� ������� �����")
                    wait(1500)
                    sampSendChat("/me ������� �����, ���� ������ ��������")
                    wait(1500)
                    sampSendChat("/do �������� � ������ ����.")
                    wait(1500)
                    sampSendChat("/me ������� ���������")
                    sampSendChat('/showlic '..aidi[0])
                    end)
                    end
                             if imgui.Button(faicons('USER_CHECK') .. u8' �������� ������', imgui.ImVec2(-1, 25)) then 
                lua_thread.create(function()
                sampSendChat("/do ����� ����� �� �����.")
                wait(1500)
                sampSendChat("/do ������ ��������� � �������� � ��������� � ������ �������� �����.")
                    wait(1500)
                    sampSendChat("/me ������ ������ ����� �����, ������� ������ �������")
                    wait(1500)
                    sampSendChat("/do �������� � ����.")
                    wait(1500)
                    sampSendChat("/do �� ������ �������� '��� ������'.")
                    wait(1500)
                    sampSendChat("/me ������� �������� � �������� ��������")
                    sampSendChat('/showskills '..aidi[0])
                    end)
                    end
                             if imgui.Button(faicons('USER_CHECK') .. u8' �������� ���. �����', imgui.ImVec2(-1, 25)) then 
                lua_thread.create(function()	
                sampSendChat("/do ����� ����� �� �����.")
                wait(1500)
                sampSendChat("/do � ����� ���. �����.")
                    wait(1500)
                    sampSendChat("/me ������ �����, ������ � ��� ������ �����")
                    wait(1500)
                    sampSendChat("/me ������ ��������� ����� ������� ��������, ������ ���")
                    wait(1500)
                    sampSendChat("/do ���. ����� � ������ ����.")
                    wait(1500)
                    sampSendChat("/me ������� ���. ����� �������� ��������")
                    sampSendChat('/showmc '..aidi[0])
                    end)
                    end
                    end
                    
        elseif tab == 4 then
        
            imgui.CenterText(u8"������� ������ ������� "..bSettings.update.version)
            imgui.CenterText(u8"�����������: William_Pauza Brainburg(05)")
            if imgui.BeginTabItem(faicons('handshake_angle')..u8' ���������� � ����������') then
                imgui.CenterText(u8"������� ������ ������� "..bSettings.update.version)
                imgui.CenterTextOptional("����������� William_Pauza 05 Brainburg)", true)
                if bSettings.update.needupdate then
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"����������").x) / 2)
                    if imgui.Button(u8"����������") then
                        local response = requests.get("https://raw.githubusercontent.com/makson4ck/MVD Helper/main/MVD_Helper_Mobile.lua")
                        if response.status_code == 200 then
                            local filepath = script.this.path
                            os.remove(filepath)
                            local f = assert(io.open('MVD Helper.lua', 'wb'))
                            f:write(response.text)
                            f:close()
                            script.this:reload()
                        end
                    end
                else
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8"��������� ����������").x) / 2)
                    if imgui.Button(u8"��������� ����������") then
                        local response = requests.get("https://raw.githubusercontent.com/makson4ck/MVD-Helper/main/update.ini")
                        if response.status_code == 200 then
                            local versionInfo = ini.decode(response.text)
                            if versionInfo['version'] ~= bSettings.update.version then
                                bSettings.update.needupdate = true
                                bSettings.update.updateText = "������� ���������� �� ������ "..u8(versionInfo['version']).."\n"..u8:decode(versionInfo['description'])
                            else
                                bSettings.update.updateText = "���������� �� �������"
                            end
                        else
                            sampAddChatMessage("������ "..response.status_code,-1)
                        end
                    end
                end
                if bSettings.update.needupdate then
                    imgui.Separator()
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8(bSettings.update.updateText)).x) / 2)
                    imgui.Text(u8(bSettings.update.updateText))
                    imgui.Separator()
                else
                    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8(bSettings.update.updateText)).x) / 2)
                end
                imgui.EndTabItem()
            end

        if imgui.Button(u8'������������� ������') then
				lua_thread.create(function() wait(5) thisScript():reload() end)
				imgui.ShowCursor = false
			end
				if imgui.IsItemHovered() then imgui.SetTooltip(u8'�������� ���, ����� ������������� ������')  end -- ��� ������������
			imgui.SameLine()
			if imgui.Button(u8'��������� ������') then
				lua_thread.create(function() wait(1) thisScript():unload() end)
				imgui.ShowCursor = false
			end
     end
        imgui.EndChild() -- ����������� ������� �� ���, ����� ������ ����� ��� ������
        end
    imgui.End()
end)

function iniSave()
	ini.cfg.theme = theme[0]
	ini.cfg.style = style[0]
	inicfg.save(ini, iniFile)
end

styles = {
	{
		name = u8'�������',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			style.WindowRounding = 0
			style.ChildRounding = 0
			style.FrameRounding = 0
			style.ItemSpacing = imgui.ImVec2(3.0, 3.0)
			style.ItemInnerSpacing = imgui.ImVec2(3.0, 3.0)
			style.FramePadding = imgui.ImVec2(4.0, 3.0)
			style.IndentSpacing = 21
			style.ScrollbarSize = 10.0
			style.ScrollbarRounding = 0
			style.GrabMinSize = 17.0
			style.GrabRounding = 0
			style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
			style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
		end
	},
	{
		name = u8'������',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			style.WindowRounding = 10
			style.ChildRounding = 10
			style.FrameRounding = 6.0
			style.ItemSpacing = imgui.ImVec2(3.0, 3.0)
			style.ItemInnerSpacing = imgui.ImVec2(3.0, 3.0)
			style.FramePadding = imgui.ImVec2(4.0, 3.0)
			style.IndentSpacing = 21
			style.ScrollbarSize = 10.0
			style.ScrollbarRounding = 13
			style.GrabMinSize = 17.0
			style.GrabRounding = 16.0
			style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
			style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
		end
	}
}

themes = {
	{
		name = u8'������',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.Text]				   = ImVec4(0.90, 0.90, 0.90, 1.00)
			colors[clr.TextDisabled]		   = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.WindowBg]			   = ImVec4(0.08, 0.08, 0.08, 1.00)
			colors[clr.ChildBg]		  = ImVec4(0.10, 0.10, 0.10, 0.40)
			colors[clr.PopupBg]				= ImVec4(0.08, 0.08, 0.08, 1.00)
			colors[clr.Border]				 = ImVec4(0.70, 0.70, 0.70, 0.40)
			colors[clr.BorderShadow]		   = ImVec4(0.00, 0.00, 0.00, 0.00)
			colors[clr.FrameBg]				= ImVec4(0.15, 0.15, 0.15, 1.00)
			colors[clr.FrameBgHovered]		 = ImVec4(0.19, 0.19, 0.19, 0.71)
			colors[clr.FrameBgActive]		  = ImVec4(0.34, 0.34, 0.34, 0.79)
			colors[clr.TitleBg]				= ImVec4(0.00, 0.69, 0.33, 0.80)
			colors[clr.TitleBgActive]		  = ImVec4(0.00, 0.74, 0.36, 1.00)
			colors[clr.TitleBgCollapsed]	   = ImVec4(0.00, 0.69, 0.33, 0.50)
			colors[clr.MenuBarBg]			  = ImVec4(0.00, 0.80, 0.38, 1.00)
			colors[clr.ScrollbarBg]			= ImVec4(0.16, 0.16, 0.16, 1.00)
			colors[clr.ScrollbarGrab]		  = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.ScrollbarGrabHovered]   = ImVec4(0.00, 0.82, 0.39, 1.00)
			colors[clr.ScrollbarGrabActive]	= ImVec4(0.00, 1.00, 0.48, 1.00)
			colors[clr.CheckMark]			  = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.SliderGrab]			 = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.SliderGrabActive]	   = ImVec4(0.00, 0.77, 0.37, 1.00)
			colors[clr.Button]				 = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.ButtonHovered]		  = ImVec4(0.00, 0.82, 0.39, 1.00)
			colors[clr.ButtonActive]		   = ImVec4(0.00, 0.87, 0.42, 1.00)
			colors[clr.Header]				 = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.HeaderHovered]		  = ImVec4(0.00, 0.76, 0.37, 0.57)
			colors[clr.HeaderActive]		   = ImVec4(0.00, 0.88, 0.42, 0.89)
			colors[clr.Separator]			  = ImVec4(1.00, 1.00, 1.00, 0.40)
			colors[clr.SeparatorHovered]	   = ImVec4(1.00, 1.00, 1.00, 0.60)
			colors[clr.SeparatorActive]		= ImVec4(1.00, 1.00, 1.00, 0.80)
			colors[clr.ResizeGrip]			 = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.ResizeGripHovered]	  = ImVec4(0.00, 0.76, 0.37, 1.00)
			colors[clr.ResizeGripActive]	   = ImVec4(0.00, 0.86, 0.41, 1.00)
			colors[clr.PlotLines]			  = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.PlotLinesHovered]	   = ImVec4(0.00, 0.74, 0.36, 1.00)
			colors[clr.PlotHistogram]		  = ImVec4(0.00, 0.69, 0.33, 1.00)
			colors[clr.PlotHistogramHovered]   = ImVec4(0.00, 0.80, 0.38, 1.00)
			colors[clr.TextSelectedBg]		 = ImVec4(0.00, 0.69, 0.33, 0.72)
			colors[clr.ModalWindowDimBg]   = ImVec4(0.17, 0.17, 0.17, 0.48)
		end
	},
	{
		name = u8'�������',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.Text]				   = ImVec4(0.95, 0.96, 0.98, 1.00)
			colors[clr.TextDisabled]		   = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.WindowBg]			   = ImVec4(0.14, 0.14, 0.14, 1.00)
			colors[clr.ChildBg]		  = ImVec4(0.12, 0.12, 0.12, 0.40)
			colors[clr.PopupBg]				= ImVec4(0.08, 0.08, 0.08, 0.94)
			colors[clr.Border]				 = ImVec4(0.14, 0.14, 0.14, 1.00)
			colors[clr.BorderShadow]		   = ImVec4(1.00, 1.00, 1.00, 0.00)
			colors[clr.FrameBg]				= ImVec4(0.22, 0.22, 0.22, 1.00)
			colors[clr.FrameBgHovered]		 = ImVec4(0.18, 0.18, 0.18, 1.00)
			colors[clr.FrameBgActive]		  = ImVec4(0.09, 0.12, 0.14, 1.00)
			colors[clr.TitleBg]				= ImVec4(0.14, 0.14, 0.14, 0.81)
			colors[clr.TitleBgActive]		  = ImVec4(0.14, 0.14, 0.14, 1.00)
			colors[clr.TitleBgCollapsed]	   = ImVec4(0.00, 0.00, 0.00, 0.51)
			colors[clr.MenuBarBg]			  = ImVec4(0.20, 0.20, 0.20, 1.00)
			colors[clr.ScrollbarBg]			= ImVec4(0.02, 0.02, 0.02, 0.39)
			colors[clr.ScrollbarGrab]		  = ImVec4(0.36, 0.36, 0.36, 1.00)
			colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00)
			colors[clr.ScrollbarGrabActive]	= ImVec4(0.24, 0.24, 0.24, 1.00)
			colors[clr.CheckMark]			  = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.SliderGrab]			 = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.SliderGrabActive]	   = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.Button]				 = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.ButtonHovered]		  = ImVec4(1.00, 0.39, 0.39, 1.00)
			colors[clr.ButtonActive]		   = ImVec4(1.00, 0.21, 0.21, 1.00)
			colors[clr.Header]				 = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.HeaderHovered]		  = ImVec4(1.00, 0.39, 0.39, 1.00)
			colors[clr.HeaderActive]		   = ImVec4(1.00, 0.21, 0.21, 1.00)
			colors[clr.ResizeGrip]			 = ImVec4(1.00, 0.28, 0.28, 1.00)
			colors[clr.ResizeGripHovered]	  = ImVec4(1.00, 0.39, 0.39, 1.00)
			colors[clr.PlotLines]			  = ImVec4(0.61, 0.61, 0.61, 1.00)
			colors[clr.PlotLinesHovered]	   = ImVec4(1.00, 0.43, 0.35, 1.00)
			colors[clr.PlotHistogram]		  = ImVec4(1.00, 0.21, 0.21, 1.00)
			colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00)
			colors[clr.TextSelectedBg]		 = ImVec4(1.00, 0.32, 0.32, 1.00)
			colors[clr.ModalWindowDimBg]   = ImVec4(0.26, 0.26, 0.26, 0.60)
		end
	},
	{
		name = u8'���������',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.FrameBg]				= ImVec4(0.46, 0.11, 0.29, 1.00)
			colors[clr.FrameBgHovered]		 = ImVec4(0.69, 0.16, 0.43, 1.00)
			colors[clr.FrameBgActive]		  = ImVec4(0.58, 0.10, 0.35, 1.00)
			colors[clr.TitleBg]				= ImVec4(0.00, 0.00, 0.00, 1.00)
			colors[clr.TitleBgActive]		  = ImVec4(0.61, 0.16, 0.39, 1.00)
			colors[clr.TitleBgCollapsed]	   = ImVec4(0.00, 0.00, 0.00, 0.51)
			colors[clr.CheckMark]			  = ImVec4(0.94, 0.30, 0.63, 1.00)
			colors[clr.SliderGrab]			 = ImVec4(0.85, 0.11, 0.49, 1.00)
			colors[clr.SliderGrabActive]	   = ImVec4(0.89, 0.24, 0.58, 1.00)
			colors[clr.Button]				 = ImVec4(0.46, 0.11, 0.29, 1.00)
			colors[clr.ButtonHovered]		  = ImVec4(0.69, 0.17, 0.43, 1.00)
			colors[clr.ButtonActive]		   = ImVec4(0.59, 0.10, 0.35, 1.00)
			colors[clr.Header]				 = ImVec4(0.46, 0.11, 0.29, 1.00)
			colors[clr.HeaderHovered]		  = ImVec4(0.69, 0.16, 0.43, 1.00)
			colors[clr.HeaderActive]		   = ImVec4(0.58, 0.10, 0.35, 1.00)
			colors[clr.Separator]			  = ImVec4(0.69, 0.16, 0.43, 1.00)
			colors[clr.SeparatorHovered]	   = ImVec4(0.58, 0.10, 0.35, 1.00)
			colors[clr.SeparatorActive]		= ImVec4(0.58, 0.10, 0.35, 1.00)
			colors[clr.ResizeGrip]			 = ImVec4(0.46, 0.11, 0.29, 0.70)
			colors[clr.ResizeGripHovered]	  = ImVec4(0.69, 0.16, 0.43, 0.67)
			colors[clr.ResizeGripActive]	   = ImVec4(0.70, 0.13, 0.42, 1.00)
			colors[clr.TextSelectedBg]		 = ImVec4(1.00, 0.78, 0.90, 0.35)
			colors[clr.Text]				   = ImVec4(1.00, 1.00, 1.00, 1.00)
			colors[clr.TextDisabled]		   = ImVec4(0.60, 0.19, 0.40, 1.00)
			colors[clr.WindowBg]			   = ImVec4(0.06, 0.06, 0.06, 0.94)
			colors[clr.ChildBg]		  = ImVec4(0.00, 0.00, 0.00, 0.40)
			colors[clr.PopupBg]				= ImVec4(0.08, 0.08, 0.08, 0.94)
			colors[clr.Border]				 = ImVec4(0.49, 0.14, 0.31, 1.00)
			colors[clr.BorderShadow]		   = ImVec4(0.49, 0.14, 0.31, 0.00)
			colors[clr.MenuBarBg]			  = ImVec4(0.15, 0.15, 0.15, 1.00)
			colors[clr.ScrollbarBg]			= ImVec4(0.02, 0.02, 0.02, 0.53)
			colors[clr.ScrollbarGrab]		  = ImVec4(0.31, 0.31, 0.31, 1.00)
			colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
			colors[clr.ScrollbarGrabActive]	= ImVec4(0.51, 0.51, 0.51, 1.00)
			colors[clr.ModalWindowDimBg]   = ImVec4(0.80, 0.80, 0.80, 0.35)
		end
	},
	{
		name = u8'����������',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.WindowBg]			  = ImVec4(0.14, 0.12, 0.16, 1.00)
			colors[clr.ChildBg]		 = ImVec4(0.30, 0.20, 0.39, 0.40)
			colors[clr.PopupBg]			   = ImVec4(0.05, 0.05, 0.10, 0.90)
			colors[clr.Border]				= ImVec4(0.89, 0.85, 0.92, 0.30)
			colors[clr.BorderShadow]		  = ImVec4(0.00, 0.00, 0.00, 0.00)
			colors[clr.FrameBg]			   = ImVec4(0.30, 0.20, 0.39, 1.00)
			colors[clr.FrameBgHovered]		= ImVec4(0.41, 0.19, 0.63, 0.68)
			colors[clr.FrameBgActive]		 = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.TitleBg]			   = ImVec4(0.41, 0.19, 0.63, 0.45)
			colors[clr.TitleBgCollapsed]	  = ImVec4(0.41, 0.19, 0.63, 0.35)
			colors[clr.TitleBgActive]		 = ImVec4(0.41, 0.19, 0.63, 0.78)
			colors[clr.MenuBarBg]			 = ImVec4(0.30, 0.20, 0.39, 0.57)
			colors[clr.ScrollbarBg]		   = ImVec4(0.30, 0.20, 0.39, 1.00)
			colors[clr.ScrollbarGrab]		 = ImVec4(0.41, 0.19, 0.63, 0.31)
			colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78)
			colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.CheckMark]			 = ImVec4(0.56, 0.61, 1.00, 1.00)
			colors[clr.SliderGrab]			= ImVec4(0.41, 0.19, 0.63, 0.24)
			colors[clr.SliderGrabActive]	  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.Button]				= ImVec4(0.41, 0.19, 0.63, 0.44)
			colors[clr.ButtonHovered]		 = ImVec4(0.41, 0.19, 0.63, 0.86)
			colors[clr.ButtonActive]		  = ImVec4(0.64, 0.33, 0.94, 1.00)
			colors[clr.Header]				= ImVec4(0.41, 0.19, 0.63, 0.76)
			colors[clr.HeaderHovered]		 = ImVec4(0.41, 0.19, 0.63, 0.86)
			colors[clr.HeaderActive]		  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.ResizeGrip]			= ImVec4(0.41, 0.19, 0.63, 0.20)
			colors[clr.ResizeGripHovered]	 = ImVec4(0.41, 0.19, 0.63, 0.78)
			colors[clr.ResizeGripActive]	  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.PlotLines]			 = ImVec4(0.89, 0.85, 0.92, 0.63)
			colors[clr.PlotLinesHovered]	  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.PlotHistogram]		 = ImVec4(0.89, 0.85, 0.92, 0.63)
			colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.TextSelectedBg]		= ImVec4(0.41, 0.19, 0.63, 0.43)
			colors[clr.TextDisabled]		  = ImVec4(0.41, 0.19, 0.63, 1.00)
			colors[clr.ModalWindowDimBg]  = ImVec4(0.20, 0.20, 0.20, 0.35)
		end
	},
	{
		name = u8'�������',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.Text]				  = ImVec4(0.86, 0.93, 0.89, 0.78)
			colors[clr.TextDisabled]		  = ImVec4(0.71, 0.22, 0.27, 1.00)
			colors[clr.WindowBg]			  = ImVec4(0.13, 0.14, 0.17, 1.00)
			colors[clr.ChildBg]		 = ImVec4(0.20, 0.22, 0.27, 0.58)
			colors[clr.PopupBg]			   = ImVec4(0.20, 0.22, 0.27, 0.90)
			colors[clr.Border]				= ImVec4(0.31, 0.31, 1.00, 0.00)
			colors[clr.BorderShadow]		  = ImVec4(0.00, 0.00, 0.00, 0.00)
			colors[clr.FrameBg]			   = ImVec4(0.20, 0.22, 0.27, 1.00)
			colors[clr.FrameBgHovered]		= ImVec4(0.46, 0.20, 0.30, 0.78)
			colors[clr.FrameBgActive]		 = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.TitleBg]			   = ImVec4(0.23, 0.20, 0.27, 1.00)
			colors[clr.TitleBgActive]		 = ImVec4(0.50, 0.08, 0.26, 1.00)
			colors[clr.TitleBgCollapsed]	  = ImVec4(0.20, 0.20, 0.27, 0.75)
			colors[clr.MenuBarBg]			 = ImVec4(0.20, 0.22, 0.27, 0.47)
			colors[clr.ScrollbarBg]		   = ImVec4(0.20, 0.22, 0.27, 1.00)
			colors[clr.ScrollbarGrab]		 = ImVec4(0.09, 0.15, 0.10, 1.00)
			colors[clr.ScrollbarGrabHovered]  = ImVec4(0.46, 0.20, 0.30, 0.78)
			colors[clr.ScrollbarGrabActive]   = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.CheckMark]			 = ImVec4(0.71, 0.22, 0.27, 1.00)
			colors[clr.SliderGrab]			= ImVec4(0.47, 0.77, 0.83, 0.14)
			colors[clr.SliderGrabActive]	  = ImVec4(0.71, 0.22, 0.27, 1.00)
			colors[clr.Button]				= ImVec4(0.47, 0.77, 0.83, 0.14)
			colors[clr.ButtonHovered]		 = ImVec4(0.46, 0.20, 0.30, 0.86)
			colors[clr.ButtonActive]		  = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.Header]				= ImVec4(0.46, 0.20, 0.30, 0.76)
			colors[clr.HeaderHovered]		 = ImVec4(0.46, 0.20, 0.30, 0.86)
			colors[clr.HeaderActive]		  = ImVec4(0.50, 0.08, 0.26, 1.00)
			colors[clr.ResizeGrip]			= ImVec4(0.47, 0.77, 0.83, 0.04)
			colors[clr.ResizeGripHovered]	 = ImVec4(0.46, 0.20, 0.30, 0.78)
			colors[clr.ResizeGripActive]	  = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.PlotLines]			 = ImVec4(0.86, 0.93, 0.89, 0.63)
			colors[clr.PlotLinesHovered]	  = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.PlotHistogram]		 = ImVec4(0.86, 0.93, 0.89, 0.63)
			colors[clr.PlotHistogramHovered]  = ImVec4(0.46, 0.20, 0.30, 1.00)
			colors[clr.TextSelectedBg]		= ImVec4(0.46, 0.20, 0.30, 0.43)
			colors[clr.ModalWindowDimBg]  = ImVec4(0.20, 0.22, 0.27, 0.73)
		end
	},
	{
		name = u8'Ƹ����',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
			colors[clr.Text]				 = ImVec4(0.92, 0.92, 0.92, 1.00)
			colors[clr.TextDisabled]		 = ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.WindowBg]			 = ImVec4(0.06, 0.06, 0.06, 1.00)
			colors[clr.ChildBg]		= ImVec4(0.00, 0.00, 0.00, 0.40)
			colors[clr.PopupBg]			  = ImVec4(0.08, 0.08, 0.08, 0.94)
			colors[clr.Border]			   = ImVec4(0.51, 0.36, 0.15, 1.00)
			colors[clr.BorderShadow]		 = ImVec4(0.00, 0.00, 0.00, 0.00)
			colors[clr.FrameBg]			  = ImVec4(0.11, 0.11, 0.11, 1.00)
			colors[clr.FrameBgHovered]	   = ImVec4(0.51, 0.36, 0.15, 1.00)
			colors[clr.FrameBgActive]		= ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.TitleBg]			  = ImVec4(0.51, 0.36, 0.15, 1.00)
			colors[clr.TitleBgActive]		= ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.TitleBgCollapsed]	 = ImVec4(0.00, 0.00, 0.00, 0.51)
			colors[clr.MenuBarBg]			= ImVec4(0.11, 0.11, 0.11, 1.00)
			colors[clr.ScrollbarBg]		  = ImVec4(0.06, 0.06, 0.06, 0.53)
			colors[clr.ScrollbarGrab]		= ImVec4(0.21, 0.21, 0.21, 1.00)
			colors[clr.ScrollbarGrabHovered] = ImVec4(0.47, 0.47, 0.47, 1.00)
			colors[clr.ScrollbarGrabActive]  = ImVec4(0.81, 0.83, 0.81, 1.00)
			colors[clr.CheckMark]			= ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.SliderGrab]		   = ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.SliderGrabActive]	 = ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.Button]			   = ImVec4(0.51, 0.36, 0.15, 1.00)
			colors[clr.ButtonHovered]		= ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.ButtonActive]		 = ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.Header]			   = ImVec4(0.51, 0.36, 0.15, 1.00)
			colors[clr.HeaderHovered]		= ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.HeaderActive]		 = ImVec4(0.93, 0.65, 0.14, 1.00)
			colors[clr.Separator]			= ImVec4(0.21, 0.21, 0.21, 1.00)
			colors[clr.SeparatorHovered]	 = ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.SeparatorActive]	  = ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.ResizeGrip]		   = ImVec4(0.21, 0.21, 0.21, 1.00)
			colors[clr.ResizeGripHovered]	= ImVec4(0.91, 0.64, 0.13, 1.00)
			colors[clr.ResizeGripActive]	 = ImVec4(0.78, 0.55, 0.21, 1.00)
			colors[clr.PlotLines]			= ImVec4(0.61, 0.61, 0.61, 1.00)
			colors[clr.PlotLinesHovered]	 = ImVec4(1.00, 0.43, 0.35, 1.00)
			colors[clr.PlotHistogram]		= ImVec4(0.90, 0.70, 0.00, 1.00)
			colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
			colors[clr.TextSelectedBg]	   = ImVec4(0.26, 0.59, 0.98, 0.35)
			colors[clr.ModalWindowDimBg] = ImVec4(0.80, 0.80, 0.80, 0.35)
		end
	},
	{
		name = u8'������',
		func = function()
			imgui.SwitchContext()
			local style = imgui.GetStyle()
			local colors = style.Colors
			local clr = imgui.Col
			local ImVec4 = imgui.ImVec4
  style.WindowPadding = imgui.ImVec2(5, 5)
  style.FramePadding = imgui.ImVec2(10, 10)
  style.ItemSpacing = imgui.ImVec2(10, 10)
  style.ItemInnerSpacing = imgui.ImVec2(5, 5)
  style.TouchExtraPadding = imgui.ImVec2(5 * MONET_DPI_SCALE, 5 * MONET_DPI_SCALE)
  style.IndentSpacing = 0
  style.ScrollbarSize = 20 * MONET_DPI_SCALE
  style.GrabMinSize = 20 * MONET_DPI_SCALE

  --==[ BORDER ]==--
  style.WindowBorderSize = 1
  style.ChildBorderSize = 1
  style.PopupBorderSize = 1
  style.FrameBorderSize = 1
  style.TabBorderSize = 1

  --==[ ROUNDING ]==--
  style.WindowRounding = 5
  style.ChildRounding = 5
  style.FrameRounding = 5
  style.PopupRounding = 5
  style.ScrollbarRounding = 5
  style.GrabRounding = 5
  style.TabRounding = 5

  --==[ ALIGN ]==--
  style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
  style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
  style.SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
  style.Colors[imgui.Col.Text]                   = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
  style.Colors[imgui.Col.TextDisabled]           = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
  style.Colors[imgui.Col.WindowBg]               = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
  style.Colors[imgui.Col.ChildBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
  style.Colors[imgui.Col.PopupBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
  style.Colors[imgui.Col.Border]                 = imgui.ImVec4(0.25, 0.25, 0.26, 0.54)
  style.Colors[imgui.Col.BorderShadow]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
  style.Colors[imgui.Col.FrameBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.FrameBgHovered]         = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
  style.Colors[imgui.Col.FrameBgActive]          = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
  style.Colors[imgui.Col.TitleBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.TitleBgActive]          = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.TitleBgCollapsed]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.MenuBarBg]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.ScrollbarBg]            = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.ScrollbarGrab]          = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
  style.Colors[imgui.Col.ScrollbarGrabHovered]   = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
  style.Colors[imgui.Col.ScrollbarGrabActive]    = imgui.ImVec4(0.51, 0.51, 0.51, 1.00)
  style.Colors[imgui.Col.CheckMark]              = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
  style.Colors[imgui.Col.SliderGrab]             = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
  style.Colors[imgui.Col.SliderGrabActive]       = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
  style.Colors[imgui.Col.Button]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.ButtonHovered]          = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
  style.Colors[imgui.Col.ButtonActive]           = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
  style.Colors[imgui.Col.Header]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.HeaderHovered]          = imgui.ImVec4(0.20, 0.20, 0.20, 1.00)
  style.Colors[imgui.Col.HeaderActive]           = imgui.ImVec4(0.47, 0.47, 0.47, 1.00)
  style.Colors[imgui.Col.Separator]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.SeparatorHovered]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.SeparatorActive]        = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.ResizeGrip]             = imgui.ImVec4(1.00, 1.00, 1.00, 0.25)
  style.Colors[imgui.Col.ResizeGripHovered]      = imgui.ImVec4(1.00, 1.00, 1.00, 0.67)
  style.Colors[imgui.Col.ResizeGripActive]       = imgui.ImVec4(1.00, 1.00, 1.00, 0.95)
  style.Colors[imgui.Col.Tab]                    = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
  style.Colors[imgui.Col.TabHovered]             = imgui.ImVec4(0.28, 0.28, 0.28, 1.00)
  style.Colors[imgui.Col.TabActive]              = imgui.ImVec4(0.30, 0.30, 0.30, 1.00)
  style.Colors[imgui.Col.TabUnfocused]           = imgui.ImVec4(0.07, 0.10, 0.15, 0.97)
  style.Colors[imgui.Col.TabUnfocusedActive]     = imgui.ImVec4(0.14, 0.26, 0.42, 1.00)
  style.Colors[imgui.Col.PlotLines]              = imgui.ImVec4(0.61, 0.61, 0.61, 1.00)
  style.Colors[imgui.Col.PlotLinesHovered]       = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
  style.Colors[imgui.Col.PlotHistogram]          = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
  style.Colors[imgui.Col.PlotHistogramHovered]   = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
  style.Colors[imgui.Col.TextSelectedBg]         = imgui.ImVec4(1.00, 0.00, 0.00, 0.35)
  style.Colors[imgui.Col.DragDropTarget]         = imgui.ImVec4(1.00, 1.00, 0.00, 0.90)
  style.Colors[imgui.Col.NavHighlight]           = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
  style.Colors[imgui.Col.NavWindowingHighlight]  = imgui.ImVec4(1.00, 1.00, 1.00, 0.70)
  style.Colors[imgui.Col.NavWindowingDimBg]      = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
  style.Colors[imgui.Col.ModalWindowDimBg]       = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
		end
	},
	{
		name = u8'��������',
		func = function()
    imgui.SwitchContext()
    local ImVec4 = imgui.ImVec4
    imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2, 2)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = 10
    imgui.GetStyle().GrabMinSize = 10
    imgui.GetStyle().WindowBorderSize = 1
    imgui.GetStyle().ChildBorderSize = 1

    imgui.GetStyle().PopupBorderSize = 1
    imgui.GetStyle().FrameBorderSize = 1
    imgui.GetStyle().TabBorderSize = 1
    imgui.GetStyle().WindowRounding = 8
    imgui.GetStyle().ChildRounding = 8
    imgui.GetStyle().FrameRounding = 8
    imgui.GetStyle().PopupRounding = 8
    imgui.GetStyle().ScrollbarRounding = 8
    imgui.GetStyle().GrabRounding = 8
    imgui.GetStyle().TabRounding = 8

    imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(1.00, 1.00, 1.00, 0.43);
    imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.00, 0.00, 0.00, 0.90);
    imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(1.00, 1.00, 1.00, 0.07);
    imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.00, 0.00, 0.00, 0.94);
    imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(1.00, 1.00, 1.00, 0.00);
    imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(1.00, 0.00, 0.00, 0.32);
    imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 0.09);
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(1.00, 1.00, 1.00, 0.17);
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(1.00, 1.00, 1.00, 0.26);
    imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.19, 0.00, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.46, 0.00, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.20, 0.00, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.14, 0.03, 0.03, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.19, 0.00, 0.00, 0.53);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(1.00, 1.00, 1.00, 0.11);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(1.00, 1.00, 1.00, 0.24);
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(1.00, 1.00, 1.00, 0.35);
    imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(1.00, 1.00, 1.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(1.00, 0.00, 0.00, 0.34);
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(1.00, 0.00, 0.00, 0.51);
    imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(1.00, 0.00, 0.00, 0.19);
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(1.00, 0.00, 0.00, 0.31);
    imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(1.00, 0.00, 0.00, 0.46);
    imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(1.00, 0.00, 0.00, 0.19);
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(1.00, 0.00, 0.00, 0.30);
    imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(1.00, 0.00, 0.00, 0.50);
    imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(1.00, 0.00, 0.00, 0.41);
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(1.00, 1.00, 1.00, 0.78);
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(1.00, 1.00, 1.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.19, 0.00, 0.00, 0.53);
    imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.43, 0.00, 0.00, 0.75);
    imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.53, 0.00, 0.00, 0.95);
    imgui.GetStyle().Colors[imgui.Col.Tab]                    = ImVec4(1.00, 0.00, 0.00, 0.27);
    imgui.GetStyle().Colors[imgui.Col.TabHovered]             = ImVec4(1.00, 0.00, 0.00, 0.48);
    imgui.GetStyle().Colors[imgui.Col.TabActive]              = ImVec4(1.00, 0.00, 0.00, 0.60);
    imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = ImVec4(1.00, 0.00, 0.00, 0.27);
    imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = ImVec4(1.00, 0.00, 0.00, 0.54);
    imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00);
    imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(1.00, 1.00, 1.00, 0.35);
    imgui.GetStyle().Colors[imgui.Col.DragDropTarget]         = ImVec4(1.00, 1.00, 0.00, 0.90);
    imgui.GetStyle().Colors[imgui.Col.NavHighlight]           = ImVec4(0.26, 0.59, 0.98, 1.00);
    imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight]  = ImVec4(1.00, 1.00, 1.00, 0.70);
    imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg]      = ImVec4(0.80, 0.80, 0.80, 0.20);
    imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg]       = ImVec4(0.80, 0.80, 0.80, 0.35);
end
	},
	{
		name = u8'�����',
		func = function()
			local ImVec4 = imgui.ImVec4
            imgui.SwitchContext()
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
            imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.06, 0.53, 0.98, 0.70)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(0.10, 0.10, 0.10, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.06, 0.53, 0.98, 0.70)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
        end
	},
	{
		name = u8'�������',
		func = function()
			local ImVec4 = imgui.ImVec4
            imgui.SwitchContext()
            imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(1.00, 1.00, 1.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
            imgui.GetStyle().Colors[imgui.Col.Tab]                    = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.TabHovered]             = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabActive]              = ImVec4(0.98, 0.06, 0.06, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
        end
	},
}


function main() 
        sampRegisterChatCommand('mh', function()
        WinState[0] = not WinState[0]
        end)
        sampRegisterChatCommand('asu', function()
        Roz[0] = not Roz[0]
        end)
        sampRegisterChatCommand("fwarn", cmd_fwarn)
        sampRegisterChatCommand("showpass", cmd_showpass)
        sampRegisterChatCommand("showlic", cmd_showlic)
        sampRegisterChatCommand("showskill", cmd_showskill)
        sampRegisterChatCommand("showmc", cmd_showmc)
        sampRegisterChatCommand("pull", cmd_pull)
        sampRegisterChatCommand("invite", cmd_invite)
        sampRegisterChatCommand("uninvite", cmd_uninvite)
        sampRegisterChatCommand("cuff", cmd_cuff)
        sampRegisterChatCommand("uncuff", cmd_uncuff)
        sampRegisterChatCommand("gotome", cmd_gotome)
        sampRegisterChatCommand("ungotome", cmd_ungotome)
        sampRegisterChatCommand("frisk", cmd_frisk)
        sampRegisterChatCommand("pas", cmd_pas)
        sampRegisterChatCommand("pasf", cmd_pasf)
        sampRegisterChatCommand("mask", cmd_mask)
        sampRegisterChatCommand("arm", cmd_arm)
        sampRegisterChatCommand("drug", cmd_drug)
        sampRegisterChatCommand("arrest", cmd_arrest) 
        sampRegisterChatCommand("stop", cmd_stop) 
        sampRegisterChatCommand("giverank", cmd_giverank) 
        sampRegisterChatCommand("miranda", cmd_miranda) 
        sampRegisterChatCommand("on", cmd_bodyon) 
        sampRegisterChatCommand("of", cmd_bodyoff) 
        sampRegisterChatCommand("ticket", cmd_ticket)
        sampRegisterChatCommand("pursuit", cmd_pursuit)
        sampRegisterChatCommand("testno", cmd_drugtestno)
        sampRegisterChatCommand("testyes", cmd_drugtestyes)
        sampRegisterChatCommand("testlabyes", cmd_testlabyes)
        sampRegisterChatCommand("testlabno", cmd_testlabno)
        sampRegisterChatCommand("bribe", cmd_vzatka)
        sampRegisterChatCommand("unbomb", cmd_bomb)
        sampRegisterChatCommand("probiv", cmd_probiv)
        sampRegisterChatCommand("demoute", cmd_demoute)
        sampRegisterChatCommand("demoute", cmd_dismiss)
        sampRegisterChatCommand("cure", cmd_cure)
        sampRegisterChatCommand("find", cmd_find)
        sampRegisterChatCommand("incar", cmd_incar)
        sampRegisterChatCommand("eject", cmd_eject)
        sampRegisterChatCommand("time", cmd_time)
        sampRegisterChatCommand("fbisecret", cmd_secret_fbi)
        sampRegisterChatCommand("fakepas", cmd_fake_pas)
        sampRegisterChatCommand("doproson", cmd_dopros_on)
        sampRegisterChatCommand("doprosof", cmd_dopros_of)
        sampRegisterChatCommand("testweap", cmd_test_weap)
        sampRegisterChatCommand("delo", cmd_delo)
        sampRegisterChatCommand("spawncar", cmd_spawncar)
end

function cmd_spawncar()
	lua_thread.create(function()
		sampSendChat("/rb ��������! ����� 20 ������ ����� ����� ����������.")
		wait(2000)
		sampSendChat("/rb ������� ���������, ����� �� ����� ���������.")
		wait(18000)
		spawncar = true
		sampSendChat("/lmenu")
		wait(1000)
		spawncar = false
	end)
end

require("samp.events").onShowDialog = function(dialogid, style, title, button1, button2, text)
    if dialogid == 1214 and spawncar then -- ����� �/�
        sampSendDialogResponse(1214, 1, 3, 0)
        spawncar = false
        return false
    end
end

imgui.OnInitialize(function()
    imgui.GetIO().IniFilename = nil
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    iconRanges = imgui.new.ImWchar[3](faicons.min_range, faicons.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(faicons.get_font_data_base85('solmyID'), 14, config, iconRanges)
end)

function cfg_save()
inicfg.save(ini, "Auto Tag MH.ini")
end

function cmd_d(data)
if data == "" then
sampAddChatMessage("������� ��������� ��� ��������!", -1)
else
sampSendChat("/d ["..ini.cfg.mytag.."] "..zk.." ["..ini.cfg.totag.."]: "..data.."")
end
end

function cmd_incar(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/incar [ID] [1-3].",0x318CE7FF -1)
    else
    lua_thread.create(function ()
        sampSendChat("/todo ������ ����������!*����� ����������� � ������, �������� �����, �������� ������ �����������")
        wait(1500)
        sampSendChat("/incar "..id.." "..reason)
    end)
end
end

function cmd_fwarn(arg)
    lua_thread.create(function ()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/me ������ ��� �� ������� � ������� � ���� ����������� �����������")
        wait(1500)
        sampSendChat("/me ����� ����������, �������� ���������� � �� � ������� ��� ������� � ������")
        wait(1500)
        sampSendChat("/fwarn "..arg1.." "..arg2)
    else
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/fwarn [ID][reason].",0x318CE7FF -1)
    end
end)
end

function cmd_showpass(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/showpass [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ������ ����� � �����������")
        wait(1500)
        sampSendChat("/do ����� � ����.")
        wait(1500)
        sampSendChat("/me ������ �������")
        wait(1500)
        sampSendChat("/do ������� � ����.")
        wait(1500)
        sampSendChat("/me ������� ������� �������� �� ������")
        wait(1500)
        sampSendChat("/showpass " ..id.. " ")
    end)
end
end

function cmd_giverank(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/me ������ �� ������� ��� � ������� � ���� ������ �����������")
        wait(1500)
        sampSendChat("/me ����� ����������, ����� �� ���������� ���������, ������� ��� ������")
        wait(1500)
        sampSendChat("/giverank "..arg1.." "..arg2)
    else
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/giverank [ID] [rank].",0x318CE7FF -1)
    end
end)
end
function cmd_pas(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/pas [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat('������������, ��������� ������������ ������� �����, ��� - '..sampGetPlayerNickname(myID))
            wait(1000)
            sampSendChat('/do ����� �� ����� ����� ������������, ������ - ������� ������� � ��������.')
            wait(1000)
            sampSendChat('/showbadge '..id)
            wait(1000)
            sampSendChat('����� ���������� �������� �������������� ���� ��������.')
    end)
end
end
function cmd_pasf()
        lua_thread.create(function()
            sampSendChat('������� ������� �����, ��� ��������� ��������� FBI.')
        wait(1000)
        sampSendChat('/do �� ����� ����� FBI.')
        wait(1000)
        sampSendChat('������ ����� ������������ ���� ����������� ����������, �������')
        end)
    end
function cmd_showlic(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/showlic [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ������ ����� � �����������")
        wait(1500)
        sampSendChat("/do ����� � ����.")
        wait(1500)
        sampSendChat("/me ������ ��������")
        wait(1500)
        sampSendChat("/do �������� � ����.")
        wait(1500)
        sampSendChat("/me ������� �������� �������� �� ������")
        wait(1500)
        sampSendChat("/showlic " .. id .. " ")
    end)
end
end

function cmd_showskill(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/showskill [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ������ ����� � �����������")
        wait(1500)
        sampSendChat("/do ����� � ����.")
        wait(1500)
        sampSendChat("/me ������ ������� � ����")
        wait(1500)
        sampSendChat("/do ������� � ����.")
        wait(1500)
        sampSendChat("/me ������� ������� �������� �� ������")
        wait(1500)
        sampSendChat("/showskill " .. id .. " ")
    end)
end
end

function cmd_showmc(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/showmc [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ������ ����� � �����������")
        wait(1500)
        sampSendChat("/do ����� � ����.")
        wait(1500)
        sampSendChat("/me ������ ���. �����")
        wait(1500)
        sampSendChat("/do ���. ����� � ����.")
        wait(1500)
        sampSendChat("/me ������� ���. ����� �������� �� ������")
        wait(1500)
        sampSendChat("/showmc " .. id .. " ")
    end)
end
end

function cmd_pull(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/pull [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ������� ������� � �����, ������ ������� �� � ����� ���� �� ���� ��������")
        wait(1500)
        sampSendChat("/pull " .. id .. " ")
        wait(1500)
        sampSendChat("/me ������ ������, ������ ����� ������� � ������� �������� �� ������ ...")
        wait(1500)
        sampSendChat("/me ... ����� ����, �������� �������������� �� ������� � ������� ��� ����")

    end)
end
end

function cmd_invite(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/invite [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/do ��� ������� ��������� ������.")
        wait(1500)
        sampSendChat("/do ����� � �������...")
        wait(1500)
        sampSendChat("/me ����� ���� � ������, ����� ���� ���� ����� � ������� � ����")
        wait(1500)
        sampSendChat("/me ������� ����� � �������")
        wait(1500)
        sampSendChat("/todo ����� �������������*�������� ������� �� ����� ����������")
        wait(1500)
        sampSendChat("/invite " .. id .. " ")
    end)
end
end

function cmd_uninvite(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat ("/do � ������� ����� ��� � ����� ������")
        wait(1500)
        sampSendChat ("/me ��������� ������ ����, ��������� ������ ��� �� �������")
        wait(1500)
        sampSendChat ("/do ��������� ������ ��� � �����.")
        wait(1500)
        sampSendChat("/me ��������� ������ ����, ����� �� ������ ��������� ���")
        wait(1500)
        sampSendChat ("/me ����� ���� ������ �����������")
        wait(1500)
        sampSendChat ("/me ����� �� ������ ������� ����������")
        wait(1500)
        sampSendChat ("/do ���: ��������� ���������� � ����������.")
        wait(1500)
        sampSendChat ("/me ������ ��������� ���, �������� ���������� � ����������, ����� ���� ����� ������ ������� ����������")
        wait(1500)
        sampSendChat ("/do ���: ��������� ������� ������ �� ���� ������.")
        wait(1500)
        sampSendChat("/uninvite " ..arg1.. " "..arg2)
    else
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/uninvite [ID] [reason].",0x318CE7FF -1)
    end
end)
end

function cmd_cuff(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/cuff [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ����� ����� ��������������, ������ ������� �� �������� ��������� ...")
        wait(1500)
        sampSendChat("/cuff "..id.." ")
        wait(1500)
        sampSendChat("/me ... �, �������� ���� �������������� ������� �� �� ����")
     end)
  end
end

function cmd_uncuff(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/uncuff [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/do ���� �� ���������� � �������.")
        wait(1500)
        sampSendChat("/me ��������� ������ ���� ������ �� ������� ���� � ������ ���������")
        wait(1500)
        sampSendChat("/do ���������� ��������.")
        wait(1500)
        sampSendChat("/uncuff "..id.." ")
    end)
 end
end

function cmd_gotome(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/gotome [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ������� ������ ���� ����������")
        wait(1500)
        sampSendChat("/me ����� ���������� �� �����")
        wait(1500)
        sampSendChat("/gotome "..id.." ")
    end)
 end
end

function cmd_ungotome(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/ungotome [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me �������� ������ ���� �����������")
        wait(1500)
        sampSendChat("/do ���������� ��������.")
        wait(1500)
        sampSendChat("/ungotome "..id.." ")
    end)
 end
end

function cmd_frisk(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/frisk [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ����� ��������� ��������, ����� ����������� ���������� �� ����� ���� ...")
        wait(1500)
        sampSendChat("/do �������� ������.")
        wait(1500)
        sampSendChat("/me �������� ������ �� ������� ����� ����")
        wait(1500)
        sampSendChat("/me ... �� ��� ����� ��������� ���������� ����������, ���������� �� ��� ��������")
        wait(1500)
        sampSendChat("/frisk " .. id .. " ")
    end)
end
end

function cmd_pursuit(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/pursuit [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ������� ���� �� ���������� ��������� ����������, ����� ����� �� ���� ������ �� �����")
        wait(1500)
        sampSendChat("/me ����� ���, �������� ����� �������� � ������� ������������ �� GPS")
        wait(1000)
        sampSendChat("/pursuit " .. id .. " ")
    end)
end
end

function cmd_arm()
    lua_thread.create(function()
        sampSendChat("/armour")
        wait(1500)
        sampSendChat("/me ������ �������� � �����������")
    end)
end
function cmd_ticket(arg)
    lua_thread.create(function ()
        local arg1, arg2, arg3 = arg:match('(.+) (.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil and arg3 ~= nil then
        sampSendChat("/me ������ ��������� ��������, ����������� ��� � ��� � ������� ������� ��� �����")
        wait(1500)
        sampSendChat("/todo �������� ������� ������������, ����� ��������� ����� � �������!*����� ��������")
        wait(1500)
        sampSendChat("/ticket "..arg1.." "..arg2.." "..arg3.." ")
    else
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/ticket [ID] [�����] [reason].",0x318CE7FF -1)
    end
end)
end
function cmd_mask()
lua_thread.create(function()
        sampSendChat("/mask")
        wait(1500)
        sampSendChat("/me ����� �� ���� ��������, ����� ��������� �� ����")
    end)
end

function cmd_drug(id)
if id == "" then
     sampAddChatMessage("����� ���-�� ����� [1-3]: {FFFFFF}/usedrugs [1-3].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ������ �� ������� �������� �����")
        wait(1500)
        sampSendChat("/do ���� ������, ���� ��.")
        sampSendChat("/usedrugs "..id.." ")
    end)
end
end


function cmd_arrest(id)
if id == "" then
     sampAddChatMessage("����� ���� ������:: {FFFFFF}/arrest [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ����� �� �������, ������� ���������� � ����������� ����������� ...")
        wait(1500)
        sampSendChat("/me �������� �������� ��� �������������")
        wait(1500)
        sampSendChat("/do �����������: �������, �������� ���� ��������.")
        wait(1500)
        sampSendChat("/do �� ������� ������� 2 �������, ����� �������� �����������.")
        sampSendChat("/arrest "..id.." ")
    end)
end
end
function cmd_stop(arg)
    lua_thread.create(function()
        local arg1 = arg:match('(.+)')
    if arg1 ~= nil then
        sampSendChat("/do ������� ��������� � ��������.")
        wait(1500)
        sampSendChat("/me ������ ������� �� ��������, ������ ��� � ��� � ����� ��������")
        wait(1500)
        sampSendChat("/m �������� ������������� ��������, � N "..arg1.." ���������� � ������� � ��������� ���������...")
        wait(1500)
        sampSendChat("/m ...���� ������� �� ����. � ������ ������������, �� ��� ����� ������ �����")
        wait(1500)
        sampSendChat("/me �������� �������� � ����� ������� � ��������")
    else
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/stop [ID].",0x318CE7FF -1)
    end
end)
end
function cmd_miranda()
lua_thread.create(function()
        sampSendChat("�� ������ ����� ������� ��������.")
        wait(1500)
        sampSendChat(" ��, ��� �� �������, �� ����� � ����� ������������ ������ ��� � ����.")
        wait(1500)
        sampSendChat(" �� ������ ����� �� �������� � �� ���� ���������� ������.")
        wait(1500)
        sampSendChat(" ���� � ��� ��� ��������, ����������� ����������� ��� ��������, ������� �������� �� ������� � ���� ����.")
        wait(1500)
        sampSendChat(" ��� ������� ���� �����?")
    end)
 end

function cmd_bodyon()
    lua_thread.create(function()
        sampSendChat("/do �� ����� ����� ��������� HD-������.")
        wait(1500)
        sampSendChat("/me ���������� ��������� ������ ���� ���������� � ������, ����� ������ ��������� ������")
        wait(1500)
        sampSendChat("/do ������ �� ����� ����� ������.")
    end)
 end


function cmd_bodyoff()

lua_thread.create(function()
        sampSendChat("/do �� �����  ����� ��������� HD-������")
        wait(1500)
        sampSendChat("/me ���������� ��������� ������ ���� ���������� � ������, ����� ������ ���������� ������")
        wait(1500)
        sampSendChat("/do ������ �� ����� ��������� ����� ������ � ��������� � �� SD �����")
    end)
end

function cmd_drugtestno()
lua_thread.create(function()
        sampSendChat("/me ������ �������� ����������, ������ ����� ���������� �����������.")
        wait(1500)
        sampSendChat("/me ������ ���, ���� �� ������ �������� � �������� �������")
        wait(1500)
        sampSendChat("/me ������� � �������� �������� ��������")
        wait(1500)
        sampSendChat ("/me ������� � �������� ���� �����-����-10")
        wait(1700)
        sampSendChat("/me ������� ���������� ����������� ��������")
        wait(1700)
        sampSendChat("/do ���� ��� ������������� ���������, �������� �� �������� ����������. ")
    end)
 end


function cmd_drugtestyes()
lua_thread.create(function()
        sampSendChat("/me ������ �������� ���������� ������ ����� � ���������� ������������")
        wait(1500)
        sampSendChat("/me ������ ���, ���� �� ������ �������� � �������� �������")
        wait(1500)
        sampSendChat("/me ������� � �������� �������� ��������")
        wait(1500)
        sampSendChat ("/me ������� � �������� ���� �����-����-10")
        wait(1700)
        sampSendChat("/me ������� ���������� ����������� ��������")
        wait(1700)
        sampSendChat("/do ���� ��� ������������� ���������, �������� �������� ����������.")
    end)
end

function cmd_testlabyes()
lua_thread.create(function()
    sampSendChat("/do �� ����� ����� ���������, ����� � ��� ����� ��������� �������� � ����� ����.")
    wait(1500)
    sampSendChat("/do �� ���������� ������� ����� ������� ����������� ��������.")
    wait(1500)
    sampSendChat("/do ����� �� ����� ����� ��������� ����� � �����, � ������ �� ����� �������.")
    wait(1500)
    sampSendChat("/do ����� �� ����� ����� ��������� ����� � �����, � ������ �� ����� �������.")
    wait(1500)
    sampSendChat("/me ..������� ��� ���������� �� ����, ������� �� ����� ����� �����")
    wait(1500)
    sampSendChat("/do ���� ���������� ��� ���������� ������� ����������.")
    wait(1500)
    sampSendChat("/me �������� ���������� ��� ���� ���������� ������ ��-��� ���������� � ������� �� ���� ���� ����������..")
    wait(1500)
    sampSendChat("/me ..�������� � �����, ����� ���� ���� �������, �������� � ����� � ������ ������ ��������")
    wait(1500)
    sampSendChat("/me ������ ������� ������� ������� � ��������, ������� ���������� ������ ��� ��������� � ����� �������� �������..")
    wait(1500)
    sampSendChat("/me ..����������, ������ � ����� ����������")
    wait(1500)
    sampSendChat("/me �� ������� ������� �� ������ ����������, ���� �� ����� ����� � ����������� ����� ������� � ��������, ...")
    wait(1500)
    sampSendChat("/me ..��������� �������� � ����� � ������������ �� ������ ����������")
    wait(1500)
    sampSendChat("/do ����� ����������� ������ ��� ����� � ����� �������� ����������, ��� �������� ���� ����������.")
    wait(1500)
    sampSendChat("/me ������������� �� ����������, ������� ����� �� ����, ����� ���� ������� ���������� ��� ������..")
    wait(1500)
    sampSendChat("/me ..�� ���������� ������� ��� � ������������� ���, ����� � ���� ������������ ������� ���, ��� �������� - ��������.")
end)
end

function cmd_testlabno()
lua_thread.create(function()
    sampSendChat("/do �� ����� ����� ���������, ����� � ��� ����� ��������� �������� � ����� ����.")
    wait(1500)
    sampSendChat("/do �� ���������� ������� ����� ������� ����������� ��������.")
    wait(1500)
    sampSendChat("/do ����� �� ����� ����� ��������� ����� � �����, � ������ �� ����� �������.")
    wait(1500)
    sampSendChat("/do ����� �� ����� ����� ��������� ����� � �����, � ������ �� ����� �������.")
    wait(1500)
    sampSendChat("/me ..������� ��� ���������� �� ����, ������� �� ����� ����� �����")
    wait(1500)
    sampSendChat("/do ���� ���������� ��� ���������� ������� ����������.")
    wait(1500)
    sampSendChat("/me �������� ���������� ��� ���� ���������� ������ ��-��� ���������� � ������� �� ���� ���� ����������..")
    wait(1500)
    sampSendChat("/me ..�������� � �����, ����� ���� ���� �������, �������� � ����� � ������ ������ ��������")
    wait(1500)
    sampSendChat("/me ������ ������� ������� ������� � ��������, ������� ���������� ������ ��� ��������� � ����� �������� �������..")
    wait(1500)
    sampSendChat("/me ..����������, ������ � ����� ����������")
    wait(1500)
    sampSendChat("/me �� ������� ������� �� ������ ����������, ���� �� ����� ����� � ����������� ����� ������� � ��������, ...")
    wait(1500)
    sampSendChat("/me ..��������� �������� � ����� � ������������ �� ������ ����������")
    wait(1500)
    sampSendChat("/do ����� ����������� ������ ��� ����� � ����� �������� ����������, ��� �������� �� ���� ����������.")
    wait(1500)
    sampSendChat("/me ������������� �� ����������, ������� ����� �� ����, ����� ���� ������� ���������� ��� ������..")
    wait(1500)
    sampSendChat("/me ..�� ���������� ������� ��� � ������������� ���, ����� � ���� ������������ ������� ���, ��� �������� - �� ��������.")
end)
end

function cmd_vzatka(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/me ������� �� ������������, ������ � �������� ����� � ��������.")
        wait(1500)
        sampSendChat("/me ����� �� �������� ����� � ������ ������, ������ �� ������ �������.")
        wait(1500)
        sampSendChat("/do �� �������� �������� � ������ ���� ��������: 3.000.000$.")
        wait(1500)
        sampSendChat("/bribe "..arg1.." "..arg2)
    else
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/bribe [ID] [�����].",0x318CE7FF -1)
    end
end)
end

function cmd_bomb()
lua_thread.create(function()
        sampSendChat("/do � ����� ��� ���� �����, ��� �������������� �����.")
        wait(2500)
        sampSendChat("/me ������� ���� �� ���, �������� ���������� ��� ������ ��� � ���� � ������ ���� �������")
        wait(2500)
        sampSendChat("/do � ����� ���� ���� ��������: �����, �����, �������, ������ � �������.")
        wait(2500)
        sampSendChat("/me ����������� ������ �������� ����������, ����� ��������� ������ �������, ������� ����� �..")
        wait(2500)
        sampSendChat("/me .. ������ ��������� �����, ����������� ����� ����� ������� ��")
        wait(2500)
        sampSendChat("/todo ���� ������.*��������� ��������� ������ ������ �����")
        wait(2500)
        sampSendChat("/removebomb")
        wait(100)
        sampSendChat("/do ����� �����������, ������ �� ��� �����������, � ����� ������� ������������.")
        wait(2500)
        sampSendChat("/me �������� ���������� ��� ������� ������� � ����, ����� ���� ���� ����� � ��� ����...")
        wait(2500)
        sampSendChat("/me ...� ������� � � ����������� ����� � ����� �����, ������ �������� ��� � ���� � ����� ����")
    end)
end

function cmd_probiv()
    lua_thread.create(function()
    sampSendChat("/do �� ����� ����� ������ ��� ����������.")
    wait(1500)
    sampSendChat("/me ���� � ����� ��� , ����� ��������� ��������...")
    wait(1500)
    sampSendChat("/me ... �� ��� ����, ID-����� , �������� � ������")
    wait(1500)
    sampSendChat("/do �� ������ ��� ����������� ��� ���������� � ��������.")
end)
end

function cmd_cure(id)
if id == "" then   
     sampAddChatMessage("����� ���� ������: {FFFFFF}/cure [ID].", 0x318CE7FF)
else
    lua_thread.create(function()
        sampSendChat("/cure "..id.." ")
        wait(1500)
        sampSendChat("/me ������ ����������� ����� ����� �������������")
        wait(1500)
        sampSendChat("/do ���.����� �� �����.")
        wait(1500)
        sampSendChat("/me ����������� ��� �����, ����� ����������� ����� �� ������ �������")
        wait(1500)
        sampSendChat("/do ����� �����������.")
        wait(1500)
        sampSendChat("/me �������� �������� ������ ������, ����� �� ������� �������� �����")
        wait(1500)
        sampSendChat("/do ������ ��������� ����� ������ �������� �������� ������.")
        wait(1500)
        sampSendChat("/todo ���-�� ��� ������ �����*������ ����������� ����� � �����")
    end)
end
end

function cmd_time()
lua_thread.create(function()
    sampSendChat("/me ������ ���� � ��������� �� ���� � ����������� 'Love FBI'")
    wait(1200)
    sampSendChat("/time")
    sampSendChat('/do �� ����� ���� � �����: '..os.date('%H:%M:%S'))
end)
end

function cmd_find(id)
if id == "" then
     sampAddChatMessage("����� ���� ������: {FFFFFF}/find [ID].", 0x318CE7FF - 1)
else
    lua_thread.create(function()
    sampSendChat("/me ������� ���� �� ���������� ��������� ����������, ����� ����� �� ���� ������ �� �����")
    wait(1500)
    sampSendChat("/find "..id.." ")
    wait(1500)
    sampSendChat("/me ����� ���, �������� ����� �������� � ������� ������������ �� GPS")
  end)
end
end

function cmd_demoute(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/do � ������ ������� ���� ��������� ���.")
        wait(1500)
        sampSendChat("/me ������ ��� �� ������� �������, ����� ����� ��������� �� ���� ������ ���������� ����� ����, ID ����� � �����")
        wait(1500)
        sampSendChat("/do �� ������ ��� ��������� ������ ���������� � ����������.")
        wait(1500)
        sampSendChat("/me ����� �� ������ ������� �� ���. �����������")
        wait(1500)
        sampSendChat("/demoute "..arg1.." "..arg2)
        wait(1500)
        sampSendChat("/do ��������� ��� ������ �� ������ ���. �����������.")
        else
            sampAddChatMessage("����� ���� ������:: {FFFFFF}/demoute [ID] [reason].",0x318CE7FF -1)
    end
end)
end

function cmd_dismiss(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat("/do � ������ ������� ���� ��������� ���.")
        wait(1500)
        sampSendChat("/me ������ ��� �� ������� �������, ����� ����� ��������� �� ���� ������ ���������� ����� ����, ID ����� � �����")
        wait(1500)
        sampSendChat("/do �� ������ ��� ��������� ������ ���������� � ����������.")
        wait(1500)
        sampSendChat("/me ����� �� ������ ������� �� ���. �����������")
        wait(1500)
        sampSendChat("/dismiss "..arg1.." "..arg2)
        wait(1500)
        sampSendChat("/do ��������� ��� ������ �� ������ ���. �����������.")
        else
            sampAddChatMessage("����� ���� ������:: {FFFFFF}/demoute [ID] [reason].",0x318CE7FF -1)
    end
end)
end

function cmd_eject(id)
if id == "" then
    sampAddChatMessage("����� ���� ������:: {FFFFFF}/eject [ID].",0x318CE7FF -1)
else
    lua_thread.create(function()
        sampSendChat("/me ������ ����� ����, ����� ���� �������� "..sampGetPlayerNickname(id).." �� ���� �� �����")
        wait(1500)
        sampSendChat("/eject "..id.." ")
        wait(1500)
        sampSendChat("/me ������ ����� ����")
  end)
end
end

function cmd_secret_fbi()
lua_thread.create(function()
    sampSendChat("/do �� ����� ����� ��������: �������� � ������������� ������������ ���.")
    wait(1500)
    sampSendChat("/do ����� � ���������� ��������� ����������� ����� � ������� ����������� ���.")
    wait(1500)
    sampSendChat("/do � ��������� ��������: �, (��� / �������), ������� ������� ������ ��, ��� �����, ����, � ���� ������.")
    wait(1500)
    sampSendChat("/do ���� ��������: ����� ����� ������ ���������������, � � ������ ������ �������������, ...")
    wait(1500)
    sampSendChat("/do ... ����� ���� ������������ � ������������ �� ���������, ��� ������� �������.")
    wait(1500)
    sampSendChat("/do ��� ���� ��������: ����: ; �������: .")
    wait(1500)
    sampSendChat("/me ������� �������� � ������ ��������")
    wait(1500)
    sampSendChat("��������� ���������� �������� � ������� ��� ���, � ������ ������!")
    wait(1500)
end)
end

function cmd_fake_pas()
lua_thread.create(function()
sampSendChat("/do � ��������� ������� ���������� ��������� �������.")
wait(1500)
sampSendChat("/todo ��� ���������*������ �� ���������� ������� ��������� �������")
wait(1500)
sampSendChat("/me ������ ������� �� ���������� �������, ����� ���� ��������� ��� �������� ��������")
wait(1500)
sampSendChat("/do � �������� ��������: ���: Mark � ����� 30 ���. ������: ��� ��.")
wait(1500)
sampSendChat("/me ����� ������� � ��������� ������")
end)
end

function cmd_dopros_on()
lua_thread.create(function()
sampSendChat("/me �������� � ������ ������� ������ � ���� ��������� � �������� �� ������ ��������� ������.")
wait(1500)
sampSendChat("/do ������ � ���� ��������� ������ ������ ��������� � � ������.")
wait(1500)
sampSendChat("/me ������� �� �����, � ������������ ������ ����� ������� ��� ������.")
wait(1500)
sampSendChat("/do � ����� ���������: ��������, �������, � �������������� ��� ���������.")
wait(1500)
sampSendChat("/me ������ �����, ������� ��� ���������� �� ����")
wait(1500)
sampSendChat("/me ��������� ���������� ��������� � ��������")
wait(1500)
sampSendChat("/do �� ����� ����� �������� ��� ��������� ������ � ����������� ����.")
wait(1500)
sampSendChat("/me ��������� �������� � ������� ����� ��������, ����� ���� ���� ����� �� ������ ��������.")
wait(1500)
sampSendChat("/me �������� �� ������������.")
wait(1500)
sampSendChat("/do ���������� ���������� � �������� �����.")
wait(1500)
sampSendChat("����, ����� ������, ������ � ���� ��� �������� �������, ������� �������� �� ��� ���������.")
wait(1500)
sampSendChat("���� �� ������ �������� �� ��� �������, � �� ������, � ��� ������ ���� ���� ������ ��� ������ �� ������ ���������.")
wait(1500)
sampSendChat("� ������� �� ������ ������ �� �������.")
wait(1500)
sampSendChat("/b ����� ������� �������� ������� � ���� ���������� �� ������������ ������ � /do")
wait(1500)
sampSendChat("/b ����� �� ������ ������ /do *��� ���* ������� ��������� �� ������.")
wait(1500)
sampSendChat("/b � ������ ��, ���� �� ����� ������� ����� �� ���������� �� ������� ������� � /do ������� ���������, ��� �� � ���� �������, ����.")
wait(1500)
sampSendChat("� ���, ���� ��� ������� � �������?")
wait(1500)
end)
end

function cmd_dopros_of()
lua_thread.create(function()
sampSendChat("/me �������� � ������ ������� ������ � ���� ��������� � �������� ������ ���������� ������.")
wait(1500)
sampSendChat("/do ������ � ���� ��������� ���������� ������, � ��������� � � ������.")
wait(1500)
sampSendChat("/me ������� �� ��������, � ���� � ���� �������� � �������")
wait(1500)
sampSendChat("/me ������� ������������ �� ����, ����� ���� ������ � ������� � �����.")
wait(1500)
sampSendChat("/me ������ �����, � ������� � ��� ����")
wait(1500)
sampSendChat("���, �� ���-�")
wait(1500)
sampSendChat("������ �� ��� �������. �������.")
wait(1500)
end)
end

function cmd_test_weap()
lua_thread.create(function()
sampSendChat("/do � ������� ������� ����� ��������� ��������.")
wait(1500)
sampSendChat("/me ������ ����� ������ �� ������� �������� � ����� �� �� ����� ���")
wait(1500)
sampSendChat("/do �� ����� ����� ������, ������� � ���� ����� ������, ��� ������ � ����������.")
wait(1500)
sampSendChat("/me �������� ������ � ��������� �������� ��� �� ��������� �����")
wait(1500)
sampSendChat("/me ���� � ���� ������ � ������� ������, �������� ������� � ������ ���� ����������")
wait(1500)
sampSendChat("/me ����� ������� ������ �� �������")
wait(1500)
sampSendChat("/do �� ������� ������ �������� ����� ������ �� �� ���������� ������.")
wait(1500)
sampSendChat("/me ��������� ������� � ������� �� ���� ������")
wait(1500)
sampSendChat("/me ���� �������� �� ������ � ��������� ���������� � ����� � ��������")
wait(1500)
sampSendChat("/me ������ �������� � �������� �� ������ ������")
wait(1500)
sampSendChat("/me ���� � ���� ������ ��������� ������� � ���������� �������� ����� ������")
wait(1500)
sampSendChat("/me ������� ��������� � ������ ���� ������, � ��������� ������ ��� ����� ������")
wait(1500)
sampSendChat("/do �� ������ ����������� ���������� �� ������ � ���������.")
wait(1500)
sampSendChat("/me ������� ������ ��������� ������� ������� �� ����")
wait(1500)
sampSendChat("/me ������ ������ � �����, ������ �� ����� ���������� ����.����� � �������� � ���� �����e")
wait(1500)
sampSendChat("/me ���� �� ����� ��������� � ������� �� ����.�����, ����� ��������� � ���� � ������ ���")
end)
end

function cmd_delo()
lua_thread.create(function()
SampSendChat("/do �� ����� ����� ����� ����� � ��������.")
wait(1500)
SampSendChat("/me ���� ���� �����, ������ � � �������� ����������")
wait(1500)
SampSendChat("/me ������� ����� �� ���� �����, ��������� ������ �� ����")
wait(1500)
SampSendChat("/do � ������� ����� ����� ����� ����� � ������.")
wait(1500)
SampSendChat("/me ������ ����, ���� ����� � �������, ������� �� �� ����")
wait(1500)
SampSendChat("/me ������ �����, ���� ����� � ������ ����, ��������� ����")
wait(1500)
SampSendChat("/do ����� �������� � ��������.")
wait(1500)
SampSendChat("/me �������� ��������� �����, �������� ������ � ������ ����, ������ �����")
wait(1500)
SampSendChat("/me ����� �������������� � ����, ������� ����� �� ���� �����")
wait(1500)
end)
end
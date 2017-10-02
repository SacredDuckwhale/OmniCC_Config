--[[
	dropdown.lua
		A bagnon dropdown menu
--]]

OmniCCOptions = OmniCCOptions or {}

local Dropdown = LibStub('Classy-1.0'):New('Frame'); Dropdown:Hide()
OmniCCOptions.Dropdown = Dropdown

function Dropdown:New(name, parent, width)
	local f = self:Bind(CreateFrame('Frame', parent:GetName() .. name, parent, 'L_UIDropDownMenuTemplate'))
	L_UIDropDownMenu_SetWidth(f, width)

	local text = f:CreateFontString(nil, 'BACKGROUND', 'GameFontNormalSmall')
	text:SetPoint('BOTTOMLEFT', f, 'TOPLEFT', 21, 0)
	text:SetText(name)
	f.titleText = text

	f:SetScript('OnShow', f.UpdateValue)
	return f
end


--[[ Update Methods ]]--

function Dropdown:SetSavedValue(value)
	assert(false, 'Hey you forgot to implement SetSavedValue for ' .. self:GetName())
end

function Dropdown:GetSavedValue()
	assert(false, 'Hey you forgot to implement GetSavedValue for ' .. self:GetName())
end

function Dropdown:GetSavedText()
  return self:GetSavedValue()
end

function Dropdown:UpdateValue()
	L_UIDropDownMenu_SetSelectedValue(self, self:GetSavedValue())
	L_UIDropDownMenu_SetText(self, self:GetSavedText())
end


--[[ Item Adding ]]--

function Dropdown:AddItem(name, value, tooltip)
  value = value or name
  
	local info = L_UIDropDownMenu_CreateInfo()
	info.text = name
  info.checked = (self:GetSavedValue() == value)
	info.func = function()
    self:SetSavedValue(value)
    self:UpdateValue()
  end

  if tooltip then
    info.tooltipTitle = name
    info.tooltipText = tooltip
    info.tooltipOnButton = true
  end

	L_UIDropDownMenu_AddButton(info)
end
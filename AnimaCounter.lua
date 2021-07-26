	local vAC_AppTitle = "|CFF00CCFF"..strsub(GetAddOnMetadata("AnimaCounter", "Title"),2).."|r v"..GetAddOnMetadata("AnimaCounter", "Version")
	local vAC_PlayerLevel = UnitLevel("player")
------------------------------------------------------------------------
-- Anima Counts
------------------------------------------------------------------------	
	function AnimaCount()
		
		local AnimaID = {
			181368, 181377, 181477, 181478, 181479, 181540, 181541,	181544,	181545, 181546,
			181547, 181548, 181549, 181550, 181551, 181552, 181621, 181622, 181642, 181643,
			181644, 181645, 181646, 181647, 181648, 181649, 181650, 181743, 181744, 181745,
			
			182749, 
			
			183723, 183727, 
			
			184146, 184147, 184148,	184149, 184150, 184151, 184152, 184286, 184293, 184294,
			184305, 184306, 184307, 184315, 184360, 184362, 184363, 184371, 184373, 184374,
			184378, 184379, 184380, 184381,	184382, 184383,	184384, 184385,	184386, 184387,
			184388, 184389, 184519, 184763, 184764, 184765, 184766, 184767, 184768, 184769,
			184770, 184771, 184772,	184773, 184774, 184775, 184776, 184777,
			
			186200,	186201,	186202, 186204,	186205, 186206,
			
			187175, 187347, 187349, 187517,
		}
		local TotalCount, TotalPiece = 0, 0
		local AnimaReservoir = C_CurrencyInfo.GetCurrencyInfo(1813).quantity
		
		for a = 1, #AnimaID do
			local AnimaCount = GetItemCount(AnimaID[a],true,true)
				TotalPiece = TotalPiece + AnimaCount
			
			local iName, _, iRare = GetItemInfo(AnimaID[a])		
			local tCnt = 0

			if iRare == 2 then tCnt = AnimaCount*5 end
			if iRare == 3 then tCnt = AnimaCount*35 end
			if iRare == 4 then tCnt = AnimaCount*250 end
			TotalCount = TotalCount + tCnt
		end
		
		vAC_MiniAnima.Text:SetText(
			"== |CFFFFFF00Anima Count|r =="..
			"\n"..Colors(7,"In Bag: ")..(TotalPiece or 0).." ("..(TotalCount or 0)..")"..
			"\n"..Colors(7,"In Resvr: ")..(AnimaReservoir or 0)..
			"\n"..Colors(7,"Total: ")..((TotalCount + AnimaReservoir) or 0)..
			"\n"..Colors(7,"==========")..
			"\n"..Colors(7,"Til Cap: ")..((35000-(AnimaReservoir+TotalCount)) or 0)
		)
	end
------------------------------------------------------------------------
-- Color Choice
------------------------------------------------------------------------
	function Colors(c,t,e)
		-- 1R 2G 3B 4Y 5B 6W 7Custom 8Inputs
		if c == 8 then
			ColorChoice = ExpacColor[e]
		else
			local ColorSelect = { "FF0000", "00FF00", "0000FF", "FFFF00", "000000", "FFFFFF", "CCCC66", }
			ColorChoice = ColorSelect[c]
		end
		return "|cFF"..ColorChoice..(t == nil and "" or t).."|r"
	end

------------------------------------------------------------------------
-- Table of Frame Backdrops
------------------------------------------------------------------------
	local Backdrop_A = {
		edgeFile = "Interface\\ToolTips\\UI-Tooltip-Border",
		bgFile = "Interface\\BlackMarket\\BlackMarketBackground-Tile",
		tileEdge = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	}
	local Backdrop_B = {
		edgeFile = "Interface\\ToolTips\\UI-Tooltip-Border",
		bgFile = "Interface\\BankFrame\\Bank-Background",
		tileEdge = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	}
	local Backdrop_C = { --Temp
		edgeFile = "Interface\\ToolTips\\UI-Tooltip-Border",
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Background",
		tileEdge = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	}
	local Backdrop_NBgnd = {
		edgeFile = "Interface\\ToolTips\\UI-Tooltip-Border",
		tileEdge = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	}
	local Backdrop_NBdr = {
		bgFile = "Interface\\CHATFRAME\\CHATFRAMEBACKGROUND",
		tileEdge = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	}

	local Font_Lg = 14		--Large Font Size
	local Font_Md = 12		--Medium Font Size
	local Font_Sm = 10		--Small/Normal Font Size
	local FontStyle = { "Fonts\\FRIZQT__.TTF", "Fonts\\ARIALN.ttf", "Fonts\\MORPHEUS.ttf", "Fonts\\skurri.ttf", }	
------------------------------------------------------------------------
-- Mini Window for Anima Counter
------------------------------------------------------------------------
	local vAC_MiniAnima = CreateFrame("Frame", "vAC_MiniAnima", UIParent, BackdropTemplateMixin and "BackdropTemplate")
		vAC_MiniAnima:SetBackdrop(Backdrop_A)
		vAC_MiniAnima:SetSize(170,85)
		vAC_MiniAnima:ClearAllPoints()
		vAC_MiniAnima:SetPoint("CENTER", UIParent, 0, 0)
		vAC_MiniAnima:EnableMouse(true)
		vAC_MiniAnima:SetMovable(true)
		vAC_MiniAnima:RegisterForDrag("LeftButton")
		vAC_MiniAnima:SetScript("OnDragStart", function() vAC_MiniAnima:StartMoving() end)
		vAC_MiniAnima:SetScript("OnDragStop", function() vAC_MiniAnima:StopMovingOrSizing() end)
		vAC_MiniAnima:SetClampedToScreen(true)
			vAC_MiniAnima.Text = vAC_MiniAnima:CreateFontString("T")
			vAC_MiniAnima.Text:SetFont(FontStyle[1], Font_Md, "OUTLINE")
			vAC_MiniAnima.Text:SetPoint("CENTER", vAC_MiniAnima, 0, 0)
			vAC_MiniAnima.Text:SetText("Anima Count: 0 (0)\n==========\nIn Reservoir: 0\nTil Cap: 0")
		vAC_MiniAnima:Hide()

------------------------------------------------------------------------
-- Fire Up Events
------------------------------------------------------------------------
	local vAC_OnUpdate = CreateFrame("Frame")
	vAC_OnUpdate:RegisterEvent("ADDON_LOADED")
	vAC_OnUpdate:SetScript("OnEvent", function(self, event, ...)
		if event == "ADDON_LOADED" then
			local TheEvents = {
				"PLAYER_MONEY",				-- Listen for Anima Amount Changes
				"CURRENCY_DISPLAY_UPDATE",	-- Currency Updater
				"BAG_UPDATE",				-- Fire when there new Anima in the BAG
			}
			for ev = 1, #TheEvents do
				vAC_OnUpdate:RegisterEvent(TheEvents[ev])
			end
			vAC_OnUpdate:UnregisterEvent("ADDON_LOADED")
			vAC_OnUpdate:RegisterEvent("PLAYER_LOGIN")
		end
		if event == "PLAYER_LOGIN" then
			DEFAULT_CHAT_FRAME:AddMessage("Loaded: "..vAC_AppTitle)
			
			if vAC_PlayerLevel <= 59 then
				vAC_MiniAnima:Hide()
			else
				vAC_MiniAnima:Show()
				Status = xpcall(AnimaCount(),err)
			end
			
			vAC_OnUpdate:UnregisterEvent("PLAYER_LOGIN")
		end
		if (event == "PLAYER_MONEY") or (event == "CURRENCY_DISPLAY_UPDATE") or (event == "BAG_UPDATE") then
			if vAC_MiniAnima:IsVisible() then Status = xpcall(AnimaCount(),err) end
		end
	end)
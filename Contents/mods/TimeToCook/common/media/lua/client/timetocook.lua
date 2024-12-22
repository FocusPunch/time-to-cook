require 'ISUI/ISInventoryPane'

timeToCook = {}

local OPTIONS;

local function setLocalSandboxVars()
    OPTIONS = SandboxVars.TimeToCook
    if OPTIONS == nil then
        OPTIONS.ttcRequireCookTrait = false
        OPTIONS.ttcRequireCookingLevel = false
        OPTIONS.ttcCookingLevelRequired = 3
    end
end

timeToCook.ISInventoryPaneDrawItemDetails = ISInventoryPane.drawItemDetails

function ISInventoryPane:drawItemDetails(item, y, xoff, yoff, red)
    timeToCook.ISInventoryPaneDrawItemDetails(self, item, y, xoff, yoff, red)
    if instanceof(item, "Food") then
        if(item:isCookable() and item:getCookingTime() < item:getMinutesToCook()) then
            local player = getSpecificPlayer(self.player)
            if(not OPTIONS.ttcRequireCookTrait or player:HasTrait("Cook") or player:HasTrait("Cook2")) then -- The Chef profession uses trait "Cook2" instead of just "Cook"... nice
                if(not OPTIONS.ttcRequireCookingLevel or (player:getPerkLevel(Perks.Cooking) >= OPTIONS.ttcCookingLevelRequired)) then
                    local top = self.headerHgt + y * self.itemHgt + yoff
                    local fgBar = {r=0.0, g=0.6, b=0.0, a=0.7}
                    local fgText = {r=0.6, g=0.8, b=0.5, a=0.6}
                    self:drawText(getText("IGUI_invpanel_Minutes_to_Cook") .. ": " .. (math.floor((item:getMinutesToCook()-item:getCookingTime() + 0.5)/2)), 40 + 30 + xoff + 200, top + (self.itemHgt - self.fontHgt) / 2, fgText.a, fgText.r, fgText.g, fgText.b, self.font);

                end
            end
        end
    end
end


Events.OnGameStart.Add(setLocalSandboxVars);

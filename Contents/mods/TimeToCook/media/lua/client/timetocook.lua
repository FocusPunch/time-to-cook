require 'ISUI/ISInventoryPane'

TimeToCookMod = {}

TimeToCookMod.ISInventoryPaneDrawItemDetails = ISInventoryPane.drawItemDetails

function ISInventoryPane:drawItemDetails(item, y, xoff, yoff, red)
    TimeToCookMod.ISInventoryPaneDrawItemDetails(self, item, y, xoff, yoff, red)
    if instanceof(item, "Food") then
        local top = self.headerHgt + y * self.itemHgt + yoff
        local fgBar = {r=0.0, g=0.6, b=0.0, a=0.7}
	    local fgText = {r=0.6, g=0.8, b=0.5, a=0.6}
        if(item:isCookable() and item:getCookingTime() < item:getMinutesToCook()) then
            self:drawText(getText("IGUI_invpanel_Minutes_to_Cook") .. ": " .. (item:getMinutesToCook()/2), 40 + 30 + xoff + 200, top + (self.itemHgt - self.fontHgt) / 2, fgText.a, fgText.r, fgText.g, fgText.b, self.font);

        end
    end
end


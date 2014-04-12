-- create object
local myObject = display.newRect( 0, 0, 100, 100 )
myObject:setFillColor( 255 )
 
-- touch listener function
function myObject:touch( event )
	if event.phase == "began" then
		
		-- set focus on this object - this fixes issues with fast-dragging
		display.getCurrentStage():setFocus( event.target )
	
		self.markX = self.x -- store x location of object
		self.markY = self.y -- store y location of object
	
	elseif event.phase == "moved" then
		
		local x = (event.x - event.xStart) + self.markX
		local y = (event.y - event.yStart) + self.markY
		self.x, self.y = x, y -- move object based on calculations above
		
		-- constrain the object inside the screen boundaries
		if self.x >= display.contentWidth - self.width/2 then
			self.x = display.contentWidth - self.width/2
		end
		if self.x <= display.screenOriginX + self.width/2 then
			self.x = display.screenOriginX + self.width/2
		end
		if self.y >= display.contentHeight - shield.height/2 then
			self.y = display.contentHeight - shield.height/2
		end
		if self.y <= display.screenOriginY + self.height/2 then
			self.y = display.screenOriginY + self.height/2
		end
		
	elseif event.phase == "ended" or event.phase == "cancelled" then
	
		-- remove focus from the object
		display.getCurrentStage():setFocus(nil)
	
	end
	return true
end
 
-- make 'myObject' listen for touch events
myObject:addEventListener( "touch", myObject )
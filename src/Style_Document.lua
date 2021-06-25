--[[
	tess
	File:/src/Style.lua
	Date:2021.06.25
	By MIT License.
	Copyright(C) 2021 tess developers.All rights reserved.
]]

local lineLength <const> = 80;

local string = require("string");

local ptsMethod = {};
local ptsMetaTable = {__index = ptsMethod};

local Style = function(output)
	local style  = {
			status = {
					native = false;
				 },
		       };
	style.output = output;
	return setmetatable(style,ptsMetaTable);
end

local cmdList = {};
cmdList.p	= function(self)
	self.output:space(8);
	return;
end

cmdList.ep	= function(self)
	self.output:nl();
	return;
end

cmdList.space	= function(self)
	self.output:space();
	return;
end

cmdList.code = function(self)
	self.output:native(true);
	self.status.native = true;
	return;
end

cmdList.ecode = function(self)
	self.output:native(false);
	self.status.native = false;
	return;
end

local native_print	= function(self,str)
	self.output:native(true);
	self.output:text(str);
	self.output:native(self.status.native);
	return;
end

cmdList.lrarr = function(self)
	native_print(self,"<==>");
	return;
end

cmdList.larr		= function(self)
	native_print(self,"<===");
	return;
end

cmdList.rarr		= function(self)
	native_print(self,"===>");
	return;
end

cmdList.line = function(self)
	self.output:nl();
	native_print(self,string.rep("=",lineLength));
	self.output:nl();
	return;
end

cmdList.strong	= function(self)
	self.output:strong(true);
	return;
end

cmdList.estrong = function(self)
	self.output:strong(false);
	return;
end

cmdList.em	= function(self)
	self.output:em(true);
	return;
end

cmdList.eem	= function(self)
	self.output:em(false);
	return;
end

--------------------------------------------------------

ptsMethod.cmd = function(self,cmd)
	cmdList[cmd](self);
	return;
end

ptsMethod.text = function(self,text)
	self.output:text(text);
	return;
end

ptsMethod.close= function(self)
	return;
end

return {
	Style = Style,
       };

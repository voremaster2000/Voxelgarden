-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

WATER_ALPHA = 160
WATER_VISC = 1
LAVA_VISC = 7
LIGHT_MAX = 14
COUSHION = -10 -- Falling damage gets reduced by 10 percent.

-- Define default max stack
local stack = minetest.setting_get("stack_max")
if not stack then
	stack = 90
end
minetest.nodedef_default.stack_max = stack
minetest.craftitemdef_default.stack_max = stack
minetest.nodedef_default.liquid_range = 4
minetest.tooldef_default.range = 4.0
-- Use tools right click to place nodes
minetest.tooldef_default.on_place = function(itemstack, user, pointed_thing)
	if not pointed_thing then return end
	local above = minetest.env:get_node(pointed_thing.above)
	local inv = user:get_inventory()
	local wield = inv:get_stack("main", user:get_wield_index()+1)
	local name = wield:get_name()
	if not minetest.registered_nodes[name] then return end
	if not above.buildable_to and above.name ~= "air" then return end
	inv:remove_item("main", name)
	minetest.place_node(pointed_thing.above, {name = name})
end

-- Set time to dawn on new game
minetest.register_on_newplayer(function(player)
	if minetest.get_gametime() < 5 then
		minetest.set_timeofday(0.22)
	end
end)

minetest.register_on_respawnplayer(function(player)
	if minetest.is_singleplayer() then
		minetest.set_timeofday(0.22)
	end
end)

-- Definitions made by this mod that other mods can use too
default = {}

-- Load files
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/craftitems.lua")
dofile(minetest.get_modpath("default").."/crafting.lua")
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/leafdecay.lua")
dofile(minetest.get_modpath("default").."/player.lua")
dofile(minetest.get_modpath("default").."/trees.lua")
dofile(minetest.get_modpath("default").."/aliases.lua")

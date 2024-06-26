/obj/item/stack/tile/iron
	name = "floor tile"
	singular_name = "floor tile"
	desc = "The ground you walk on."
	lefthand_file = 'modular_bluemoon/SmiLeY/icons/mob/inhands/items/tiles_lefthand.dmi'
	righthand_file = 'modular_bluemoon/SmiLeY/icons/mob/inhands/items/tiles_righthand.dmi'
	icon = 'modular_bluemoon/SmiLeY/icons/obj/tiles.dmi'
	icon_state = "tile"
	item_state = "tile"
	force = 6
	mats_per_unit = list(/datum/material/iron=500)
	throwforce = 10
	flags_1 = CONDUCT_1
	turf_type = /turf/open/floor/iron
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 70, WOUND = 0)
	resistance_flags = FIRE_PROOF
	matter_amount = 1
	cost = 125
	merge_type = /obj/item/stack/tile/iron
	tile_reskin_types = list(
		/obj/item/stack/tile/iron,
		/obj/item/stack/tile/iron/edge,
		/obj/item/stack/tile/iron/half,
		/obj/item/stack/tile/iron/corner,
		/obj/item/stack/tile/iron/large,
		/obj/item/stack/tile/iron/small,
		/obj/item/stack/tile/iron/diagonal,
		/obj/item/stack/tile/iron/herringbone,
		/obj/item/stack/tile/iron/textured,
		/obj/item/stack/tile/iron/textured_edge,
		/obj/item/stack/tile/iron/textured_half,
		/obj/item/stack/tile/iron/textured_corner,
		/obj/item/stack/tile/iron/textured_large,
		/obj/item/stack/tile/iron/dark,
		/obj/item/stack/tile/iron/dark/smooth_edge,
		/obj/item/stack/tile/iron/dark/smooth_half,
		/obj/item/stack/tile/iron/dark/smooth_corner,
		/obj/item/stack/tile/iron/dark/smooth_large,
		/obj/item/stack/tile/iron/dark/small,
		/obj/item/stack/tile/iron/dark/diagonal,
		/obj/item/stack/tile/iron/dark/herringbone,
		/obj/item/stack/tile/iron/dark_side,
		/obj/item/stack/tile/iron/dark_corner,
		/obj/item/stack/tile/iron/checker,
		/obj/item/stack/tile/iron/dark/textured,
		/obj/item/stack/tile/iron/dark/textured_edge,
		/obj/item/stack/tile/iron/dark/textured_half,
		/obj/item/stack/tile/iron/dark/textured_corner,
		/obj/item/stack/tile/iron/dark/textured_large,
		/obj/item/stack/tile/iron/white,
		/obj/item/stack/tile/iron/white/smooth_edge,
		/obj/item/stack/tile/iron/white/smooth_half,
		/obj/item/stack/tile/iron/white/smooth_corner,
		/obj/item/stack/tile/iron/white/smooth_large,
		/obj/item/stack/tile/iron/white/small,
		/obj/item/stack/tile/iron/white/diagonal,
		/obj/item/stack/tile/iron/white/herringbone,
		/obj/item/stack/tile/iron/white_side,
		/obj/item/stack/tile/iron/white_corner,
		/obj/item/stack/tile/iron/cafeteria,
		/obj/item/stack/tile/iron/white/textured,
		/obj/item/stack/tile/iron/white/textured_edge,
		/obj/item/stack/tile/iron/white/textured_half,
		/obj/item/stack/tile/iron/white/textured_corner,
		/obj/item/stack/tile/iron/white/textured_large,
		/obj/item/stack/tile/iron/recharge_floor,
		/obj/item/stack/tile/iron/smooth,
		/obj/item/stack/tile/iron/smooth_edge,
		/obj/item/stack/tile/iron/smooth_half,
		/obj/item/stack/tile/iron/smooth_corner,
		/obj/item/stack/tile/iron/smooth_large,
		/obj/item/stack/tile/iron/terracotta,
		/obj/item/stack/tile/iron/terracotta/small,
		/obj/item/stack/tile/iron/terracotta/diagonal,
		/obj/item/stack/tile/iron/terracotta/herringbone,
		/obj/item/stack/tile/iron/kitchen,
		/obj/item/stack/tile/iron/kitchen/small,
		/obj/item/stack/tile/iron/kitchen/diagonal,
		/obj/item/stack/tile/iron/kitchen/herringbone,
		/obj/item/stack/tile/iron/chapel,
		/obj/item/stack/tile/iron/showroomfloor,
		/obj/item/stack/tile/iron/solarpanel,
		/obj/item/stack/tile/iron/freezer,
		/obj/item/stack/tile/iron/grimy,
		/obj/item/stack/tile/iron/sepia,
	)

/obj/item/stack/tile/iron/two
	amount = 2

/obj/item/stack/tile/iron/four
	amount = 4

/obj/item/stack/tile/iron/Initialize(mapload, amount)
	. = ..()
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3) //randomize a little

/obj/item/stack/tile/iron/attackby(obj/item/W, mob/user, params)

	if(W.tool_behaviour == TOOL_WELDER)
		if(get_amount() < 4)
			to_chat(user, "<span class='warning'>You need at least four tiles to do this!</span>")
			return

		if(!mineralType)
			to_chat(user, "<span class='warning'>You can not reform this!</span>")
			return

		if(W.use_tool(src, user, 0, volume=40))
			if(mineralType == "plasma")
				atmos_spawn_air("plasma=5;TEMP=1000")
				user.visible_message("<span class='warning'>[user.name] sets the plasma tiles on fire!</span>", \
									"<span class='warning'>You set the plasma tiles on fire!</span>")
				qdel(src)
				return

			if (mineralType == "metal")
				var/obj/item/stack/sheet/metal/new_item = new(user.loc)
				user.visible_message("[user.name] shaped [src] into metal with the welding tool.", \
							 "<span class='notice'>You shaped [src] into metal with the welding tool.</span>", \
							 "<span class='italics'>You hear welding.</span>")
				var/obj/item/stack/rods/R = src
				src = null
				var/replace = (user.get_inactive_held_item()==R)
				R.use(4)
				if (!R && replace)
					user.put_in_hands(new_item)

			else
				var/sheet_type = text2path("/obj/item/stack/sheet/mineral/[mineralType]")
				var/obj/item/stack/sheet/mineral/new_item = new sheet_type(user.loc)
				user.visible_message("[user.name] shaped [src] into a sheet with the welding tool.", \
							"<span class='notice'>You shaped [src] into a sheet with the welding tool.</span>", \
							"<span class='italics'>You hear welding.</span>")
				var/obj/item/stack/rods/R = src
				src = null
				var/replace = (user.get_inactive_held_item()==R)
				R.use(4)
				if (!R && replace)
					user.put_in_hands(new_item)
	else
		return ..()

/obj/item/stack/tile/iron/base //this subtype should be used for most stuff
	merge_type = /obj/item/stack/tile/iron/base

/obj/item/stack/tile/iron/base/cyborg //cant reskin these, fucks with borg code
	merge_type = /obj/item/stack/tile/iron/base/cyborg
	tile_reskin_types = null

/obj/item/stack/tile/iron/edge
	name = "edge tile"
	singular_name = "edge floor tile"
	icon_state = "tile_edge"
	turf_type = /turf/open/floor/iron/edge
	merge_type = /obj/item/stack/tile/iron/edge

/obj/item/stack/tile/iron/half
	name = "half tile"
	singular_name = "half floor tile"
	icon_state = "tile_half"
	turf_type = /turf/open/floor/iron/half
	merge_type = /obj/item/stack/tile/iron/half

/obj/item/stack/tile/iron/corner
	name = "corner tile"
	singular_name = "corner floor tile"
	icon_state = "tile_corner"
	turf_type = /turf/open/floor/iron/corner
	merge_type = /obj/item/stack/tile/iron/corner

/obj/item/stack/tile/iron/large
	name = "large tile"
	singular_name = "large floor tile"
	icon_state = "tile_large"
	turf_type = /turf/open/floor/iron/large
	merge_type = /obj/item/stack/tile/iron/large

/obj/item/stack/tile/iron/textured
	name = "textured tile"
	singular_name = "textured floor tile"
	icon_state = "tile_textured"
	turf_type = /turf/open/floor/iron/textured
	merge_type = /obj/item/stack/tile/iron/textured

/obj/item/stack/tile/iron/textured_edge
	name = "textured edge tile"
	singular_name = "edged textured floor tile"
	icon_state = "tile_textured_edge"
	turf_type = /turf/open/floor/iron/textured_edge
	merge_type = /obj/item/stack/tile/iron/textured_edge

/obj/item/stack/tile/iron/textured_half
	name = "textured half tile"
	singular_name = "halved textured floor tile"
	icon_state = "tile_textured_half"
	turf_type = /turf/open/floor/iron/textured_half
	merge_type = /obj/item/stack/tile/iron/textured_half

/obj/item/stack/tile/iron/textured_corner
	name = "textured corner tile"
	singular_name = "cornered textured floor tile"
	icon_state = "tile_textured_corner"
	turf_type = /turf/open/floor/iron/textured_corner
	merge_type = /obj/item/stack/tile/iron/textured_corner

/obj/item/stack/tile/iron/textured_large
	name = "textured large tile"
	singular_name = "large textured floor tile"
	icon_state = "tile_textured_large"
	turf_type = /turf/open/floor/iron/textured_large
	merge_type = /obj/item/stack/tile/iron/textured_large

/obj/item/stack/tile/iron/small
	name = "small tile"
	singular_name = "small floor tile"
	icon_state = "tile_small"
	turf_type = /turf/open/floor/iron/small
	merge_type = /obj/item/stack/tile/iron/small

/obj/item/stack/tile/iron/diagonal
	name = "diagonal tile"
	singular_name = "diagonal floor tile"
	icon_state = "tile_diagonal"
	turf_type = /turf/open/floor/iron/diagonal
	merge_type = /obj/item/stack/tile/iron/diagonal

/obj/item/stack/tile/iron/herringbone
	name = "herringbone tile"
	singular_name = "herringbone floor tile"
	icon_state = "tile_herringbone"
	turf_type = /turf/open/floor/iron/herringbone
	merge_type = /obj/item/stack/tile/iron/herringbone

/obj/item/stack/tile/iron/dark
	name = "dark tile"
	singular_name = "dark floor tile"
	icon_state = "tile_dark"
	turf_type = /turf/open/floor/iron/dark
	merge_type = /obj/item/stack/tile/iron/dark

/obj/item/stack/tile/iron/dark/smooth_edge
	name = "dark edge tile"
	singular_name = "edged dark floor tile"
	icon_state = "tile_dark_edge"
	turf_type = /turf/open/floor/iron/dark/smooth_edge
	merge_type = /obj/item/stack/tile/iron/dark/smooth_edge

/obj/item/stack/tile/iron/dark/smooth_half
	name = "dark half tile"
	singular_name = "halved dark floor tile"
	icon_state = "tile_dark_half"
	turf_type = /turf/open/floor/iron/dark/smooth_half
	merge_type = /obj/item/stack/tile/iron/dark/smooth_half

/obj/item/stack/tile/iron/dark/smooth_corner
	name = "dark corner tile"
	singular_name = "cornered dark floor tile"
	icon_state = "tile_dark_corner"
	turf_type = /turf/open/floor/iron/dark/smooth_corner
	merge_type = /obj/item/stack/tile/iron/dark/smooth_corner

/obj/item/stack/tile/iron/dark/smooth_large
	name = "dark large tile"
	singular_name = "large dark floor tile"
	icon_state = "tile_dark_large"
	turf_type = /turf/open/floor/iron/dark/smooth_large
	merge_type = /obj/item/stack/tile/iron/dark/smooth_large

/obj/item/stack/tile/iron/dark_side
	name = "half dark tile"
	singular_name = "half dark floor tile"
	icon_state = "tile_darkside"
	turf_type = /turf/open/floor/iron/dark/side
	merge_type = /obj/item/stack/tile/iron/dark_side

/obj/item/stack/tile/iron/dark_corner
	name = "quarter dark tile"
	singular_name = "quarter dark floor tile"
	icon_state = "tile_darkcorner"
	turf_type = /turf/open/floor/iron/dark/corner
	merge_type = /obj/item/stack/tile/iron/dark_corner

/obj/item/stack/tile/iron/checker
	name = "checker tile"
	singular_name = "checker floor tile"
	icon_state = "tile_checker"
	turf_type = /turf/open/floor/iron/checker
	merge_type = /obj/item/stack/tile/iron/checker

/obj/item/stack/tile/iron/dark/textured
	name = "dark textured tile"
	singular_name = "dark textured floor tile"
	icon_state = "tile_textured_dark"
	turf_type = /turf/open/floor/iron/dark/textured
	merge_type = /obj/item/stack/tile/iron/dark/textured

/obj/item/stack/tile/iron/dark/textured_edge
	name = "dark textured edge tile"
	singular_name = "edged dark textured floor tile"
	icon_state = "tile_textured_dark_edge"
	turf_type = /turf/open/floor/iron/dark/textured_edge
	merge_type = /obj/item/stack/tile/iron/dark/textured_edge

/obj/item/stack/tile/iron/dark/textured_half
	name = "dark textured half tile"
	singular_name = "halved dark textured floor tile"
	icon_state = "tile_textured_dark_half"
	turf_type = /turf/open/floor/iron/dark/textured_half
	merge_type = /obj/item/stack/tile/iron/dark/textured_half

/obj/item/stack/tile/iron/dark/textured_corner
	name = "dark textured corner tile"
	singular_name = "cornered dark textured floor tile"
	icon_state = "tile_textured_dark_corner"
	turf_type = /turf/open/floor/iron/dark/textured_corner
	merge_type = /obj/item/stack/tile/iron/dark/textured_corner

/obj/item/stack/tile/iron/dark/textured_large
	name = "dark textured large tile"
	singular_name = "large dark textured floor tile"
	icon_state = "tile_textured_dark_large"
	turf_type = /turf/open/floor/iron/dark/textured_large
	merge_type = /obj/item/stack/tile/iron/dark/textured_large

/obj/item/stack/tile/iron/dark/small
	name = "dark small tile"
	singular_name = "dark small floor tile"
	icon_state = "tile_dark_small"
	turf_type = /turf/open/floor/iron/dark/small
	merge_type = /obj/item/stack/tile/iron/dark/small

/obj/item/stack/tile/iron/dark/diagonal
	name = "dark diagonal tile"
	singular_name = "dark diagonal floor tile"
	icon_state = "tile_dark_diagonal"
	turf_type = /turf/open/floor/iron/dark/diagonal
	merge_type = /obj/item/stack/tile/iron/dark/diagonal

/obj/item/stack/tile/iron/dark/herringbone
	name = "dark herringbone tile"
	singular_name = "dark herringbone floor tile"
	icon_state = "tile_dark_herringbone"
	turf_type = /turf/open/floor/iron/dark/herringbone
	merge_type = /obj/item/stack/tile/iron/dark/herringbone

/obj/item/stack/tile/iron/white
	name = "white tile"
	singular_name = "white floor tile"
	icon_state = "tile_white"
	turf_type = /turf/open/floor/iron/white
	merge_type = /obj/item/stack/tile/iron/white

/obj/item/stack/tile/iron/white/smooth_edge
	name = "white edge tile"
	singular_name = "edged white floor tile"
	icon_state = "tile_white_edge"
	turf_type = /turf/open/floor/iron/white/smooth_edge
	merge_type = /obj/item/stack/tile/iron/white/smooth_edge

/obj/item/stack/tile/iron/white/smooth_half
	name = "white half tile"
	singular_name = "halved white floor tile"
	icon_state = "tile_white_half"
	turf_type = /turf/open/floor/iron/white/smooth_half
	merge_type = /obj/item/stack/tile/iron/white/smooth_half

/obj/item/stack/tile/iron/white/smooth_corner
	name = "white corner tile"
	singular_name = "cornered white floor tile"
	icon_state = "tile_white_corner"
	turf_type = /turf/open/floor/iron/white/smooth_corner
	merge_type = /obj/item/stack/tile/iron/white/smooth_corner

/obj/item/stack/tile/iron/white/smooth_large
	name = "white large tile"
	singular_name = "large white floor tile"
	icon_state = "tile_white_large"
	turf_type = /turf/open/floor/iron/white/smooth_large
	merge_type = /obj/item/stack/tile/iron/white/smooth_large

/obj/item/stack/tile/iron/white_side
	name = "half white tile"
	singular_name = "half white floor tile"
	icon_state = "tile_whiteside"
	turf_type = /turf/open/floor/iron/white/side
	merge_type = /obj/item/stack/tile/iron/white_side

/obj/item/stack/tile/iron/white_corner
	name = "quarter white tile"
	singular_name = "quarter white floor tile"
	icon_state = "tile_whitecorner"
	turf_type = /turf/open/floor/iron/white/corner
	merge_type = /obj/item/stack/tile/iron/white_corner

/obj/item/stack/tile/iron/cafeteria
	name = "cafeteria tile"
	singular_name = "cafeteria floor tile"
	icon_state = "tile_cafeteria"
	turf_type = /turf/open/floor/iron/cafeteria
	merge_type = /obj/item/stack/tile/iron/cafeteria

/obj/item/stack/tile/iron/white/textured
	name = "white textured tile"
	singular_name = "white textured floor tile"
	icon_state = "tile_textured_white"
	turf_type = /turf/open/floor/iron/white/textured
	merge_type = /obj/item/stack/tile/iron/white/textured

/obj/item/stack/tile/iron/white/textured_edge
	name = "white textured edge tile"
	singular_name = "edged white textured floor tile"
	icon_state = "tile_textured_white_edge"
	turf_type = /turf/open/floor/iron/white/textured_edge
	merge_type = /obj/item/stack/tile/iron/white/textured_edge

/obj/item/stack/tile/iron/white/textured_half
	name = "white textured half tile"
	singular_name = "halved white textured floor tile"
	icon_state = "tile_textured_white_half"
	turf_type = /turf/open/floor/iron/white/textured_half
	merge_type = /obj/item/stack/tile/iron/white/textured_half

/obj/item/stack/tile/iron/white/textured_corner
	name = "white textured corner tile"
	singular_name = "cornered white textured floor tile"
	icon_state = "tile_textured_white_corner"
	turf_type = /turf/open/floor/iron/white/textured_corner
	merge_type = /obj/item/stack/tile/iron/white/textured_corner

/obj/item/stack/tile/iron/white/textured_large
	name = "white textured large tile"
	singular_name = "large white textured floor tile"
	icon_state = "tile_textured_white_large"
	turf_type = /turf/open/floor/iron/white/textured_large
	merge_type = /obj/item/stack/tile/iron/white/textured_large

/obj/item/stack/tile/iron/white/small
	name = "white small tile"
	singular_name = "white small floor tile"
	icon_state = "tile_white_small"
	turf_type = /turf/open/floor/iron/white/small
	merge_type = /obj/item/stack/tile/iron/white/small

/obj/item/stack/tile/iron/white/diagonal
	name = "white diagonal tile"
	singular_name = "white diagonal floor tile"
	icon_state = "tile_white_diagonal"
	turf_type = /turf/open/floor/iron/white/diagonal
	merge_type = /obj/item/stack/tile/iron/white/diagonal

/obj/item/stack/tile/iron/white/herringbone
	name = "white herringbone tile"
	singular_name = "white herringbone floor tile"
	icon_state = "tile_white_herringbone"
	turf_type = /turf/open/floor/iron/white/herringbone
	merge_type = /obj/item/stack/tile/iron/white/herringbone

/obj/item/stack/tile/iron/recharge_floor
	name = "recharge floor tile"
	singular_name = "recharge floor tile"
	icon_state = "tile_recharge"
	turf_type = /turf/open/floor/iron/recharge_floor
	merge_type = /obj/item/stack/tile/iron/recharge_floor

/obj/item/stack/tile/iron/smooth
	name = "smooth tile"
	singular_name = "smooth floor tile"
	icon_state = "tile_smooth"
	turf_type = /turf/open/floor/iron/smooth
	merge_type = /obj/item/stack/tile/iron/smooth

/obj/item/stack/tile/iron/smooth_edge
	name = "smooth edge tile"
	singular_name = "edged smooth floor tile"
	icon_state = "tile_smooth_edge"
	turf_type = /turf/open/floor/iron/smooth_edge
	merge_type = /obj/item/stack/tile/iron/smooth_edge

/obj/item/stack/tile/iron/smooth_half
	name = "smooth half tile"
	singular_name = "halved smooth floor tile"
	icon_state = "tile_smooth_half"
	turf_type = /turf/open/floor/iron/smooth_half
	merge_type = /obj/item/stack/tile/iron/smooth_half

/obj/item/stack/tile/iron/smooth_corner
	name = "smooth corner tile"
	singular_name = "cornered smooth floor tile"
	icon_state = "tile_smooth_corner"
	turf_type = /turf/open/floor/iron/smooth_corner
	merge_type = /obj/item/stack/tile/iron/smooth_corner

/obj/item/stack/tile/iron/smooth_large
	name = "smooth large tile"
	singular_name = "large smooth floor tile"
	icon_state = "tile_smooth_large"
	turf_type = /turf/open/floor/iron/smooth_large
	merge_type = /obj/item/stack/tile/iron/smooth_large

/obj/item/stack/tile/iron/terracotta
	name = "terracotta floor tile"
	singular_name = "terracotta floor tile"
	icon_state = "tile_terracotta"
	turf_type = /turf/open/floor/iron/terracotta
	merge_type = /obj/item/stack/tile/iron/terracotta

/obj/item/stack/tile/iron/terracotta/small
	name = "terracotta small tile"
	singular_name = "terracotta small floor tile"
	icon_state = "tile_terracotta_small"
	turf_type = /turf/open/floor/iron/terracotta/small
	merge_type = /obj/item/stack/tile/iron/terracotta/small

/obj/item/stack/tile/iron/terracotta/diagonal
	name = "terracotta diagonal tile"
	singular_name = "terracotta diagonal floor tile"
	icon_state = "tile_terracotta_diagonal"
	turf_type = /turf/open/floor/iron/terracotta/diagonal
	merge_type = /obj/item/stack/tile/iron/terracotta/diagonal

/obj/item/stack/tile/iron/terracotta/herringbone
	name = "terracotta herringbone tile"
	singular_name = "terracotta herringbone floor tile"
	icon_state = "tile_terracotta_herringbone"
	turf_type = /turf/open/floor/iron/terracotta/herringbone
	merge_type = /obj/item/stack/tile/iron/terracotta/herringbone

/obj/item/stack/tile/iron/kitchen
	name = "kitchen tile"
	singular_name = "kitchen tile"
	icon_state = "tile_kitchen"
	turf_type = /turf/open/floor/iron/kitchen
	merge_type = /obj/item/stack/tile/iron/kitchen

/obj/item/stack/tile/iron/kitchen/small
	name = "small kitchen tile"
	singular_name = "small kitchen floor tile"
	icon_state = "tile_kitchen_small"
	turf_type = /turf/open/floor/iron/kitchen/small
	merge_type = /obj/item/stack/tile/iron/kitchen/small

/obj/item/stack/tile/iron/kitchen/diagonal
	name = "diagonal kitchen tile"
	singular_name = "diagonal kitchen floor tile"
	icon_state = "tile_kitchen_diagonal"
	turf_type = /turf/open/floor/iron/kitchen/diagonal
	merge_type = /obj/item/stack/tile/iron/kitchen/diagonal

/obj/item/stack/tile/iron/kitchen/herringbone
	name = "herringbone kitchen tile"
	singular_name = "herringbone kitchen floor tile"
	icon_state = "tile_kitchen_herringbone"
	turf_type = /turf/open/floor/iron/kitchen/herringbone
	merge_type = /obj/item/stack/tile/iron/kitchen/herringbone

/obj/item/stack/tile/iron/chapel
	name = "chapel floor tile"
	singular_name = "chapel floor tile"
	icon_state = "tile_chapel"
	turf_type = /turf/open/floor/iron/chapel
	merge_type = /obj/item/stack/tile/iron/chapel

/obj/item/stack/tile/iron/showroomfloor
	name = "showroom floor tile"
	singular_name = "showroom floor tile"
	icon_state = "tile_showroom"
	turf_type = /turf/open/floor/iron/showroomfloor
	merge_type = /obj/item/stack/tile/iron/showroomfloor

/obj/item/stack/tile/iron/solarpanel
	name = "solar panel tile"
	singular_name = "solar panel floor tile"
	icon_state = "tile_solarpanel"
	turf_type = /turf/open/floor/iron/solarpanel
	merge_type = /obj/item/stack/tile/iron/solarpanel

/obj/item/stack/tile/iron/freezer
	name = "freezer floor tile"
	singular_name = "freezer floor tile"
	icon_state = "tile_freezer"
	turf_type = /turf/open/floor/iron/freezer
	merge_type = /obj/item/stack/tile/iron/freezer

/obj/item/stack/tile/iron/grimy
	name = "grimy floor tile"
	singular_name = "grimy floor tile"
	icon_state = "tile_grimy"
	turf_type = /turf/open/floor/iron/grimy
	merge_type = /obj/item/stack/tile/iron/grimy

/obj/item/stack/tile/iron/sepia
	name = "sepia floor tile"
	singular_name = "sepia floor tile"
	desc = "Well, the flow of time is normal on these tiles, weird."
	icon_state = "tile_sepia"
	turf_type = /turf/open/floor/iron/sepia
	merge_type = /obj/item/stack/tile/iron/sepia

//Tiles below can't be gotten through tile reskinning

/obj/item/stack/tile/iron/bluespace
	name = "bluespace floor tile"
	singular_name = "bluespace floor tile"
	desc = "Sadly, these don't seem to make you faster..."
	icon_state = "tile_bluespace"
	turf_type = /turf/open/floor/iron/bluespace
	merge_type = /obj/item/stack/tile/iron/bluespace
	tile_reskin_types = null

/obj/item/stack/tile/iron/goonplaque
	name = "plaqued floor tile"
	singular_name = "plaqued floor tile"
	desc = "\"This is a plaque in honour of our comrades on the G4407 Stations. Hopefully TG4407 model can live up to your fame and fortune.\" Scratched in beneath that is a crude image of a meteor and a spaceman. The spaceman is laughing. The meteor is exploding."
	icon_state = "tile_plaque"
	turf_type = /turf/open/floor/iron/goonplaque
	merge_type = /obj/item/stack/tile/iron/goonplaque
	tile_reskin_types = null

/obj/item/stack/tile/iron/vaporwave
	name = "vaporwave floor tile"
	singular_name = "vaporwave floor tile"
	icon_state = "tile_vaporwave"
	turf_type = /turf/open/floor/iron/vaporwave
	merge_type = /obj/item/stack/tile/iron/vaporwave
	tile_reskin_types = null

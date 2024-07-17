//Solar tracker

//Machine that tracks the sun and reports its direction to the solar controllers
//As long as this is working, solar panels on same powernet will track automatically

/obj/machinery/power/tracker
	name = "solar tracker"
	desc = "A solar directional tracker."
	icon = 'goon/icons/obj/power.dmi'
	icon_state = "tracker"
	density = TRUE
	use_power = NO_POWER_USE
	max_integrity = 250
	integrity_failure = 0.2

	var/id = 0
	var/obj/machinery/power/solar_control/control
	var/obj/item/solar_assembly/assembly

/obj/machinery/power/tracker/Initialize(mapload, obj/item/solar_assembly/S)
	. = ..()
	Make(S)
	connect_to_network()
	RegisterSignal(SSsun, COMSIG_SUN_MOVED, PROC_REF(sun_update))

/obj/machinery/power/tracker/Destroy()
	unset_control() //remove from control computer
	return ..()

/obj/machinery/power/tracker/proc/set_control(obj/machinery/power/solar_control/SC)
	unset_control()
	control = SC
	SC.connected_tracker = src

//set the control of the tracker to null and removes it from the previous control computer if needed
/obj/machinery/power/tracker/proc/unset_control()
	if(control)
		if(control.track == SOLAR_TRACK_AUTO)
			control.track = SOLAR_TRACK_OFF
		control.connected_tracker = null
		control = null

///Tell the controller to turn the solar panels
/obj/machinery/power/tracker/proc/sun_update(datum/source, datum/sun/primary_sun, list/datum/sun/suns)
	setDir(angle2dir(primary_sun.azimuth))
	if(control && control.track == SOLAR_TRACK_AUTO)
		control.set_panels(primary_sun.azimuth)

/obj/machinery/power/tracker/proc/Make(obj/item/solar_assembly/S)
	if(!S)
		assembly = new /obj/item/solar_assembly
		assembly.glass_type = new /obj/item/stack/sheet/glass(null, 2)
		assembly.tracker = TRUE
		assembly.anchored = TRUE
	else
		S.moveToNullspace()
		assembly = S
	update_icon()

/obj/machinery/power/tracker/crowbar_act(mob/user, obj/item/I)
	playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
	user.visible_message("<span class='notice'>[user] begins to take the glass off [src].</span>", "<span class='notice'>You begin to take the glass off [src]...</span>")
	if(I.use_tool(src, user, 50))
		playsound(src.loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		user.visible_message("<span class='notice'>[user] takes the glass off [src].</span>", "<span class='notice'>You take the glass off [src].</span>")
		deconstruct(TRUE)
	return TRUE

/obj/machinery/power/tracker/obj_break(damage_flag)
	if(!(stat & BROKEN) && !(flags_1 & NODECONSTRUCT_1))
		playsound(loc, 'sound/effects/glassbr3.ogg', 100, TRUE)
		unset_control()

/obj/machinery/power/tracker/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(disassembled)
			if(assembly)
				assembly.forceMove(loc)
				assembly.give_glass(stat & BROKEN)
		else
			playsound(src, "shatter", 70, TRUE)
			var/shard = assembly?.glass_type ? assembly.glass_type.shard_type : /obj/item/shard
			new shard(loc)
			new shard(loc)
	qdel(src)

// Tracker Electronic

/obj/item/electronics/tracker
	name = "tracker electronics"

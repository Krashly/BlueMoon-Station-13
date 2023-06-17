//ДЕЛАЮ ШАТТЛ НА МЕГАПОХУЙ

/area/shuttle/inteq
	name = "InteQ Shuttle"

/datum/map_template/shuttle/inteq_collosus
	prefix = "_maps/shuttles/bluemoon/"
	suffix = "inteq_collosus"
	name = "Collosus Shuttle"

/obj/machinery/computer/shuttle/inteq_collosus
	name = "Collosus Control"
	desc = "Used to control the Collosus."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = LIGHT_COLOR_ORANGE
	circuit = /obj/item/circuitboard/computer/inteq_collosus
	shuttleId = "inteq_collosus"
	possible_destinations = "inteq_collosus_custom"

/obj/item/circuitboard/computer/inteq_collosus
	name = "Collosus Control Console (Computer Board)"
	build_path = /obj/machinery/computer/shuttle/inteq_collosus

/obj/machinery/computer/camera_advanced/shuttle_docker/inteq_collosus
	name = "Collosus Navigation Computer"
	desc = "The Navigation console for the Collosus."
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	shuttleId = "inteq_collosus"
	lock_override = NONE
	shuttlePortId = "inteq_collosus_custom"
	jumpto_ports = list("whiteship_away" = 1, "whiteship_home" = 1)
	view_range = 14
	x_offset = -7
	y_offset = -7

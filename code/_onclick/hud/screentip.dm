/atom/movable/screen/screentip
	icon = null
	icon_state = null
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	screen_loc = "TOP,LEFT"
	maptext_height = 480
	maptext_width = 480
	maptext = ""

/atom/movable/screen/screentip/Initialize(mapload, _hud)
	. = ..()
	hud = _hud
	update_view()

/atom/movable/screen/screentip/proc/update_view(datum/source)
	SIGNAL_HANDLER
	if(!hud || !hud.mymob.client.view_size) //Might not have been initialized by now
		return
	maptext_width = getviewsize(hud.mymob.client.view_size.getView())[1] * world.icon_size

/// Context applied to LMB actions
#define SCREENTIP_CONTEXT_LMB "LMB"

/// Context applied to RMB actions
#define SCREENTIP_CONTEXT_RMB "RMB"

/// Context applied to Shift-LMB actions
#define SCREENTIP_CONTEXT_SHIFT_LMB "Shift-LMB"

/// Context applied to Ctrl-LMB actions
#define SCREENTIP_CONTEXT_CTRL_LMB "Ctrl-LMB"

/// Context applied to Ctrl-RMB actions
#define SCREENTIP_CONTEXT_CTRL_RMB "Ctrl-RMB"

/// Context applied to Alt-LMB actions
#define SCREENTIP_CONTEXT_ALT_LMB "Alt-LMB"

/// Context applied to Alt-RMB actions
#define SCREENTIP_CONTEXT_ALT_RMB "Alt-RMB"

/// Context applied to Ctrl-Shift-LMB actions
#define SCREENTIP_CONTEXT_CTRL_SHIFT_LMB "Ctrl-Shift-LMB"

/// Screentips are always disabled
#define SCREENTIP_PREFERENCE_DISABLED "Disabled"

/// Screentips are always enabled
#define SCREENTIP_PREFERENCE_ENABLED "Enabled"

/// Screentips are only enabled when they have context
#define SCREENTIP_PREFERENCE_CONTEXT_ONLY "Only with tips"

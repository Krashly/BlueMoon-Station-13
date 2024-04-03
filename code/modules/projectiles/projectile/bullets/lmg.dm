// C3D (Borgs)

/obj/item/projectile/bullet/c3d
	damage = 30

// Mech LMG

/obj/item/projectile/bullet/lmg
	damage = 20

// Mech FNX-99

/obj/item/projectile/bullet/incendiary/fnx99
	damage = 20

// Turrets

/obj/item/projectile/bullet/manned_turret
	damage = 20

/obj/item/projectile/bullet/syndicate_turret
	damage = 30

// 7.12x82mm (SAW)

/obj/item/projectile/bullet/mm712x82
	name = "7.12x82mm bullet"
	damage = 40
	armour_penetration = 5
	wound_bonus = -50
	wound_falloff_tile = 0

/obj/item/projectile/bullet/mm712x82_ap
	name = "7.12x82mm armor-piercing bullet"
	damage = 35
	armour_penetration = 40

/obj/item/projectile/bullet/mm712x82_hp
	name = "7.12x82mm hollow-point bullet"
	damage = 50
	armour_penetration = -60
	sharpness = SHARP_EDGED
	wound_bonus = -40
	bare_wound_bonus = 30
	wound_falloff_tile = -8

/obj/item/projectile/bullet/incendiary/mm712x82
	name = "7.12x82mm incendiary bullet"
	damage = 30
	fire_stacks = 3

/obj/item/projectile/bullet/mm712x82/match
	name = "7.12x82mm match bullet"
	damage = 40
	ricochets_max = 2
	ricochet_chance = 60
	ricochet_auto_aim_range = 4
	ricochet_incidence_leeway = 35
	wound_bonus = -50

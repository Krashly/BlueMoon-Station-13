/obj/machinery/vending/inteq_vendomat
	name = "\improper InteDrobe"
	desc = "Spend your hard earned credits!"
	icon = 'modular_bluemoon/krashly/icons/obj/structures.dmi'
	icon_state = "intedrobe"
	product_ads = "Почти не пачкается кровью!; Потрать свои тяжело заработанные кредиты!; Новые поставки от наших клиентов!"
	vend_reply = "Удачных контрактов, наёмник!"
	req_access = list(ACCESS_MEDICAL)
	products = list(
		/obj/item/clothing/under/inteq = 3,
		/obj/item/clothing/under/inteq_skirt = 3,
		/obj/item/clothing/under/inteq_eng = 3,
		/obj/item/clothing/under/inteq_eng_skirt = 3,
		/obj/item/clothing/under/inteq_med = 3,
		/obj/item/clothing/under/inteq_med_skirt = 3, //////////////////////////////
		/obj/item/clothing/under/inteq_maid = 3,
		/obj/item/clothing/gloves/combat/maid/inteq = 3,
		/obj/item/clothing/head/maidheadband/syndicate/inteq = 3, //////////////////
		/obj/item/clothing/head/helmet/swat/inteq = 3,
		/obj/item/clothing/suit/armor/inteq = 3,
		/obj/item/clothing/shoes/combat = 3,
		/obj/item/clothing/mask/balaclava/breath/inteq = 3,
		/obj/item/clothing/mask/gas/sechailer = 3,
		/obj/item/clothing/suit/hooded/wintercoat/syndicate/inteq = 3,
		/obj/item/clothing/suit/armor/inteq/labcoat = 3,
		/obj/item/clothing/head/soft/inteq = 3,
		/obj/item/clothing/head/soft/inteq_med = 3,
	)
	contraband = list(
		/obj/item/kitchen/knife/combat = 4,
		/obj/item/clothing/glasses/hud/security/sunglasses/inteq = 2,
		/obj/item/clothing/shoes/combat/coldres = 2,
	)
	premium = list(
		/obj/item/lighter = 5,
		/obj/item/clothing/gloves/combat = 3,
		/obj/item/clothing/head/HoS/inteq_vanguard = 2,
		/obj/item/clothing/suit/armor/inteq/vanguard = 2,
	)
	refill_canister = /obj/item/vending_refill/inteq_vendomat
	light_color = COLOR_DARK_ORANGE

/obj/item/vending_refill/inteq_vendomat
	machine_name = "InteDrobe"

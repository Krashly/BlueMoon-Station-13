// HYPERSTATION TRAITS

/datum/quirk/choke_slut
	name = "Choke Slut"
	desc = "You are aroused by suffocation."
	value = 0
	mob_trait = TRAIT_CHOKE_SLUT
	gain_text = "<span class='notice'>You feel like you want to feel fingers around your neck, choking you until you pass out or make a mess... Maybe both.</span>"
	lose_text = "<span class='notice'>Seems you don't have a kink for suffocation anymore.</span>"

/datum/quirk/pharmacokinesis //Supposed to prevent unwanted organ additions. But i don't think it's really working rn
	name = "Acute hepatic pharmacokinesis" //copypasting dumbo
	desc = "You have a rare genetic disorder that causes Incubus draft and Succubus milk to be absorbed by your liver instead."
	value = 0
	mob_trait = TRAIT_PHARMA
	lose_text = "<span class='notice'>Your liver feels different.</span>"
	var/active = FALSE
	var/power = 0
	var/cachedmoveCalc = 1

/datum/quirk/steel_ass
	name = "Buns of Steel"
	desc = "You've never skipped ass day. You are completely immune to all forms of ass slapping and anyone who tries to slap your rock hard ass usually gets a broken hand."
	value = 0
	mob_trait = TRAIT_STEEL_ASS
	gain_text = "<span class='notice'>Your ass rivals those of golems.</span>"
	lose_text = "<span class='notice'>Your butt feels more squishy and slappable.</span>"

/datum/quirk/cursed_blood
	name = "Cursed Blood"
	desc = "Your lineage is cursed with the paleblood curse. Best to stay away from holy water... Hell water, on the other hand..."
	value = 0
	mob_trait = TRAIT_CURSED_BLOOD
	gain_text = "<span class='notice'>A curse from a land where men return as beasts runs deep in your blood.</span>"
	lose_text = "<span class='notice'>You feel the weight of the curse in your blood finally gone.</span>"
	medical_record_text = "Patient suffers from an unknown type of aversion to holy reagents. Keep them away from a chaplain."

/datum/quirk/headpat_hater
	name = "Distant"
	desc = "You don't seem to show much care for being touched. Whether it's because you're reserved or due to self control, you won't wag your tail outside of your own control should you possess one."
	mob_trait = TRAIT_DISTANT
	value = 0
	medical_record_text = "Patient cares little with or dislikes being touched."

/datum/quirk/headpat_slut
	name = "Headpat Slut"
	desc = "You like headpats, alot, maybe even a little bit too much. Headpats give you a bigger mood boost and cause arousal"
	mob_trait = TRAIT_HEADPAT_SLUT
	value = 0
	medical_record_text = "Patient seems overly affectionate."

/datum/quirk/headpat_slut/add()
	. = ..()
	quirk_holder.AddElement(/datum/element/wuv/headpat, null, null, /datum/mood_event/pet_animal)

/datum/quirk/headpat_slut/remove()
	. = ..()
	quirk_holder.RemoveElement(/datum/element/wuv/headpat)

/datum/quirk/in_heat
	name = "In Heat"
	desc = "Your system burns with the desire to be bred. Satisfying your lust will make you happy, but ignoring it may cause you to become sad and needy."
	value = 0
	mob_trait = TRAIT_IN_HEAT
	gain_text = "<span class='notice'>You body burns with the desire to be bred.</span>"
	lose_text = "<span class='notice'>You feel more in control of your body and thoughts.</span>"

/datum/quirk/Hypnotic_gaze
	name = "Hypnotic Gaze"
	desc = "Be it through mysterious patterns, flickering colors or a glint of the eye, prolonged eye contact with others will place the Target into a highly suggestible Hypnotic trance."
	value = 0
	mob_trait = TRAIT_HYPNOTIC_GAZE
	gain_text = "<span class='notice'>Your eyes glimmer Hypnotically..</span>"
	lose_text = "<span class='notice'>Your eyes return to normal.</span>"
	medical_record_text = "Prolonged exposure to Patient's eyes exhibits soporific effects."

/datum/quirk/Hypnotic_gaze/on_spawn()
	var/mob/living/carbon/human/Hypno_eyes = quirk_holder
	var/datum/action/innate/Hypnotize/spell = new
	spell.Grant(Hypno_eyes)
	spell.owner = Hypno_eyes

/datum/action/innate/Hypnotize
	name = "Hypnotize"
	desc = "Stare deeply into someone's eyes, drawing them into a hypnotic slumber."
	button_icon_state = "Hypno_eye"
	icon_icon = 'modular_splurt/icons/mob/actions/lewd_actions/lewd_icons.dmi'
	background_icon_state = "bg_alien"
	var/mob/living/carbon/T //hypnosis target
	var/mob/living/carbon/human/H //Person with the quirk

/datum/action/innate/Hypnotize/Activate()
	var/mob/living/carbon/human/H = owner

	if(!H.pulling || !isliving(H.pulling) || H.grab_state < GRAB_AGGRESSIVE)
		to_chat(H, "<span class='warning'>You need to aggressively grab someone to hypnotize them!</span>")
		return

	var/mob/living/carbon/T = H.pulling

	if(T.IsSleeping())
		to_chat(H, "You can't hypnotize [T] whilst they're asleep!")
		return

	to_chat(H, "<span class='notice'>You stare deeply into [T]'s eyes...</span>")
	to_chat(T, "<span class='warning'>[H] stares Intensely into your eyes...</span>")
	if(!do_mob(H, T, 12 SECONDS))
		return

	if(H.pulling !=T || H.grab_state < GRAB_AGGRESSIVE)
		return

	if(!(H in view(1, H.loc)))
		return

	if(!(T.client?.prefs.cit_toggles & HYPNO))
		return

	var/response = alert(T, "Do you wish to fall into a hypnotic sleep?(This will allow [H] to issue hypnotic suggestions)", "Hypnosis", "Yes", "No")

	if(response == "Yes")
		T.visible_message("<span class='warning>[T] falls into a deep slumber!</span>", "<span class = 'danger'>Your eyelids gently shut as you fall into a deep slumber. All you can hear is [H]'s voice as you commit to following all of their suggestions</span>")

		T.SetSleeping(1200)
		T.drowsyness = max(T.drowsyness, 40)
		T = H.pulling
		var/response2 = alert(H, "Would you like to release your subject or give them a suggestion?", "Hypnosis", "Suggestion", "Release")

		if(response2 == "Suggestion")
			if(get_dist(H, T) > 1)
				to_chat(H, "You must stand in whisper range of [T].")
				return

			var/text = input("What would you like to suggest?", "Hypnotic suggestion", null, null)
			text = sanitize(text)
			if(!text)
				return

			to_chat(H, "You whisper your suggestion in a smooth calming voice to [T]")
			to_chat(T, "<span class='hypnophrase'>...[text]...</span>")

			T.visible_message("<span class='warning'>[T] wakes up from their deep slumber!</span>", "<span class ='danger'>Your eyelids gently open as you see [H]'s face staring back at you</span>")
			T.SetSleeping(0)
			T = null
			return

		if(response2 == "Release")
			T.SetSleeping(0)
			return
	else
		T.visible_message("<span class='warning'>[T]'s attention breaks, despite the attempt to hypnotize them! They clearly don't want this</span>", "<span class ='warning'>Your concentration breaks as you realise you have no interest in following [H]'s words!</span>")
		return
/datum/quirk/heat
	name = "Estrus Detection"
	desc = "You have a animalistic sense of detecting if someone is in heat."
	value = 0
	mob_trait = TRAIT_HEAT_DETECT
	gain_text = "<span class='notice'>You feel your senses adjust, allowing a animalistic sense of others' fertility.</span>"
	lose_text = "<span class='notice'>You feel your sense of others' fertility fade.</span>"

/datum/quirk/overweight
	name = "Overweight"
	desc = "You're particularly fond of food, and join the round being overweight."
	value = 0
	gain_text = "<span class='notice'>You feel a bit chubby!</span>"
	//no lose_text cause why would there be?

/datum/quirk/overweight/on_spawn()
	var/mob/living/M = quirk_holder
	M.nutrition = rand(NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MIN, NUTRITION_LEVEL_FAT + NUTRITION_LEVEL_START_MAX)
	M.overeatduration = 100
	ADD_TRAIT(M, TRAIT_FAT, OBESITY)

/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "You find the idea of eating meat morally and physically repulsive."
	value = 0
	gain_text = "<span class='notice'>You feel repulsion at the idea of eating meat.</span>"
	lose_text = "<span class='notice'>You feel like eating meat isn't that bad.</span>"
	medical_record_text = "Patient reports a vegetarian diet."

/datum/quirk/vegetarian/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food &= ~MEAT
	species.disliked_food |= MEAT

/datum/quirk/vegetarian/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		if(initial(species.liked_food) & MEAT)
			species.liked_food |= MEAT
		if(initial(species.disliked_food) & ~MEAT)
			species.disliked_food &= ~MEAT

/datum/quirk/cum_plus
	name = "Extra productive genitals"
	desc = "Your lower bits produce more and hold more than normal."
	value = 0
	gain_text = "<span class='notice'>You feel pressure in your groin.</span>"
	lose_text = "<span class='notice'>You feel a weight lifted from your groin.</span>"
	medical_record_text = "Patient has greatly increased production of sexual fluids."

/datum/quirk/cum_plus/add()
	var/mob/living/carbon/M = quirk_holder
	if(M.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		T.fluid_mult = 1.5 //Base is 1
		T.fluid_max_volume = 5

/datum/quirk/cum_plus/remove()
	var/mob/living/carbon/M = quirk_holder
	if(!M)
		return
	if(quirk_holder.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		T.fluid_mult = 1 //Base is 1
		T.fluid_max_volume = 3 //Base is 3

/datum/quirk/cum_plus/on_process()
	var/mob/living/carbon/M = quirk_holder //If you get balls later, then this will still proc
	if(M.getorganslot("testicles"))
		var/obj/item/organ/genital/testicles/T = M.getorganslot("testicles")
		if(T.fluid_max_volume <= 5 || T.fluid_mult <= 0.2) //INVALID EXPRESSION?
			T.fluid_mult = 1.5 //Base is 0.133
			T.fluid_max_volume = 5

//well-trained moved to neutral to stop the awkward situation of a dom snapping and the 30 trait powergamers fall to the floor.
/datum/quirk/well_trained
	name = "Well-trained"
	desc = "You absolutely love being dominated. The thought of someone with a stronger character than yours is enough to make you act up."
	value = 0
	gain_text = "<span class='notice'>You feel like being someone's pet</span>"
	lose_text = "<span class='notice'>You no longer feel like being a pet...</span>"
	processing_quirk = TRUE
	var/mood_category = "dom_trained"
	var/notice_delay = 0
	var/mob/living/carbon/human/last_dom

/datum/quirk/well_trained/add()
	. = ..()
	RegisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE, .proc/on_examine_holder)

/datum/quirk/well_trained/remove()
	. = ..()
	UnregisterSignal(quirk_holder, COMSIG_PARENT_EXAMINE)

/datum/quirk/well_trained/proc/on_examine_holder(atom/source, mob/living/user, list/examine_list)
	SIGNAL_HANDLER

	if(!istype(user))
		return
	if(!user.has_quirk(/datum/quirk/dominant_aura))
		return
	examine_list += span_lewd("You can sense submissiveness irradiating from [quirk_holder.p_them()]")

/datum/quirk/well_trained/on_process()
	. = ..()
	if(!quirk_holder)
		return

	var/good_x = "pet"
	switch(quirk_holder.gender)
		if(MALE)
			good_x = "boy"
		if(FEMALE)
			good_x = "girl"

	//Check for possible doms with the dominant_aura quirk, and for the closest one if there is
	. = FALSE
	var/list/mob/living/carbon/human/doms = range(DOMINANT_DETECT_RANGE, quirk_holder)
	var/closest_distance
	for(var/mob/living/carbon/human/dom in doms)
		if(dom != quirk_holder && dom.has_quirk(/datum/quirk/dominant_aura))
			if(!closest_distance || get_dist(quirk_holder, dom) <= closest_distance)
				. = dom
				closest_distance = get_dist(quirk_holder, dom)

	//Return if no dom is found
	if(!.)
		last_dom = null
		return

	//Handle the mood
	var/datum/component/mood/mood = quirk_holder.GetComponent(/datum/component/mood)
	if(istype(mood.mood_events[mood_category], /datum/mood_event/dominant/good_boy))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/dominant/good_boy)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/dominant/need)

	//Don't do anything if a previous dom was found
	if(last_dom)
		notice_delay = world.time + 15 SECONDS
		return

	last_dom = .

	if(notice_delay > world.time)
		return

	//Let them know they're near
	var/list/notices = list(
		"You feel someone's presence making you more submissive.",
		"The thought of being commanded floods you with lust.",
		"You really want to be called a good [good_x].",
		"Someone's presence is making you all flustered.",
		"You start getting excited and sweating."
	)

	to_chat(quirk_holder, span_lewd(pick(notices)))
	notice_delay = world.time + 15 SECONDS


//hydra code below

/datum/quirk/hydra
	name = "Hydra Heads"
	desc = "You are a tri-headed creature. To use, format name like (Rucks-Sucks-Ducks)"
	value = 0
	mob_trait = TRAIT_HYDRA_HEADS
	gain_text = "<span class='notice'>You hear two other voices inside of your head(s).</span>"
	lose_text = "<span class='danger'>All of your minds become singular.</span>"
	medical_record_text = "There are multiple heads and personalities affixed to one body."

/datum/quirk/hydra/on_spawn()
	var/mob/living/carbon/human/hydra = quirk_holder
	var/datum/action/innate/hydra/spell = new
	var/datum/action/innate/hydrareset/resetspell = new
	spell.Grant(hydra)
	spell.owner = hydra
	resetspell.Grant(hydra)
	resetspell.owner = hydra
	hydra.name_archive = hydra.real_name


/datum/action/innate/hydra
	name = "Switch head"
	desc = "Switch between each of the heads on your body."
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydrareset
	name = "Reset Speech"
	desc = "Go back to speaking as a whole."
	icon_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"

/datum/action/innate/hydrareset/Activate()
	var/mob/living/carbon/human/hydra = owner
	hydra.real_name = hydra.name_archive
	hydra.visible_message("<span class='notice'>[hydra.name] pushes all three heads forwards; they seem to be talking as a collective.</span>", \
							"<span class='notice'>You are now talking as [hydra.name_archive]!</span>", ignored_mobs=owner)

/datum/action/innate/hydra/Activate() //I hate this but its needed
	var/mob/living/carbon/human/hydra = owner
	var/list/names = splittext(hydra.name_archive,"-")
	var/selhead = input("Who would you like to speak as?","Heads:") in names
	hydra.real_name = selhead
	hydra.visible_message("<span class='notice'>[hydra.name] pulls the rest of their heads back; and puts [selhead]'s forward.</span>", \
							"<span class='notice'>You are now talking as [selhead]!</span>", ignored_mobs=owner)

//Own traits
/datum/quirk/cum_sniff
	name = "Genital Taster"
	desc = "You've built so much experience savoring other people's genitals through your life that you can easily tell what liquids they're full of (besides blood in their vessels that is)"
	value = 0
	mob_trait = TRAIT_GFLUID_DETECT
	gain_text = "<span class='notice'>You start getting peculiar smells from people's bits.</span>"
	lose_text = "<span class='notice'>People's genitals start smelling all the same to you...</span>"
	medical_record_text = "Patient attempted to get their doctor to drag his balls accross their face."

/datum/quirk/fluid_infuser
	name = "Fluid Infuser"
	desc = "You just couldn't wait to get one of NanoTrasen's new fluid inducers when they first came out, so now you can hop in the station with editable titty milk!"
	value = 0

/datum/quirk/fluid_infuser/on_spawn()
	. = ..()
	var/obj/item/implant/genital_fluid/put_in = new
	put_in.implant(quirk_holder, null, TRUE, TRUE)

/datum/quirk/vampire//splurt change start
	name = "Bloodsucker Fledgeling"
	desc = "you need blood for nutriment, you have fangs to aid with this, the church harms you"
	value = 3
	medical_record_text = "this person was partially infected by a bloodsucker"
	mob_trait = BLOODFLEDGE
	gain_text = "<span class='notice'>You feel an otherworldly thirst.</span>"
	lose_text = "<span class='notice'>you feel an otherworldy burden remove itself</span>"
	processing_quirk = TRUE

/datum/quirk/vampire/on_spawn()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/mob/living/carbon/C = quirk_holder
	ADD_TRAIT(H,TRAIT_NO_PROCESS_FOOD,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_COLDBLOODED,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_NOBREATH,ROUNDSTART_TRAIT)
	ADD_TRAIT(H,TRAIT_NOTHIRST,ROUNDSTART_TRAIT)
	if(!C.dna.skin_tone_override)
		H.skin_tone = "albino"
	var/datum/action/vbite/B = new
	B.Grant(H)

/datum/quirk/vampire/on_process()
	. = ..()
	var/mob/living/carbon/C = quirk_holder
	var/area/A = get_area(C)
	if(istype(A, /area/service/chapel) && C.mind?.assigned_role != "Chaplain")
		to_chat(C, "<span class='danger'>You don't belong here!</span>")
		C.adjustFireLoss(5)
		C.adjust_fire_stacks(6)

/datum/quirk/vampire/remove()
	var/mob/living/carbon/human/H = quirk_holder
    var/datum/action/vbite/B = locate() in H.actions
    REMOVE_TRAIT(H, TRAIT_NO_PROCESS_FOOD, ROUNDSTART_TRAIT)
    REMOVE_TRAIT(H, TRAIT_COLDBLOODED, ROUNDSTART_TRAIT)
    REMOVE_TRAIT(H, TRAIT_NOBREATH, ROUNDSTART_TRAIT)
    REMOVE_TRAIT(H, TRAIT_NOTHIRST, ROUNDSTART_TRAIT)
    B.Remove(H)
	. = ..()

/// quirk actions ///

//vampire bite

#define BLOOD_DRAIN_NUM 50

/datum/action/vbite
	name = "Bite Victim"
	button_icon_state = "power_feed"
	icon_icon = 'icons/mob/actions/bloodsucker.dmi'
	desc = "bite the person you are grabbing with your fangs"

/datum/action/vbite/Trigger()
	. = ..()
	var/drain_cooldown = 0
	if(iscarbon(owner))
		var/mob/living/carbon/H = owner
		if(H.nutrition >= 800)
			to_chat(H, "<span class='notice'>You are too full to drain any more.</span>")
			return
		if(drain_cooldown >= world.time)
			to_chat(H, "<span class='notice'>You just drained blood, wait a few seconds.</span>")
			return
		if(H.pulling && iscarbon(H.pulling))
			var/mob/living/carbon/victim = H.pulling
			drain_cooldown = world.time + 40
			if(victim.anti_magic_check(FALSE, TRUE, FALSE, 0))
				to_chat(victim, "<span class='warning'>[H] tries to bite you, but stops before touching you!</span>")
				to_chat(H, "<span class='warning'>[victim] is blessed! You stop just in time to avoid catching fire.</span>")
				return
			//Here we check now for both the garlic cloves on the neck and for blood in the victims bloodstream.
			if(!blood_sucking_checks(victim, TRUE, TRUE))
				return
			if(!do_after(H, 30, target = victim))
				return
			var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - H.blood_volume //How much capacity we have left to absorb blood
			var/drained_blood = min(victim.blood_volume, BLOOD_DRAIN_NUM, blood_volume_difference)
			H.reagents.add_reagent(/datum/reagent/blood/, drained_blood)
			to_chat(victim, "<span class='danger'>[H] is draining your blood!</span>")
			H.visible_message("<span class='danger'>[H] Bites down on [victim]'s neck!</span>")
			to_chat(H, "<span class='notice'>You drain some blood!</span>")
			playsound(H, 'sound/items/drink.ogg', 30, 1, -2)
			victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
			if(!victim.blood_volume)
				to_chat(H, "<span class='warning'>You finish off [victim]'s blood supply!</span>")

//splurt change end
//put next quirk action here


/datum/status_effect/chem/SGDF
	id = "SGDF"
	var/mob/living/fermi_Clone
	alert_type = null

/*
/obj/screen/alert/status_effect/SDGF
	name = "SDGF"
	desc = "You've cloned yourself! How cute."
	icon_state = "SDGF"
*/

/datum/status_effect/chem/SGDF/on_apply()
	message_admins("SGDF status appied")
	var/typepath = owner.type
	fermi_Clone = new typepath(owner.loc)
	var/mob/living/carbon/M = owner
	var/mob/living/carbon/C = fermi_Clone

	//fermi_Clone = new typepath(get_turf(M))
	//var/mob/living/carbon/C = fermi_Clone
	//var/mob/living/carbon/SM = fermi_Gclone

	if(istype(C) && istype(M))
		C.real_name = M.real_name
		M.dna.transfer_identity(C, transfer_SE=1)
		C.updateappearance(mutcolor_update=1)
	return ..()

/datum/status_effect/chem/SGDF/tick()
	//message_admins("SDGF ticking")
	if(owner.stat == DEAD)
		//message_admins("SGDF status swapping")
		if(fermi_Clone && fermi_Clone.stat != DEAD)
			if(owner.mind)
				owner.mind.transfer_to(fermi_Clone)
				owner.visible_message("<span class='warning'>Lucidity shoots to your previously blank mind as your mind suddenly finishes the cloning process. You marvel for a moment at yourself, as your mind subconciously recollects all your memories up until the point when you cloned yourself. curiously, you find that you memories are blank after you ingested the sythetic serum, leaving you to wonder where the other you is.</span>")
				fermi_Clone.visible_message("<span class='warning'>Lucidity shoots to your previously blank mind as your mind suddenly finishes the cloning process. You marvel for a moment at yourself, as your mind subconciously recollects all your memories up until the point when you cloned yourself. curiously, you find that you memories are blank after you ingested the sythetic serum, leaving you to wonder where the other you is.</span>")
				fermi_Clone = null
				owner.remove_status_effect(src)
		//	to_chat(owner, "<span class='notice'>[linked_extract] desperately tries to move your soul to a living body, but can't find one!</span>")
	..()

/datum/status_effect/chem/BElarger
	id = "BElarger"
	alert_type = null
	//var/list/items = list()
	//var/items = o.get_contents()

//mob/living/carbon/M = M tried, no dice
//owner, tried, no dice
/datum/status_effect/chem/BElarger/on_apply(mob/living/carbon/human/H)//Removes clothes, they're too small to contain you. You belong to space now.
	var/mob/living/carbon/human/o = owner
	var/items = o.get_contents()
	for(var/obj/item/W in items)
		if(W == o.w_uniform || W == o.wear_suit)
			o.dropItemToGround(W, TRUE)
			playsound(o.loc, 'sound/items/poster_ripped.ogg', 50, 1)
	//message_admins("BElarge started!")

	if(o.w_uniform || o.wear_suit)
		to_chat(o, "<span class='warning'>Your clothes give, ripping into peices under the strain of your swelling breasts! Unless you manage to reduce the size of your breasts, there's no way you're going to be able to put anything on over these melons..!</b></span>")
		o.visible_message("<span class='boldnotice'>[o]'s chest suddenly bursts forth, ripping their clothes off!'</span>")
	else
		to_chat(o, "<span class='notice'>Your bountiful bosom is so rich with mass, you seriously doubt you'll be able to fit any clothes over it.</b></span>")
	return ..()

/datum/status_effect/chem/BElarger/tick(mob/living/carbon/human/H)//If you try to wear clothes, you fail. Slows you down if you're comically huge
	var/mob/living/carbon/human/o = owner
	var/obj/item/organ/genital/breasts/B = o.getorganslot("breasts")
	if(!B)
		o.remove_movespeed_modifier("megamilk")
		o.next_move_modifier = 1
		owner.remove_status_effect(src)
	var/items = o.get_contents()
	for(var/obj/item/W in items)
		if(W == o.w_uniform || W == o.wear_suit)
			o.dropItemToGround(W, TRUE)
			playsound(o.loc, 'sound/items/poster_ripped.ogg', 50, 1)
			to_chat(owner, "<span class='warning'>Your enormous breasts are way too large to fit anything over them!</b></span>")
	//message_admins("BElarge tick!")
	/*
	var/items = o.get_contents()
	for(var/obj/item/W in items)
		if(W == o.w_uniform || W == o.wear_suit)
			o.dropItemToGround(W)
		//items |= owner.get_equipped_items(TRUE)

		//owner.dropItemToGround(owner.wear_suit)
		//owner.dropItemToGround(owner.w_uniform)
	*/
	switch(round(B.cached_size))
		if(9)
			if (!(B.breast_sizes[B.prev_size] == B.size))
				o.remove_movespeed_modifier("megamilk")
				o.next_move_modifier = 1
		if(10 to INFINITY)
			if (!(B.breast_sizes[B.prev_size] == B.size))
				to_chat(H, "<span class='warning'>Your indulgent busom is so substantial, it's affecting your movements!</b></span>")
				o.add_movespeed_modifier("megamilk", TRUE, 100, NONE, override = TRUE, multiplicative_slowdown = (round(B.cached_size) - 8))
				o.next_move_modifier = (round(B.cached_size) - 8)
	..()

/datum/status_effect/chem/BElarger/on_remove(mob/living/carbon/M)
	owner.remove_movespeed_modifier("megamilk")
	owner.next_move_modifier = 1


/datum/status_effect/chem/PElarger
	id = "PElarger"
	alert_type = null

/datum/status_effect/chem/PElarger/on_apply(mob/living/carbon/human/H)//Removes clothes, they're too small to contain you. You belong to space now.
	message_admins("PElarge started!")
	var/mob/living/carbon/human/o = owner
	var/items = o.get_contents()
	for(var/obj/item/W in items)
		if(W == o.w_uniform || W == o.wear_suit)
			o.dropItemToGround(W, TRUE)
			playsound(o.loc, 'sound/items/poster_ripped.ogg', 50, 1)
	if(o.w_uniform || o.wear_suit)
		to_chat(o, "<span class='warning'>Your clothes give, ripping into peices under the strain of your swelling pecker! Unless you manage to reduce the size of your emancipated trouser snake, there's no way you're going to be able to put anything on over this girth..!</b></span>")
		owner.visible_message("<span class='boldnotice'>[o]'s schlong suddenly bursts forth, ripping their clothes off!'</span>")
	else
		to_chat(o, "<span class='notice'>Your emancipated trouser snake is so ripe with girth, you seriously doubt you'll be able to fit any clothes over it.</b></span>")
	return ..()


/datum/status_effect/chem/PElarger/tick(mob/living/carbon/M)
	var/mob/living/carbon/human/o = owner
	var/obj/item/organ/genital/penis/P = o.getorganslot("penis")
	if(!P)
		o.remove_movespeed_modifier("hugedick")
		o.next_move_modifier = 1
		owner.remove_status_effect(src)
	message_admins("PElarge tick!")
	var/items = o.get_contents()
	for(var/obj/item/W in items)
		if(W == o.w_uniform || W == o.wear_suit)
			o.dropItemToGround(W, TRUE)
			playsound(o.loc, 'sound/items/poster_ripped.ogg', 50, 1)
			to_chat(owner, "<span class='warning'>Your enormous package is way to large to fit anything over!</b></span>")
	switch(round(P.cached_length))
		if(11)
			if (!(P.prev_size == P.size))
				to_chat(o, "<span class='warning'>Your rascally willy has become a more managable size, liberating your movements.</b></span>")
				o.remove_movespeed_modifier("hugedick")
				o.next_move_modifier = 1
		if(12 to INFINITY)
			if (!(P.prev_size == P.size))
				to_chat(o, "<span class='warning'>Your indulgent johnson is so substantial, it's affecting your movements!</b></span>")
				o.add_movespeed_modifier("hugedick", TRUE, 100, NONE, override = TRUE, multiplicative_slowdown = (P.length - 11.1))
				o.next_move_modifier = (round(P.length) - 11)
	..()


/*//////////////////////////////////////////
		Mind control functions
///////////////////////////////////////////
*/

/datum/status_effect/chem/enthrall
	id = "enthrall"
	alert_type = null
	var/mob/living/E //E for enchanter
	//var/mob/living/V = list() //V for victims
	var/enthrallTally = 10
	var/resistanceTally = 0
	var/deltaResist
	var/deltaEnthrall
	var/phase = 1 //-1: resisted state, due to be removed.0: sleeper agent, no effects unless triggered 1: initial, 2: 2nd stage - more commands, 3rd: fully enthralled, 4th Mindbroken
	var/status = null
	var/statusStrength = 0
	var/enthrallID
	var/mindbroken = FALSE
	var/datum/weakref/redirect_component1
	var/datum/weakref/redirect_component2

/datum/status_effect/chem/enthrall/on_apply(mob/living/carbon/M)
	if(M.ID == enthralID)
		owner.remove_status_effect(src)//This should'nt happen, but just in case
	redirect_component1 = WEAKREF(owner.AddComponent(/datum/component/redirect, list(COMSIG_LIVING_RESIST = CALLBACK(src, .proc/owner_resist)))) //Do resistance calc if resist is pressed#
	redirect_component2 = WEAKREF(owner.AddComponent(/datum/component/redirect, list(COMSIG_LIVING_SAY = CALLBACK(src, .proc/owner_say)))) //Do resistance calc if resist is pressed


/datum/status_effect/chem/enthrall/tick(mob/living/carbon/M)
	if(M.has_trait(TRAIT_MINDSHIELD))
		resistanceTally += 5
		if(prob(20))
			to_chat(owner, "You feel your lucidity returning as the mindshield fights")

	switch(phase)
		if(-1)//fully removed
			owner.remove_status_effect(src)
		if(0)// sleeper agent
			return
		if(1)//Initial enthrallment
			if (enthrallTally > 100)
				phase += 1
				return
			if (resistanceTally > 100)

			if resist


/datum/status_effect/chem/enthrall/on_remove(mob/living/carbon/M)
	qdel(redirect_component1.resolve())
	redirect_component1 = null
	qdel(redirect_component2.resolve())
	redirect_component2 = null

/*
/datum/status_effect/chem/enthrall/mob/say(message, bubble_type, var/list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
		    if(enthralID.name in message || enthralID.first_name in message)
		        return
		    else
		        . = ..()
*/

/datum/status_effect/chem/enthrall/proc/owner_withdrawal(mob/living/carbon/M)
	//3 stages, each getting worse

/datum/status_effect/chem/enthrall/proc/owner_resist(mob/living/carbon/M)
	if(prob(10))
		M.emote("me",1,"squints, shaking their head for a moment.")//shows that you're trying to resist sometimes
	to_chat(owner, "You attempt to shake the mental cobwebs from your mind!")
	//base resistance
	if (M.canbearoused)
		deltaResist*= ((100 - M.arousalloss/100)/100)//more aroused you are, the weaker resistance you can give
	else
		deltaResist *= 0.2
	//chemical resistance, brain and annaphros are the key to undoing, but the subject has to to be willing to resist.
	if (user.has_reagent("mannitol"))
		deltaResist *= 1.25
	if (user.has_reagent("neurine"))
		deltaResist *= 1.5
	if (!H.has_trait(TRAIT_CROCRIN_IMMUNE) && M.canbearoused)
		if (user.has_reagent("anaphro"))
			deltaResist *= 1.5
		if (user.has_reagent("anaphro+"))
			deltaResist *= 2
		if (user.has_reagent("aphro"))
			deltaResist *= 0.75
		if (user.has_reagent("aphro+"))
			deltaResist *= 0.5

	//Antag resistance
	//cultists are already brainwashed by their god
	if(iscultist(owner))
		deltaResist *= 2
	else if (is_servant_of_ratvar(user))
		deltaResist *= 2
	//antags should be able to resist, so they can do their other objectives. This chem does frustrate them, but they've all the tools to break free when an oportunity presents itself.
	else if (owner.mind.assigned_role in GLOB.antagonists)
		deltaResist *= 1.8

	//role resistance
	//Chaplains are already brainwashed by their god
	if(owner.mind.assigned_role == "Chaplain")
		deltaResist *= 1.5
	//Command staff has authority,
	if(owner.mind.assigned_role in GLOB.command_positions)
		deltaResist *= 1.4
		//if(owner.first_name == "skylar"); power_multiplier *= 0.8 //for skylar //I'm kidding
	//Chemists should be familiar with drug effects
	if(owner.mind.assigned_role == "Chemist")
		deltaResist *= 1.3

	//Happiness resistance
	//Your Thralls are like pets, you need to keep them happy.
	if(owner.nutrition < 250)
		deltaResist += (250-owner.nutrition)/100
	if(owner.health < 120)//Harming your thrall will make them rebel harder.
		deltaResist *= ((120-owner.health)/100)+1
	//Add cold/hot, oxygen, sanity, happiness? (happiness might be moot, since the mood effects are so strong)
	//Mental health could play a role too in the other direction

	//If master gives you a collar, you get a sense of pride
	if(istype(owner.neck, /obj/item/clothing/neck/petcollar))
		deltaResist *= 0.8

/datum/status_effect/chem/enthrall/proc/owner_say(mob/living/carbon/M) //I can only hope this works
	var/static/regex/owner_words = regex("[enthralID.real_name]|[enthralID.first_name()]")
	if(findtext(message, enthral_words))
		if(enthralID.gender == FEMALE)
			message = replacetext(message, enthralID.real_name, "Mistress")
			message = replacetext(message, enthralID.first_name(, "Mistress")
		else
			message = replacetext(message, enthralID.real_name, "Master")
			message = replacetext(message, enthralID.first_name(, "Master")
	return message
/*
/datum/status_effect/chem/OwO
	id = "OwO"

/datum/status_effect/chem/PElarger/tick(message)
	if(copytext(message, 1, 2) != "*")
		message = replacetext(message, "ne", "nye")
		message = replacetext(message, "nu", "nyu")
		message = replacetext(message, "na", "nya")
		message = replacetext(message, "no", "nyo")
		message = replacetext(message, "ove", "uv")
		message = replacetext(message, "ove", "uv")
		message = replacetext(message, "th", "ff")
		message = replacetext(message, "l", "w")
		message = replacetext(message, "r", "w")
		if(prob(20))
			message = replacetext(message, ".", "OwO.")
		else if(prob(30))
			message = replacetext(message, ".", "uwu.")
		message = lowertext(message)
*/
/*Doesn't work
/datum/status_effect/chem/SDGF/candidates
	id = "SGDFCandi"
	var/mob/living/fermi_Clone
	var/list/candies = list()

/datum/status_effect/chem/SDGF/candidates/on_apply()
	candies = pollGhostCandidates("Do you want to play as a clone and do you agree to respect their character and act in a similar manner to them? I swear to god if you diddle them I will be very disapointed in you. ", "FermiClone", null, ROLE_SENTIENCE, 300) // see poll_ignore.dm, should allow admins to ban greifers or bullies
	return ..()
*/

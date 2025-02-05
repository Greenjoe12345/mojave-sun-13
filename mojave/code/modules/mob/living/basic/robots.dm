/mob/living/basic/ms13/robot
	name = "robot"
	desc = "beep boop you have dysentery."
	icon = 'mojave/icons/mob/ms13robots.dmi'
	icon_state = "assaultron"
	mob_biotypes = MOB_ROBOTIC
	gender = NEUTER
	health = 150
	maxHealth = 150
	speed = 1
	attack_verb_continuous = "dissects"
	attack_verb_simple = "stabs"
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_sound = 'sound/weapons/punch1.ogg'
	combat_mode = TRUE
	faction = list("robots")
	speak_emote = list("states","dictates")
	var/shadow_type = null // For shadows below floating robots

	ai_controller = /datum/ai_controller/basic_controller/ms13/robot

/mob/living/basic/ms13/robot/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/death_drops, list(/obj/effect/decal/cleanable/robot_debris))

/datum/ai_controller/basic_controller/ms13/robot
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/random_speech/ms13/robot,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/ms13/robot,
		/datum/ai_planning_subtree/find_and_hunt_target
	)

/datum/ai_planning_subtree/basic_melee_attack_subtree/ms13/robot
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/ms13/robot

/datum/ai_behavior/basic_melee_attack/ms13/robot
	action_cooldown = 1.5 SECONDS

/mob/living/basic/ms13/robot/handy
    name = "Mr. Handy"
    desc = "A standard model Mr. Handy unit. It's long lost any rational wires in its circuits."
    icon_state = "mrhandy_claw"
    health = 150
    maxHealth = 150
    melee_damage_lower = 15
    melee_damage_upper = 15
    armour_penetration = 5
    speed = 0.5
    speak_emote = list("states", "says")
    attack_verb_continuous = "pinches"
    attack_verb_simple = "pinch"
    sharpness = NONE
    wound_bonus = 5
    bare_wound_bonus = 5
    shadow_type = "shadow_large"

/mob/living/basic/ms13/robot/handy/New()
    ..()
    add_overlay(image(icon, "[shadow_type]", BELOW_MOB_LAYER, dir))

/mob/living/basic/ms13/robot/handy/death()
    . = ..()
    do_sparks(3, TRUE, src)
    qdel(src)

/mob/living/basic/ms13/robot/handy/saw
    desc = "A work model Mr. Handy unit, armed with a horrifyingly sharp saw. It's long lost any rational wires in its circuits."
    icon_state = "mrhandy_saw"
    melee_damage_lower = 30
    melee_damage_upper = 30
    armour_penetration = 10
    sharpness = SHARP_EDGED
    wound_bonus = 6
    bare_wound_bonus = 6
    attack_verb_continuous = "saws"
    attack_verb_simple = "saw"
    attack_sound = 'sound/weapons/circsawhit.ogg'

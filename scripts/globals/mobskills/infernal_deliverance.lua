---------------------------------------------
-- Infernal Deliverance
-- Description: Deals damage to targets in range. Additional effect: Stun
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target,mob,skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5
    local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,dsp.attackType.PHYSICAL,dsp.damageType.BLUNT,info.hitslanded)

    MobStatusEffectMove(mob, target, dsp.effect.STUN, 0, 0, 10)

    target:takeDamage(dmg, mob, dsp.attackType.PHYSICAL, dsp.damageType.BLUNT)
    return dmg
end

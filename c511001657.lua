--Revenge Attack
function c511001657.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(c511001657.condition)
	e1:SetOperation(c511001657.activate)
	c:RegisterEffect(e1)
end
function c511001657.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	return a:IsControler(tp) and at and at:IsControler(1-tp) and at:IsRelateToBattle() and not at:IsStatus(STATUS_BATTLE_DESTROYED) 
		and a:IsOnField() and a:IsRelateToBattle() 
end
function c511001657.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a:IsRelateToBattle() then
		Duel.ChainAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(1000)
		a:RegisterEffect(e1)
	end
end

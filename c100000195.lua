--マジェスティック・ジェスター
function c100000195.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000195,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c100000195.descon)
	e1:SetTarget(c100000195.destg)
	e1:SetOperation(c100000195.desop)
	c:RegisterEffect(e1)
end
function c100000195.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
end
function c100000195.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end	
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c100000195.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttackTarget()
	if c==tc then tc=Duel.GetAttacker() end
	if not tc:IsRelateToBattle() then return end
	local d=Duel.TossDice(tp,1)
	if d==6 then	
		if c:IsFaceup() and c:IsLocation(LOCATION_MZONE) then Duel.Destroy(tc,REASON_EFFECT) end
	else
		Duel.Destroy(c,REASON_EFFECT)
	end
end

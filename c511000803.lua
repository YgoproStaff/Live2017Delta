--Rampaging Binary Stars Level 2
function c511000803.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511000803.condition)
	e1:SetTarget(c511000803.target)
	e1:SetOperation(c511000803.operation)
	c:RegisterEffect(e1)
end
function c511000803.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsType,1,nil,TYPE_SYNCHRO) and Duel.GetAttacker():IsType(TYPE_SYNCHRO) and Duel.GetAttackTarget():IsType(TYPE_SYNCHRO)
end
function c511000803.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==2
end
function c511000803.spfilter(c,e,tp,code)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==2 and c:IsCode(code)
end
function c511000803.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000803.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000803.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000803.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		if ft>1 and Duel.IsExistingMatchingCard(c511000803.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,tc:GetCode()) then
			ft=ft-1
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local spg=Duel.SelectMatchingCard(tp,c511000803.spfilter,tp,LOCATION_HAND,0,ft,ft,tc,e,tp,tc:GetCode())
			g:Merge(spg)
		end
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		local tg=g:GetFirst()
		while tg do
			tg:RegisterFlagEffect(511000803,RESET_PHASE+PHASE_END,0,1)
			tg=g:GetNext()
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetOperation(c511000803.desop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000803.desfilter(c)
	return c:IsLocation(LOCATION_MZONE) and c:IsDestructable() and c:GetFlagEffect(511000803)~=0
end
function c511000803.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511000803.desfilter,tp,LOCATION_MZONE,0,nil)
	if Duel.Destroy(sg,REASON_EFFECT)~=0 then
		local sum=sg:GetSum(Card.GetAttack)
		Duel.Damage(1-tp,sum,REASON_EFFECT)
	end
end

--RR－コール
function c511002773.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002773.cost)
	e1:SetTarget(c511002773.target)
	e1:SetOperation(c511002773.activate)
	c:RegisterEffect(e1)
end
function c511002773.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_ATTACK)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511002773.filter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0xba) and c:IsLevelBelow(3)
		and Duel.IsExistingMatchingCard(c511002773.filter2,tp,LOCATION_DECK,0,1,nil,e,tp,c:GetCode())
end
function c511002773.filter2(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002773.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsCode(e:GetLabel()) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511002773.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511002773.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	e:SetLabel(g:GetFirst():GetCode())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_DECK)
end
function c511002773.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local code=tc:GetCode()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511002773.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp,code)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end

--Armament Reincarnation
function c511000708.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000708.sptg)
	e1:SetOperation(c511000708.spop)
	c:RegisterEffect(e1)
end
function c511000708.filter(c,e,tp)
	return c:IsType(TYPE_EQUIP) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000708.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft=0
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>=Duel.GetLocationCount(tp,LOCATION_SZONE) then
		ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	else
		ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	end
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511000708.spfilter(chkc,e,tp) end
	if chk==0 then return ft>0 and Duel.IsExistingTarget(c511000708.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000708.filter,tp,LOCATION_GRAVE,0,ft,ft,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c511000708.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=0
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>=Duel.GetLocationCount(tp,LOCATION_SZONE) then
		ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	else
		ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		sg=sg:Select(tp,ft,ft,nil)
	end
	local tc=sg:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP)
		local e0=Effect.CreateEffect(c)
		e0:SetCode(EFFECT_CHANGE_TYPE)
		e0:SetType(EFFECT_TYPE_SINGLE)
		e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e0:SetReset(RESET_EVENT+0x1fc0000)
		e0:SetValue(TYPE_MONSTER)
		tc:RegisterEffect(e0)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetValue(500)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		local code=tc:GetOriginalCode()
		local token=Duel.CreateToken(tp,code,nil,nil,nil,nil,nil,nil)		
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		Duel.MoveToField(token,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		Duel.Equip(tp,token,tc)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_LEAVE_FIELD)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetReset(RESET_EVENT+0x47e0000)
		e3:SetOperation(c511000708.leaveop)
		token:RegisterEffect(e3,true)
		tc=sg:GetNext()
	end
	Duel.SpecialSummonComplete()
end
function c511000708.leaveop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDeck(e:GetHandler(),nil,-2,REASON_RULE)
end

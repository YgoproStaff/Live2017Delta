--GEM Burst
function c511000679.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000679.cost)
	e1:SetTarget(c511000679.target)
	e1:SetOperation(c511000679.activate)
	c:RegisterEffect(e1)
end
function c511000679.cfilter(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c511000679.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000679.cfilter,tp,LOCATION_GRAVE,0,1,nil,511000676)
		and Duel.IsExistingMatchingCard(c511000679.cfilter,tp,LOCATION_GRAVE,0,1,nil,511000677)
		and Duel.IsExistingMatchingCard(c511000679.cfilter,tp,LOCATION_GRAVE,0,1,nil,511000678) end
	local tc1=Duel.GetFirstMatchingCard(c511000679.cfilter,tp,LOCATION_GRAVE,0,nil,511000676)
	local tc2=Duel.GetFirstMatchingCard(c511000679.cfilter,tp,LOCATION_GRAVE,0,nil,511000677)
	local tc3=Duel.GetFirstMatchingCard(c511000679.cfilter,tp,LOCATION_GRAVE,0,nil,511000678)
	local g=Group.FromCards(tc1,tc2,tc3)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511000679.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_HAND,0,1,nil,0x1034) 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_HAND,nil,1,tp,LOCATION_HAND)
end
function c511000679.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,Card.IsSetCard,tp,LOCATION_HAND,0,ft,ft,nil,0x1034)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fc0000)
			e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
		Duel.RaiseEvent(g,47408488,e,0,tp,0,0)
		local d=Duel.GetMatchingGroupCount(Card.IsSetCard,tp,LOCATION_SZONE,0,nil,0x1034)*500
		Duel.Damage(1-tp,d,REASON_EFFECT)
	end
end

--サイバー・エルタニン
function c511002286.initial_effect(c)	
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511002286.destg)
	e1:SetOperation(c511002286.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_SET_ATTACK)
	e4:SetValue(c511002286.value)
	c:RegisterEffect(e4)
end
function c511002286.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x93)
end
function c511002286.value(e,c)
	return Duel.GetMatchingGroupCount(c511002286.filter,0,LOCATION_REMOVED,LOCATION_REMOVED,nil)*500
end
function c511002286.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) 
		and Duel.GetMatchingGroupCount(c511002286.filter,0,LOCATION_REMOVED,LOCATION_REMOVED,nil)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c511002286.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c511002286.filter,0,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,ct,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end

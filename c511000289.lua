--Sapphire Revive
function c511000289.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000289.condition)
	e1:SetTarget(c511000289.target)
	e1:SetOperation(c511000289.operation)
	c:RegisterEffect(e1)
end
function c511000289.cfilter(c)
	return c:IsFaceup() and c:IsCode(7093411)
end
function c511000289.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000289.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511000289.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000289.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511000289.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c511000289.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
	and Duel.SelectYesNo(tp,aux.Stringid(511000289,1)) then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c511000289.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SpecialSummonStep(g1:GetFirst(),0,tp,tp,false,false,POS_FACEUP)
end
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c511000289.filter,1-tp,LOCATION_GRAVE,0,1,nil,e,1-tp)
	and Duel.SelectYesNo(1-tp,aux.Stringid(511000289,1)) then
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(1-tp,c511000289.filter,1-tp,LOCATION_GRAVE,0,1,1,nil,e,1-tp)
	Duel.SpecialSummonStep(g2:GetFirst(),0,1-tp,1-tp,false,false,POS_FACEUP)
end
	Duel.SpecialSummonComplete()
end

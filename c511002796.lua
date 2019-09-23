--極星霊リョースアールヴ
function c511002796.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40666140,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511002796.sptg)
	e1:SetOperation(c511002796.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c511002796.filter(c,lv,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and Duel.IsExistingMatchingCard(c511002796.filter2,tp,LOCATION_MZONE,0,1,nil,lv,c:GetLevel())
end
function c511002796.filter2(c,lv1,lv2)
	local lv=c:GetLevel()
	return c:IsFaceup() and lv>0 and lv2<=lv+lv1
end
function c511002796.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002796.filter,tp,LOCATION_HAND,0,1,nil,e:GetHandler():GetLevel(),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511002796.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511002796.filter,tp,LOCATION_HAND,0,1,1,nil,e:GetHandler():GetLevel(),e,tp)
	if sg:GetCount()>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end

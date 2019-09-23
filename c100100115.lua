--Ｓｐ－スター・フォース
function c100100115.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100115.con)
	e1:SetCost(c100100115.cost)
	e1:SetOperation(c100100115.operation)
	c:RegisterEffect(e1)
end
function c100100115.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>1
end
function c100100115.cfilter(c)
	return c:IsFaceup() and c:IsAbleToRemoveAsCost()
	 and Duel.IsExistingMatchingCard(Card.IsFaceup,c:GetControler(),LOCATION_MZONE,0,1,c)
end
function c100100115.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100100115.cfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,e:GetHandler():GetControler(),HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(e:GetHandler():GetControler(),c100100115.cfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,1,nil)
	e:SetLabel(g:GetFirst():GetLevel()*200)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c100100115.operation(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(Card.IsFaceup,e:GetHandler():GetControler(),LOCATION_MZONE,0,nil)		
	Duel.Hint(HINT_SELECTMSG,e:GetHandler():GetControler(),HINTMSG_FACEUP)
	local tdg=dg:Select(e:GetHandler():GetControler(),1,1,nil)
	local tc=tdg:GetFirst()	
	if tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(e:GetLabel())
		tc:RegisterEffect(e1)
	end
end

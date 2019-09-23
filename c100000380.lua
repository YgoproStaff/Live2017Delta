--マグマオーシャン
function c100000380.initial_effect(c)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetTarget(c100000380.target)
	e1:SetOperation(c100000380.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c100000380.filter(c)
	return c:IsFaceup() and c:IsDestructable() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c100000380.target(e,tp,eg,ep,ev,re,r,rp,chk)	
	if chk==0 then return Duel.GetCurrentChain()==0 and eg:IsExists(c100000380.filter,1,nil) end
	local g=eg:Filter(c100000380.filter,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c100000380.activate(e,tp,eg,ep,ev,re,r,rp)	
	local g=eg:Filter(c100000380.filter,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end

--地縛神 Aslla piscu
local s,id=GetID()
function s.initial_effect(c)
	c:SetUniqueOnField(1,1,aux.FilterBoolFunction(Card.IsSetCard,0x21),LOCATION_MZONE)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(s.sdcon)
	c:RegisterEffect(e4)
	--battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(aux.imval2)
	c:RegisterEffect(e5)
	--direct atk
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e6)
	--destroy
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(id,0))
	e7:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_LEAVE_FIELD)
	e7:SetCondition(s.descon)
	e7:SetTarget(s.destg)
	e7:SetOperation(s.desop)
	c:RegisterEffect(e7)
end
function s.sdcon(e)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	local f1=Duel.GetFieldCard(0,LOCATION_SZONE,5)
	local f2=Duel.GetFieldCard(1,LOCATION_SZONE,5)
	return ((f1==nil or not f1:IsFaceup()) and (f2==nil or not f2:IsFaceup()))
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and not c:IsLocation(LOCATION_DECK)
		and (not re or re:GetOwner()~=c)
end
function s.desfilter(c)
	return c:IsFaceup()
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(s.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
	if #g~=0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,#g*800)
	end
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.desfilter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct~=0 then
		Duel.Damage(1-tp,ct*800,REASON_EFFECT)
	end
end

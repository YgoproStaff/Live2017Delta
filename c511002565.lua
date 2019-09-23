--Disaster Conspiracy
function c511002565.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(511002565)
	e1:SetCondition(c511002565.condition)
	e1:SetTarget(c511002565.target)
	e1:SetOperation(c511002565.activate)
	c:RegisterEffect(e1)
	if not c511002565.global_check then
		c511002565.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_AVAILABLE_BD)
		ge1:SetCode(EVENT_BATTLE_DAMAGE)
		ge1:SetOperation(c511002565.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511002565.checkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if ev<1000 then return end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return end
	if ep==PLAYER_ALL then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLE_DESTROYED)
		e1:SetOperation(c511002565.damop)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_BATTLE_DESTROYED)
		e2:SetOperation(c511002565.damop)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e2,1-tp)
	end
	if a:IsControler(ep) then
		a,d=d,a
	end
	if d:IsControler(1-ep) or d:GetOwner()==ep then return end
	if a:IsControler(1-ep) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLE_DESTROYED)
		e1:SetOperation(c511002565.damop)
		e1:SetLabelObject(d)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e1,ep)
	end
end
function c511002565.damop(e,tp,eg,ep,ev,re,r,rp)
	local d=e:GetLabelObject()
	if not d:IsLocation(LOCATION_MZONE) then
		Duel.RaiseEvent(d,511002565,e,REASON_BATTLE,1-tp,tp,ev)
	end
end
function c511002565.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec:IsControler(1-tp)
end
function c511002565.filter(c,atk)
	return c:GetAttack()>atk and c:IsAbleToGrave()
end
function c511002565.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=eg:GetFirst()
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_DECK,1,nil) end
	local sg=Duel.GetMatchingGroup(c511002565.filter,tp,0,LOCATION_DECK,nil,ec:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,sg:GetCount(),0,0)
end
function c511002565.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local sg=Duel.GetMatchingGroup(c511002565.filter,tp,0,LOCATION_DECK,nil,ec:GetAttack())
	if sg:GetCount()>0 then
		Duel.SendtoGrave(sg,REASON_EFFECT)
	elseif Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_DECK,1,nil) then
		local cg=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
		Duel.ConfirmCards(1-tp,cg)
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleDeck(1-tp)
	end
end

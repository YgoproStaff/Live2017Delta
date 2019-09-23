--Name Erasure
--  By Shad3
--fixed by MLD
function c511005010.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Effect
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_HANDES+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511005010.tg)
	e2:SetOperation(c511005010.op)
	c:RegisterEffect(e2)
end
function c511005010.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)
	if chk==0 then return ct>0 end
	local code
	c511005010.codes={}
	local announce_filter={}
	for i=1,ct do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
		if #c511005010.codes>0 then
			code=Duel.AnnounceCardFilter(tp,table.unpack(announce_filter))
		else
			code=Duel.AnnounceCard(tp)
		end
		table.insert(c511005010.codes,code)
		table.insert(announce_filter,code)
		table.insert(announce_filter,OPCODE_ISCODE)
		table.insert(announce_filter,OPCODE_NOT)
		if #c511005010.codes>1 then
			table.insert(announce_filter,OPCODE_AND)
		end
	end
	if ct==1 then
		Duel.SetTargetParam(code)
		Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
	end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,0)
end
function c511005010.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
	local code=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local codes={}
	if code and code>0 then
		table.insert(codes,code)
	else
		for _,code in ipairs(c511005010.codes) do
			table.insert(codes,code)
		end
	end
	local tg=g:Filter(Card.IsCode,nil,table.unpack(codes))
	local dam=0
	for _,code in ipairs(codes) do
		if not tg:IsExists(Card.IsCode,1,nil,code) then
			dam=dam+1000
		end
	end
	if tg:GetCount()>0 then
		Duel.SendtoGrave(tg,REASON_DISCARD)
	end
	Duel.Damage(tp,dam,REASON_EFFECT)
end

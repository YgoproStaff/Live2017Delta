-- Narukami Waterfall
-- scripted by: UnknownGuest
function c810000062.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_TO_GRAVE)
	e2:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	e2:SetTarget(c810000062.filter)
	--e2:SetValue(1)
	c:RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_CANNOT_DISCARD_HAND)
	e3:SetTargetRange(1,1)
	e3:SetTarget(c810000062.filter)
	--e3:SetValue(1)
	c:RegisterEffect(e3,tp)
end
function c810000062.filter(e,c)
	return c:IsType(TYPE_MONSTER)
end

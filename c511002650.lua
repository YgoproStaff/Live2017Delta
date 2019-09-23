--RR replication
function c511002650.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511002650.condition)
	e1:SetTarget(c511002650.target)
	e1:SetOperation(c511002650.activate)
	c:RegisterEffect(e1)
end
function c511002650.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	return d and d:IsFaceup() and d:IsControler(tp) and d:IsSetCard(0xba) and  d:IsLevelBelow(4)
end
function c511002650.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,d:GetOriginalCode(),0xba,d:GetType(),d:GetAttack(),d:GetDefense(),
		d:GetLevel(),d:GetRace(),d:GetAttribute()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511002650.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttackTarget()
	if not tc or not tc:IsRelateToBattle() then return end
	local code=tc:GetOriginalCode()
	local token=Duel.CreateToken(tp,code)
	Duel.SpecialSummonStep(token,0,tp,tp,true,false,tc:GetPosition())
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(tc:GetBaseAttack())
	e1:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(tc:GetBaseDefense())
	token:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CHANGE_LEVEL)
	e3:SetValue(tc:GetLevel())
	token:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CHANGE_RACE)
	e4:SetValue(tc:GetRace())
	token:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e5:SetValue(tc:GetAttribute())
	token:RegisterEffect(e5)
	local e6=Effect.CreateEffect(e:GetHandler())
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetReset(RESET_EVENT+0x1fe0000)
	e6:SetCode(EFFECT_CHANGE_CODE)
	e6:SetValue(tc:GetCode())
	token:RegisterEffect(e6)
	local e7=e1:Clone()
	e7:SetCode(EFFECT_SET_ATTACK_FINAL)
	e7:SetValue(tc:GetAttack())
	token:RegisterEffect(e7)
	local e8=e1:Clone()
	e8:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e8:SetValue(tc:GetDefense())
	token:RegisterEffect(e8)
	Duel.SpecialSummonComplete()
end

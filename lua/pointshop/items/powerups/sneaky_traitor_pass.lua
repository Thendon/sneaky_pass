ITEM.Name = 'Licence to Kill (Traitor)'
ITEM.Price = 3000
ITEM.Material = 'licence/icon_traitor.png'
ITEM.Except = true

function ITEM:OnEquip(ply, modifications)
	ply:ChatPrint( "[TPass] ausgerüstet! Du wirst am Rundenstart Traitor!" )
	print( "[TPass] of ", ply:Nick(), " equiped" )
end

function ITEM:OnHolster(ply)
	print( "[TPass] of ", ply:Nick(), " holstered" )
end

if SERVER then
	hook.Add("TTTBeginRound", "T_Pass", function()
		local passActivated = false
		for k, v in pairs( player.GetAll() ) do
			if v:PS_HasItemEquipped('sneaky_traitor_pass') and !v:IsSpec() then
				if !passActivated then
					if v:GetRoleString() == "innocent" then
						passActivated = true		
						v:SetRole(ROLE_TRAITOR)
						v:AddCredits(GetConVarNumber("ttt_credits_starting"))
						v:PS_TakeItem('sneaky_traitor_pass')
						print( "[TPass] ", v:Nick(), " used a Traitor Pass" )
						v:ChatPrint( "[TPass] wurde eingelöst!" )
					else
						v:ChatPrint( "[TPass] konnte nicht eingelöst werden! Du warst bereits "..v:GetRoleString().."!" )
					end
				else
					v:ChatPrint( "[TPass] konnte nicht eingelöst werden! Jemand anderes hat einen Pass eingelöst!" )
				end
			end
		end		
	end)
end
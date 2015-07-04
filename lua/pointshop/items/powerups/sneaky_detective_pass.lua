ITEM.Name = 'Sherlock Mode (Detective)'
ITEM.Price = 1000
ITEM.Material = 'licence/icon_det.png'
ITEM.Except = true

function ITEM:OnEquip(ply, modifications)
	ply:ChatPrint( "[DPass] ausgerüstet! Du wirst am Rundenstart Detective!" )
	print( "[DPass] of ", ply:Nick(), " equiped" )
end

function ITEM:OnHolster(ply)
	print( "[DPass] of ", ply:Nick(), " holstered" )
end

if SERVER then
	hook.Add("TTTBeginRound", "D_Pass", function()
		local passActivated = false
		for k, v in pairs( player.GetAll() ) do
			if v:PS_HasItemEquipped('sneaky_detective_pass') and !v:IsSpec() then
				if !passActivated then
					if v:GetRoleString() == "innocent" then
						passActivated = true		
						v:SetRole(ROLE_DETECTIVE)
						v:AddCredits(GetConVarNumber("ttt_det_credits_starting"))
						v:PS_TakeItem('sneaky_detective_pass')
						print( "[DPass] ", v:Nick(), " used a Detective Pass" )
						v:ChatPrint( "[DPass] wurde eingelöst!" )
					else
						v:ChatPrint( "[DPass] konnte nicht eingelöst werden! Du warst bereits "..v:GetRoleString().."!" )
					end
				else
					v:ChatPrint( "[DPass] konnte nicht eingelöst werden! Jemand anderes hat einen Pass eingelöst!" )
				end
			end
		end		
	end)
end
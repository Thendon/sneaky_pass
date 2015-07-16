CreateConVar("ttt_tpass_name","Licence to Kill (Traitor)",{FCVAR_ARCHIVE},"Change the price of the Traitor Pass")
CreateConVar("ttt_tpass_price",3000,{FCVAR_ARCHIVE},"Change the name of the Traitor Pass")

resource.AddFile("materials/licence/icon_traitor.png")

ITEM.Name = GetConVarString("ttt_tpass_name")
ITEM.Price = GetConVarNumber("ttt_tpass_price")
ITEM.Material = 'licence/icon_traitor.png'
ITEM.Except = true

function ITEM:OnEquip(ply, modifications)
	ply:ChatPrint( "[TPass] equipped! You will be traitor in the next round!" )
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
						v:ChatPrint( "[TPass] was redeemed!" )
					else
						v:ChatPrint( "[TPass] couldn't be redeemed! You were already "..v:GetRoleString().."!" )
					end
				else
					v:ChatPrint( "[TPass] couldn't be redeemed! Someone else has used his pass!" )
				end
			end
		end
	end)
end
using System;
using Terraria;
using Terraria.Graphics.Effects;
using Terraria.ID;
using Terraria.ModLoader;

namespace LowHealthEffects
{
	public class LowHealthPlayer : ModPlayer
	{
		public override void PostUpdate()
		{
			if (Main.netMode == NetmodeID.Server)
				return;

			if (player.whoAmI != Main.myPlayer)
				return;

			#region Saturation
			if (!Filters.Scene["HealthSaturation"].IsActive() && LowHealthEffects.SaturationEnabled)
				Filters.Scene.Activate("HealthSaturation");
			else if (!LowHealthEffects.SaturationEnabled)
				Filters.Scene.Deactivate("HealthSaturation");

			if (Filters.Scene["HealthSaturation"].IsActive())
				Filters.Scene["HealthSaturation"].GetShader().UseProgress((float)player.statLife / (float)player.statLifeMax2);
			#endregion

			#region Blur
			if (!Filters.Scene["HealthBlur"].IsActive() && LowHealthEffects.BlurEnabled)
				Filters.Scene.Activate("HealthBlur");
			else if (!LowHealthEffects.BlurEnabled)
				Filters.Scene.Deactivate("HealthBlur");

			if (Filters.Scene["HealthBlur"].IsActive())
				Filters.Scene["HealthBlur"].GetShader().UseProgress(Math.Abs(1f - ((float)player.statLife / (float)player.statLifeMax2)) * LowHealthEffects.BlurAmount);
			#endregion

			#region Darken
			if (!Filters.Scene["HealthDarken"].IsActive() && LowHealthEffects.DarkenEnabled)
				Filters.Scene.Activate("HealthDarken");
			else if (!LowHealthEffects.DarkenEnabled)
				Filters.Scene.Deactivate("HealthDarken");

			if (Filters.Scene["HealthDarken"].IsActive())
				Filters.Scene["HealthDarken"].GetShader().UseProgress(((float)player.statLife / (float)player.statLifeMax2)).UseIntensity(LowHealthEffects.DarkenAmount);
			#endregion
		}
	}
}

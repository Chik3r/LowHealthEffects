using Microsoft.Xna.Framework.Graphics;
using Terraria;
using Terraria.Graphics.Effects;
using Terraria.Graphics.Shaders;
using Terraria.ID;
using Terraria.ModLoader;

namespace LowHealthEffects
{
	public class LowHealthEffects : Mod
	{
		public static bool SaturationEnabled;
		public static bool BlurEnabled;
		public static float BlurAmount;
		public static bool DarkenEnabled;
		public static float DarkenAmount;

		public override void Load()
		{
			if (Main.netMode != NetmodeID.Server)
			{
				Ref<Effect> saturationRef = new Ref<Effect>(GetEffect("Effects/HealthSaturation"));
				Filters.Scene["HealthSaturation"] = new Filter(new ScreenShaderData(saturationRef, "HealthSaturationPass"), EffectPriority.VeryHigh);

				Ref<Effect> blurRef = new Ref<Effect>(GetEffect("Effects/HealthBlur"));
				Filters.Scene["HealthBlur"] = new Filter(new ScreenShaderData(blurRef, "HealthBlurPass"), EffectPriority.VeryHigh);

				Ref<Effect> darkenRef = new Ref<Effect>(GetEffect("Effects/HealthDarken"));
				Filters.Scene["HealthDarken"] = new Filter(new ScreenShaderData(darkenRef, "HealthDarkenPass"), EffectPriority.VeryHigh);
			}
		}
	}
}
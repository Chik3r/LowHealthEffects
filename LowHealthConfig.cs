using System.ComponentModel;
using Terraria.ModLoader.Config;

namespace LowHealthEffects
{
	public class LowHealthConfig : ModConfig
	{
		public override ConfigScope Mode => ConfigScope.ClientSide;

		[Header("Saturation")]
		[DefaultValue(true)]
		[Label("Less saturation when health is low")]
		public bool SaturationEnabled;

		[Header("Blur")]
		[DefaultValue(true)]
		[Label("Blur the screen when health is low")]
		public bool BlurEnabled;

		[Range(0.005f, 0.05f)]
		[Increment(0.005f)]
		[DefaultValue(0.015f)]
		[DrawTicks]
		[Label("How much to blur the screen")]
		public float BlurAmount;

		[Header("Darken")]
		[DefaultValue(true)]
		[Label("Darken the screen when health is low")]
		public bool DarkenEnabled;

		[Range(0.1f, 0.6f)]
		[Increment(0.05f)]
		[DefaultValue(0.4f)]
		[DrawTicks]
		[Label("How much to darken the screen")]
		[Tooltip("(higher values = less darkening)")]
		public float DarkenAmount;

		public override void OnChanged()
		{
			LowHealthEffects.SaturationEnabled = SaturationEnabled;
			LowHealthEffects.BlurEnabled = BlurEnabled;
			LowHealthEffects.BlurAmount = BlurAmount;
			LowHealthEffects.DarkenEnabled = DarkenEnabled;
			LowHealthEffects.DarkenAmount = DarkenAmount;
		}
	}
}

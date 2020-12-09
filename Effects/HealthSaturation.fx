sampler uImage0 : register(s0);
sampler uImage1 : register(s1);
sampler uImage2 : register(s2);
sampler uImage3 : register(s3);
float3 uColor;
float3 uSecondaryColor;
float2 uScreenResolution;
float2 uScreenPosition;
float2 uTargetPosition;
float2 uDirection;
float uOpacity;
float uTime;
float uIntensity;
float uProgress;
float2 uImageSize1;
float2 uImageSize2;
float2 uImageSize3;
float2 uImageOffset;
float uSaturation;
float4 uSourceRect;
float2 uZoom;
  
// From: https://forum.unity.com/threads/different-blending-modes-like-add-screen-overlay-changing-hue-tint.62507/#post-413034
float3 rgb_to_hsv_no_clip(float3 RGB)
{
	float3 HSV;
		   
	float minChannel, maxChannel;
	if (RGB.x > RGB.y)
	{
		maxChannel = RGB.x;
		minChannel = RGB.y;
	}
	else
	{
		maxChannel = RGB.y;
		minChannel = RGB.x;
	}
		 
	if (RGB.z > maxChannel)
		maxChannel = RGB.z;
	if (RGB.z < minChannel)
		minChannel = RGB.z;
		   
	HSV.xy = 0;
	HSV.z = maxChannel;
	float delta = maxChannel - minChannel; //Delta RGB value
	if (delta != 0)
	{ // If gray, leave H  S at zero
		HSV.y = delta / HSV.z;
		float3 delRGB;
		delRGB = (HSV.zzz - RGB + 3 * delta) / (6.0 * delta);
		if (RGB.x == HSV.z)
			HSV.x = delRGB.z - delRGB.y;
		else if (RGB.y == HSV.z)
			HSV.x = (1.0 / 3.0) + delRGB.x - delRGB.z;
		else if (RGB.z == HSV.z)
			HSV.x = (2.0 / 3.0) + delRGB.y - delRGB.x;
	}
	return (HSV);
}

float3 hsv_to_rgb(float3 HSV)
{
	float3 RGB = HSV.z;
		   
	float var_h = HSV.x * 6;
	float var_i = floor(var_h); // Or ... var_i = floor( var_h )
	float var_1 = HSV.z * (1.0 - HSV.y);
	float var_2 = HSV.z * (1.0 - HSV.y * (var_h - var_i));
	float var_3 = HSV.z * (1.0 - HSV.y * (1 - (var_h - var_i)));
	if (var_i == 0)
	{
		RGB = float3(HSV.z, var_3, var_1);
	}
	else if (var_i == 1)
	{
		RGB = float3(var_2, HSV.z, var_1);
	}
	else if (var_i == 2)
	{
		RGB = float3(var_1, HSV.z, var_3);
	}
	else if (var_i == 3)
	{
		RGB = float3(var_1, var_2, HSV.z);
	}
	else if (var_i == 4)
	{
		RGB = float3(var_3, var_1, HSV.z);
	}
	else
	{
		RGB = float3(HSV.z, var_1, var_2);
	}
		   
	return (RGB);
}

float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0
{
	float4 color = tex2D(uImage0, coords);
	
	float3 colorHCL = rgb_to_hsv_no_clip(color.xyz); // Convert to HSL
	colorHCL.g *= uProgress; // Change the saturation
	float4 newColor = float4(hsv_to_rgb(colorHCL).rgb, color.a); // Back to RGB
	
	return newColor;
}
    
technique Technique1
{
    pass HealthSaturationPass
    {
		PixelShader = compile ps_2_0 PixelShaderFunction();
	}
}
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

float4 PixelShaderFunction(float2 coords : TEXCOORD0) : COLOR0
{
    // From: https://www.ronja-tutorials.com/2018/08/27/postprocessing-blur.html
    float invAspect = uScreenResolution.y / uScreenResolution.x;
    
    float4 col = 0.0;
    for (float index = 0; index < 10; index++)
    {
        //add color at position to color
        float2 uv = coords.xy + float2((index / 9 - 0.5) * uProgress * invAspect, 0);
        
        col += tex2D(uImage0, uv);
    }
    
    for (index = 0; index < 10; index++)
    {
        //get uv coordinate of sample
        float2 uv = coords.xy + float2(0, (index / 9 - 0.5) * uProgress);
        //add color at position to color
        col += tex2D(uImage0, uv);
    }
    
    col = col / 20.0;
    return col;
}

technique Technique1
{
    pass HealthBlurPass
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}
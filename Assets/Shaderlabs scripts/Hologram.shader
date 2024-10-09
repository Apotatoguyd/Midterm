Shader "Custom/Holograms"
{
    Properties
    {
       _MainTex ("Texture", 2D) = "White"{}
      _RimColor("Rim Color", Color) = (0,0.5,0.5,0.0)
      _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }
     
        Pass {
            ZWrite On
            ColorMask 0 
            }

        CGPROGRAM
       
        #pragma surface surf Lambert

        struct Input
        {
            float3 viewDir;
            float2 uv_MainTex;
        };

         float4 _RimColor;
         float _RimPower;
          sampler2D _MainTex;
        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = _RimColor.rgb * pow(rim, _RimPower) * 10;
            o.Alpha - pow(rim, _RimColor);
        }
        ENDCG
    }
    FallBack "Diffuse"
}

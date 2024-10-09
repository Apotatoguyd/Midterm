Shader "Custom/Toons"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _RampTex ("RampTexture", 2D) = "white"{}
        _RimColor("Rim Color", Color) = (0,0,0,0)
      _RimPower("Rim Power", Range(0.5,8.0)) = 3.0
    }
    SubShader
    {
        // Took the toons shader and slapped on the hologram to make it popout more. It works because the toons only affect the Albedo so I can add the hologram due to it being the emission.
        CGPROGRAM
        #pragma surface surf ToonRamp

        float4 _Color;
        sampler2D _RampTex;

        float4 LightingToonRamp (SurfaceOutput s, fixed3 lightDir, fixed atten)
        {            
            float diff = dot (s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float3 ramp = tex2D(_RampTex, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            c.a = s.Alpha;
            return c;

        }
 
        

            struct Input
            {
                float2 uv_MainTex;
                float3 viewDir;
            };
            float4 _RimColor;
         float _RimPower;

                void surf (Input IN, inout SurfaceOutput o)
                {
                    o.Albedo = _Color.rgb;
            half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = _RimColor.rgb * pow(rim, _RimPower) * 10;
            o.Alpha - pow(rim, _RimColor);
                    }
                   
        ENDCG
    }
    FallBack "Diffuse"
}

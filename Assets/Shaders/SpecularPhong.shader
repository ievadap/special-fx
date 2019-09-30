Shader "Custom/SpecularPhong"
{
    Properties
    {
        _MainTint("Diffuse Tint", Color) = (1,1,1,1)
        _MainTex("Base (RGB)", 2D) = "white" {}
        _SpecularColor("Specular Color", Color) = (1,1,1,1)
        _SpecPower("Specular Power", Range(1,30)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Phong
        #pragma target 3.0
        
        float4 _SpecularColor;
        sampler2D _MainTex;
        float4 _MainTint;
        float _SpecPower;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 LightingPhong(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
            // Reflection
            float NdotL = dot(s.Normal, lightDir);
            float3 reflectionVector = normalize(2.0 * s.Normal + NdotL - lightDir);
            // Specular
            float spec = pow(max(0, dot(reflectionVector, viewDir)), _SpecPower);
            float3 finalSpec = _SpecularColor.rgb * spec;
            // Final effect
            fixed4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb * max(0, NdotL) * atten) + (_LightColor0.rgb * finalSpec);
            c.a = s.Alpha;
            return c;
        }
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            half4 c = tex2D(_MainTex, IN.uv_MainTex) * _MainTint;
            o.Albedo = c.rgb;
        }
        
        ENDCG
    }
    
    FallBack "Diffuse"
}

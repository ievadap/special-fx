Shader "Custom/Specular"
{
    Properties
    {
        _MainTint("Diffuse Tint", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _SpecularColor("Specular Color", Color) = (1,1,1,1)
        _SpecPower("Specular Power", Range(1,50)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf SimpleSpecular
        #pragma target 3.0
        
        float4 _SpecularColor;
        sampler2D _MainTex;
        float4 _MainTint;
        float _SpecPower;

        struct Input
        {
            float2 uv_MainTex;
        };

        half4 LightingSimpleSpecular(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten) {
            half3 h = normalize(lightDir + viewDir);
            half diff = max(0, dot(s.Normal, lightDir));
            float spec = pow(max(0, dot(s.Normal, h)), _SpecPower);
            float3 finalSpec = _SpecularColor.rgb * spec;
            half4 c;
            c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * finalSpec) * atten;
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

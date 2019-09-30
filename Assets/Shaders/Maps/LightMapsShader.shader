Shader "Custom/LightMapsShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Power ("Light power", Range(1,5)) = 2.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 10
        
        Pass 
        {
        Lighting Off
        SeparateSpecular Off

        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        
        #include "UnityCG.cginc"
        
        uniform float4x4 loc2World;
        uniform float4x4 rotateOnly;
        uniform float4 uniCol;
        
        struct vsInput
        {
            float4 vertex : POSITION;
            float2 uv : TEXCOORD0;
            float2 uv1 : TEXCOORD1;
            float3 normal : NORMAL;
        };
        
        struct fsInput
        {
            float4 vertex : SV_POSITION;
            float2 uv : TEXCOORD0;
            float2 uv1 : TEXCOORD1;
            float3 normal : NORMAL;
        };
        
        sampler2D_half _MainTex;
        half4 _MainTex_ST;
        half4 unity_Lightmap_ST;
        half _Power;

        fsInput vert (vsInput v)
        {
           fsInput o;
           o.vertex = UnityObjectToClipPos(v.vertex);
           o.normal = UnityObjectToWorldNormal(v.normal);
           o.uv1 = v.uv1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
           o.uv = v.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
           return o;
        }
        
        fixed4 frag (fsInput i) : SV_Target
        {
           fixed4 col = tex2D(_MainTex, i.uv);
           col.rgb *= DecodeLightmap(UNITY_SAMPLE_TEX2D(unity_Lightmap, i.uv1)) * _Power;
           return col;
        }
        ENDCG
        }
    }
    FallBack "Diffuse"
}

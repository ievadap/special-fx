Shader "Unlit/Base Alpha Additive"
{
    Properties
    {
        _BaseTexture ("Base", 2D) = "" {}
        _AlphaOverlayTexture ("Alpha Overlay", 2D) = "" {}
        _AdditiveTexture ("Additive", 2D) = "" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _BaseTexture;
            sampler2D _AlphaOverlayTexture;
            sampler2D _AdditiveTexture;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 baseColor = tex2D(_BaseTexture, i.uv);
                fixed4 alphaColor = tex2D(_AlphaOverlayTexture, i.uv);
                fixed4 additiveColor = tex2D(_AdditiveTexture, i.uv);
                fixed4 color = baseColor;
                color = lerp(color, additiveColor, alphaColor.r);
                
                return color;
            }
            ENDCG
        }
    }
}

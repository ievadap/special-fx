Shader "Unlit/2"
{
    Properties
    {
        _BaseTexture ("Base", 2D) = "" {}
        _TextureA ("A", 2D) = "" {}
        _TextureB ("B", 2D) = "" {}
        _Blend ("Blend", Range(0,1)) = 0.5
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
            sampler2D _TextureA;
            sampler2D _TextureB;
            float _Blend;

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
                fixed4 color = tex2D(_BaseTexture, i.uv);
                fixed4 colorA = tex2D(_TextureA, i.uv);
                fixed4 colorB = tex2D(_TextureB, i.uv);
                fixed4 blendedColor = lerp(colorA, colorB, _Blend);
                color = lerp(color, blendedColor, blendedColor.a);

                return color;
            }
            ENDCG
        }
    }
}

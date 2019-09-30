Shader "Custom/Displacement"
{
    Properties
    {
        _Color ("Main Color", Color) = (1,1,1,1)
        _RampTex ("Color Ramp", 2D) = "white" {}
        _DispTex ("Displacement Texture", 2D) = "gray" {}
        _Displacement ("Displacement", Range(0,1.0)) = 0.1
        _ChannelFactor ("Channel Factor (r,g,b)", Vector) = (1,0,0)
        _Range ("Range (min, max)", Vector) = (0,0.5,0)
        _ClipRange ("ClipRange [0,1]", float) = 0.8
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
            "Queue"="Geometry"
        }
        Pass 
        {
            Name "FORWARD"
            Tags { "LightMode"="ForwardBase"}

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_complile_fwdbase_fullshadows
            #pragma multi_complile_fog
            #pragma target 3.0

            float4 _Color;
            sampler2D _DispTex;
            float4 _DispTex_ST;
            sampler2D _RampTex;
            float4 _RampTex_ST;
            float _Displacement;
            float3 _ChannelFactor;
            float2 _Range;
            float _ClipRange;

            struct VertexInput
            {
                float4 vertex : POSITION; // local vertex position
                float3 normal : NORMAL; // normal direction
                float4 tangent : TANGENT; // tangent direction
                float4 texcoord : TEXCOORD0; // uv coordinates
                float4 texcoord1 : TEXCOORD1; // lightmap uv coordinates
            };

            struct VertexOutput
            {
                float4 pos : SV_POSITION; // screen clip space position and depth
                float4 uv0 : TEXCOORD0; // uv coordinates
                float4 uv1 : TEXCOORD1; // lightmap uv coordinates

                // create vars with the textcoord semantic 
                float3 normalDir : TEXCOORD3; // normal dir
                float3 posWord : TEXCOORD4; // normal dir
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
            };

            VertexOutput vert (VertexInput v)
            {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                UNITY_TRANSFER_FOG(0, 0.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                float3 dcolor = tex2D(
                    _DispTex, 
                    float4(o.uv0 * _DispTex_ST.xy, 0, 0)
                );
                float d = (dcolor.r * _ChannelFactor.r + dcolor.g * _ChannelFactor.g + dcolor.b * _ChannelFactor.b);
                // TODO: finish v.vertex.xyz += v.normal 
            }

            float4 frag(VertexOutput i) : COLOR
            {

            }

            ENDCG
        }
    }
    FallBack "Diffuse"
}

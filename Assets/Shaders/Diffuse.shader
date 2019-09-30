Shader "Custom/Diffuse"
{
    Properties
    {
        //_Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        //_Glossiness ("Smoothness", Range(0,1)) = 0.5
        //_Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        //Tags { "RenderType"="Opaque" }
        Tags { "LightMode"="ForwardBase" }
        //LOD 200
        
        Pass {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            
            uniform sampler2D _MainTex;
            uniform fixed4 _LightColor0;

            struct vertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };
            
            struct vertexOutput {
                float4 pos : SV_POSITION;
                float4 color : COLOR0;
                float4 tex : TEXCOORD0;
            };
          
            vertexOutput vert(vertexInput input) {
                vertexOutput output;
                output.tex = input.texcoord;
                output.pos = UnityObjectToClipPos(input.vertex);
                float3 normalDirection = normalize(mul(float4(input.normal, 1.0), unity_WorldToObject).xyz);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float ndotl = dot(normalDirection, lightDirection);
                float3 diffuse = _LightColor0.xyz * max(0.0, ndotl);
                output.color = half4(diffuse, 1.0);
                return output;
            }
            
            float4 frag(vertexOutput input) : COLOR {
                float4 textureColor = tex2D(_MainTex, input.tex.xy) * input.color;
                return textureColor;
            }
          
            ENDCG
        }
        //CGPROGRAM
        //// Physically based Standard lighting model, and enable shadows on all light types
        //#pragma surface surf Standard fullforwardshadows

        //// Use shader model 3.0 target, to get nicer looking lighting
        //#pragma target 3.0

        //sampler2D _MainTex;

        //struct Input
        //{
        //    float2 uv_MainTex;
        //};

        //half _Glossiness;
        //half _Metallic;
        //fixed4 _Color;

        //// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        //// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        //// #pragma instancing_options assumeuniformscaling
        //UNITY_INSTANCING_BUFFER_START(Props)
        //    // put more per-instance properties here
        //UNITY_INSTANCING_BUFFER_END(Props)

        //void surf (Input IN, inout SurfaceOutputStandard o)
        //{
        //    // Albedo comes from a texture tinted by color
        //    fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
        //    o.Albedo = c.rgb;
        //    // Metallic and smoothness come from slider variables
        //    o.Metallic = _Metallic;
        //    o.Smoothness = _Glossiness;
        //    o.Alpha = c.a;
        //}
        //ENDCG
    }
    FallBack "Diffuse"
}

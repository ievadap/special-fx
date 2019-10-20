Shader "Custom/Unlit"
{
    Properties
    {
        _MainTex ("RGBA Texture Image", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            uniform sampler2D _MainTex;

            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 textcoord : TEXCOORD0;
            };

            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float4 tex : TEXCOORD0;
            };
            
            vertexOutput vert(vertexInput input)
            {
                vertexOutput output;
                output.tex = input.textcoord;
                output.pos = UnityObjectToClipPos(input.vertex);
                return output;
            }
            
            float4 frag(vertexOutput input) : COLOR {
                float4 textureColor = tex2D(_MainTex, input.tex.xy) * float4(UNITY_LIGHTMODEL_AMBIENT.rgb, 1);
                return textureColor;
            }
            
            ENDCG
        }
    }
    Fallback "Unlit/Texture"
}

Shader "EranM/Glass"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_BumpMap("Normalmap", 2D) = "bump" {}
		_ScaleUV ("Scale", Range(1,100)) = 1

	}
	SubShader
	{
		Tags{ "Queue" = "Transparent"}
		GrabPass{}
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 uvgrab : TEXCOORD1; // Grab the screen itself based on the resolution. Need to generate new UVS that only 
										   // grab a small part of that texture and put it into the object
				float2 uvbump : TEXCOORD2; // Same thing for the bump texture. Grab a small part of it
				float4 vertex : SV_POSITION;
			};

			sampler2D _GrabTexture;
			float4 _GrabTexture_TexelSize; // The pixel's size that are in the texture
			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _BumpMap;
			float4 _BumpMap_ST;
			float _ScaleUV;
			
			v2f vert (appdata v)
			{
				v2f o;
				// The two lines below:
				// Take the vertices from the object that we are calculating by putting it down from world space into clip space
				// Then, basing on where it positions itself within the screen space, it calculates what the UVs for the grab texture
				o.vertex = UnityObjectToClipPos(v.vertex);
				#if UNITY_UV_STARTS_AT_TOP
					float scale = -1.0;
				#else
					float scale = 1.0;
				#endif
				o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y * scale) + o.vertex.w) * 0.5;
				o.uvgrab.zw = o.vertex.zw;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvbump = TRANSFORM_TEX(v.uv, _BumpMap);
				return o;
			}
			
			fixed4 frag(v2f i) : SV_Target
			{
				half2 bump = UnpackNormal(tex2D(_BumpMap, i.uvbump)).rg;
				float2 offset = bump * _ScaleUV * _GrabTexture_TexelSize.xy;
				i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;

				fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab)); // Calculate the UVgrab correctly
				fixed4 tint = tex2D(_MainTex, i.uv);
				col *= tint;
				return col;
			}
			ENDCG
		}
	}
}

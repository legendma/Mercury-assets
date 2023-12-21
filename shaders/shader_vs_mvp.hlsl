#include "common.hlsli"


cbuffer cbPerObject : register(b0)
    {
    float4x4 g_mvp;
    };

void vs_main( VertexIn vin,
              out float4 out_pos : SV_Position,
              out float4 out_color : COLOR )
{
out_pos = mul( float4( vin.pos, 1.0f ), g_mvp );
out_color = float4( 1.0f, 1.0f, 1.0f, 1.0f );
    
} /* vs_main() */
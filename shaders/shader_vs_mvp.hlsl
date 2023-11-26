
cbuffer cbPerObject : register(b0)
    {
    float4x4 g_mvp;
    };

void vs_main( float3 in_pos : POSITION,
              float4 in_color : COLOR,
              out float4 out_pos : SV_Position,
              out float4 out_color : COLOR )
{
out_pos = mul( float4( in_pos, 1.0f ), g_mvp );
out_color = in_color;
    
} /* vs_main() */
#version 450
#pragma shader_stage( vertex )

#extension GL_ARB_separate_shader_objects : enable

layout( set = 2, binding = 0 ) uniform UBO
	{
	vec4 sp_mvp_x;
	vec4 sp_mvp_y;
	vec4 sp_mvp_z;
	vec4 sp_mvp_w;
	};

layout( location = 0 ) in vec2 in_Position;
layout( location = 1 ) in vec2 in_TexCoord;
	
layout( location = 0 ) out vec2 out_TexCoord0;

void main() {
	vec4 position = vec4( in_Position.xy, 0.0, 1.0 );
	gl_Position.x = dot( position, sp_mvp_x );
	gl_Position.y = dot( position, sp_mvp_y );
	gl_Position.z = dot( position, sp_mvp_z );
	gl_Position.w = dot( position, sp_mvp_w );
	
	out_TexCoord0 = in_TexCoord;
}
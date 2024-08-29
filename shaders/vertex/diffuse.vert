#version 450
#pragma shader_stage( vertex )

#extension GL_ARB_separate_shader_objects : enable

layout( set = 2, binding = 0 ) uniform UBO
	{
	vec4 sp_model_x;
	vec4 sp_model_y;
	vec4 sp_model_z;
	vec4 sp_model_w;
	vec4 sp_mvp_x;
	vec4 sp_mvp_y;
	vec4 sp_mvp_z;
	vec4 sp_mvp_w;
	};

layout( location = 0 ) in vec3 in_Position;
layout( location = 1 ) in vec2 in_TexCoord;
layout( location = 2 ) in vec3 in_Normal;
	
layout( location = 0 ) out vec2 out_TexCoord0;
layout( location = 1 ) out vec3 out_Normal;

void main() {
	vec4 position = vec4( in_Position, 1.0f );
	gl_Position.x = dot( position, sp_mvp_x );
	gl_Position.y = dot( position, sp_mvp_y );
	gl_Position.z = dot( position, sp_mvp_z );
	gl_Position.w = dot( position, sp_mvp_w );

	vec4 normal = vec4( in_Normal, 0.0f );
	out_Normal.x = dot( normal, sp_model_x );
	out_Normal.y = dot( normal, sp_model_y );
	out_Normal.z = dot( normal, sp_model_z );
	
	out_TexCoord0 = in_TexCoord;
}
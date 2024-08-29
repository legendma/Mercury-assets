#version 450
#pragma shader_stage( fragment )

#extension GL_ARB_separate_shader_objects : enable

layout( set = 0, binding = 0 ) uniform UBO_GLOBALS
	{
	float one_over_gamma;
	};

layout( set = 1, binding = 0 ) uniform UBO
	{
	vec3 sp_light_dir;
	};

layout( set = 1, binding = 1 ) uniform sampler2D texture0;

layout( location = 0 ) in vec2 in_uv0;
layout( location = 1 ) in vec3 in_normal;

layout( location = 0 ) out vec4 out_color;

void main()
{
	const float AMBIENT_CONTRIB = 0.1f;
	float diffuse_term = max( dot( in_normal, -sp_light_dir ), AMBIENT_CONTRIB );
	diffuse_term = pow( diffuse_term, one_over_gamma );
	out_color = diffuse_term * texture( texture0, in_uv0.xy );
}
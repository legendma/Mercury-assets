#version 450
#pragma shader_stage( fragment )

#extension GL_ARB_separate_shader_objects : enable

layout( set = 2, binding = 1 ) uniform UBO
	{ 
	vec4 mod_color;
	};

layout( set = 1, binding = 0 ) uniform sampler2D texture0;

layout( location = 0 ) in vec2 in_uv0;

layout( location = 0 ) out vec4 out_color;

void main() {
	vec4 tex_color = texture( texture0, in_uv0.xy );
	out_color = mod_color * tex_color;
}
#version 450
#pragma shader_stage( fragment )

#extension GL_ARB_separate_shader_objects : enable

layout( set = 2, binding = 1 ) uniform abra { 
	vec4 rpColor;
};

layout(binding = 0) uniform sampler2D tex;

layout( location = 0 ) out vec4 out_Color;

void main() {
	vec4 texel = texture(tex, rpColor.xy);
	out_Color = texel * rpColor;
}
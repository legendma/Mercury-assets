#version 450
#pragma shader_stage( vertex )

#extension GL_ARB_separate_shader_objects : enable

layout( set = 2, binding = 2 ) uniform my_uniform {
	vec4 rpMVPmatrixX;
	vec4 rpMVPmatrixY;
	vec4 rpMVPmatrixZ;
	vec4 rpMVPmatrixW;
	vec2 mod;
};

layout( set = 1, binding = 6 ) uniform happen_uniform {
	vec3 happened;
};

layout( location = 0 ) in vec3 in_Position;

void main() {
	vec4 position = vec4( in_Position, 1.0 );
	gl_Position.x = dot( position, rpMVPmatrixX );
	gl_Position.y = dot( position, rpMVPmatrixY );
	gl_Position.z = dot( position, rpMVPmatrixZ );
	gl_Position.w = dot( position, rpMVPmatrixW );

	gl_Position.xy * mod;
}
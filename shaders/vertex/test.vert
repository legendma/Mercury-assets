#version 450
#pragma shader_stage( vertex )

#extension GL_ARB_separate_shader_objects : enable

layout( set = 2, binding = 0 ) uniform UBO {
	vec4 rpMVPmatrixX;
	vec4 rpMVPmatrixY;
	vec4 rpMVPmatrixZ;
	vec4 rpMVPmatrixW;
};

layout( location = 0 ) in vec3 in_Position;

void main() {
	vec4 position = vec4( in_Position, 1.0 );
	gl_Position.x = dot( position, rpMVPmatrixX );
	gl_Position.y = dot( position, rpMVPmatrixY );
	gl_Position.z = dot( position, rpMVPmatrixZ );
	gl_Position.w = dot( position, rpMVPmatrixW );
}
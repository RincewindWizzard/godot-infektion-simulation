shader_type canvas_item;

uniform float radius;

const vec2 ZERO = vec2(0.);
const vec4 TRANSPARENT = vec4(0.);
const mat4 transform_coords = mat4(
	vec4(1., 0., 0., 0.),
	vec4(0., 1., 0., 0.),
	vec4(0., 0., 1., 0.),
	vec4(0., 0., 0., 1.)
);

vec3 hsv2rgb(float h, float s, float v) {
	vec3 c = vec3(h, s, v);
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

mat3 transform_mat(vec2 translate, vec2 scale, float angle) {
	return mat3(
		vec3(scale.x,      0., translate.x),
		vec3(	  0., scale.y, translate.y),
		vec3(     0.,      0.,          1.)
	);
}

vec2 transform_coord(mat3 mat, vec2 pos) {
	vec3 transformed = vec3(pos, 1.) * mat;
	return transformed.xy;
}

vec2 transform_coord_inv(mat3 mat, vec2 pos) {
	vec3 transformed = vec3(pos, 1.) * inverse(mat);
	return transformed.xy;
}

float angle(vec2 p) {
	return atan(p.x, p.y);
}

float normalize_radian(float phi) {
	return phi / (2.0 * PI) + 0.5;
}


void fragment() {
	mat3 transformat_mat = transform_mat(vec2(0.5), vec2(0.5), 0.);
	vec2 pos = transform_coord_inv(transformat_mat, UV);
	float dist = step(1, distance(ZERO, pos));
	float phi = normalize_radian(angle(pos));
	vec4 background = vec4(hsv2rgb(phi, 1., 1.), 1.);
	
	
	COLOR = mix(background, TRANSPARENT, dist);
}


shader_type spatial;

render_mode blend_mix, depth_draw_always,cull_back,diffuse_burley,specular_schlick_ggx;

uniform vec3 player_pos;
uniform vec3 water_color:source_color=vec3(0.05,0.08,0.05);
uniform float wave_height=0.15;

void vertex() {
	
	vec3 world_pos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;
	float ambient_wave=sin(world_pos.x*2.0+TIME*1.5)*cos(world_pos.z*2.0+TIME*1.5)*0.03;
	float dist=distance(world_pos,vec3(player_pos.x,world_pos.y,player_pos.z));
	float player_wave=0.0;
	if (dist<3.0){
		player_wave=sin((dist*10.0)-(TIME*8.0))*(1.0-(dist/3.0))*wave_height;
	}
	VERTEX.y+=ambient_wave+player_wave;
}

void fragment() {
	ALBEDO=water_color;
	ROUGHNESS=0.1;
	METALLIC=0.8;
	ALPHA=0.8;
}

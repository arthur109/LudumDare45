shader_type canvas_item;
uniform float distortion_speed;
uniform float distortion_scale;

vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

void fragment(){
	vec2 pos = SCREEN_UV;
//	TIME*3.0+SCREEN_UV.y*10.0)*0.01
	pos.x = pos.x+ noise(vec2(SCREEN_UV.x+TIME*distortion_speed,SCREEN_UV.y+TIME*distortion_speed)*5.0)*distortion_scale;
	pos.y = pos.y+ (noise(vec2(SCREEN_UV.x+TIME*distortion_speed,SCREEN_UV.y+TIME*distortion_speed)*5.0)-0.5)*distortion_scale;
	vec4 behindColor = textureLod(SCREEN_TEXTURE,pos, 0.0);
	COLOR = vec4(behindColor.g,behindColor.r*0.5,behindColor.b,1);
//	COLOR = vec4(vec3(UV.x),1);
}
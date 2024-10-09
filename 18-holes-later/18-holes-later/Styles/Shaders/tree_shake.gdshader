shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_burley, specular_schlick_ggx;

uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;
uniform float wave_amount : hint_range(0.0, 0.5) = 0.02;
uniform float wave_speed : hint_range(0.1, 5.0) = 1.0;
uniform float wave_height_start : hint_range(0.0, 1.0) = 0.5;

varying float random_offset;

void vertex() {
    // Generate a random offset based on the object's position
    random_offset = fract(sin(dot(MODEL_MATRIX[3].xyz, vec3(12.9898, 78.233, 45.5432))) * 43758.5453);
    
    // Calculate the wave effect with random offset
    float wave = sin((TIME + random_offset * 10.0) * wave_speed + UV.y * 10.0) * wave_amount;
    
    // Calculate how much the vertex should move based on its height
    float height_factor = smoothstep(wave_height_start, 1.0, UV.y);
    
    // Apply the wave only to the x-axis, scaled by height
    VERTEX.x += wave * (1.0 - height_factor);
    
    // Apply billboard transformation
    MODELVIEW_MATRIX = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
    MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0), vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0), vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
    MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

void fragment() {
    vec4 albedo_tex = texture(texture_albedo, UV);
    ALBEDO = albedo_tex.rgb;
    ALPHA = albedo_tex.a;
}
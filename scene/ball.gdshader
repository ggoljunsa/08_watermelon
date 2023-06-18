shader_type canvas_item;

void fragment() {
    vec2 center = vec2(0.5, 0.5);
    float radius = 0.5;
    float dist = distance(center, UV);
    
    if (dist > radius) {
        discard;
    }
}

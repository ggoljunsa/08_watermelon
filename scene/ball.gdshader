shader_type canvas_item;

uniform float radius : hint_range(0.0, 1.0) = 0.5;
uniform float outline_thickness : hint_range(0.0, 1.0) = 0.08;
uniform vec4 circle_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); // White

void fragment() {
    float distance_from_center = distance(UV, vec2(0.5, 0.5));
    
    if (distance_from_center < radius && distance_from_center > (radius - outline_thickness)) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0); // Black Outline
    } else if (distance_from_center <= (radius - outline_thickness)) {
        
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0); // Transparent Outside
    }
}

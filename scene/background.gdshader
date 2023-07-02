shader_type canvas_item;

// Define the size of the blur. The higher the number, the more blurred it will be, but also the more performance heavy.
uniform float size : hint_range(0.0, 50.0) = 10.0;

// Pre-computed Gaussian weights for a kernel of size 5. These would ideally be calculated at runtime for larger kernels.
const float kernel[5] = float[](0.120985, 0.233036, 0.293068, 0.233036, 0.120985);

void fragment() {
	vec4 color_sum = vec4(0.0);
	float texel_size = 1.0 / float(textureSize(TEXTURE, 0).x);
	float weight_sum = 0.0;
	
	// Horizontal blur
	for (int i = -2; i <= 2; i++) {
		vec2 offset = vec2(texel_size * size * float(i), 0.0);
		color_sum += texture(TEXTURE, UV + offset) * kernel[i + 2];
		weight_sum += kernel[i + 2];
	}
	
	COLOR = color_sum / weight_sum;
}

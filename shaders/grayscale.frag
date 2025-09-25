// shaders/grayscale.frag
#version 460 core
#include <flutter/runtime_effect.glsl>

out vec4 fragColor;

// The size of the screen, not the clipped area.
uniform vec2 uScreenSize;
uniform sampler2D uTexture;

void main() {
    // Normalize the screen coordinate to get the correct texture coordinate.
    vec2 coord = FlutterFragCoord().xy / uScreenSize;
    vec4 color = texture(uTexture, coord);
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    fragColor = vec4(vec3(gray), color.a);
}

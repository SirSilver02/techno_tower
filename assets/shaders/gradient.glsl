vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    if (texture_coords.x >= 0.5)
    {    
        return vec4(1.0, 1.0, 1.0, 1.0 - (smoothstep(0.5, 1.0, texture_coords.x))) * color;
    }
    
    return color;
}
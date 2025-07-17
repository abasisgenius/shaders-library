//
//  dotMatrix.metal
//  LearnMetalShaders
//
//  Created by Mohammed Abbas Mahin on 17/07/2025.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 dotMatrix(float2 position, half4 color, float spacing, float dotSize, float isCircle) {
    bool show;

    if (isCircle < 0.5) {
        show = fmod(position.x, spacing) < dotSize && fmod(position.y, spacing) < dotSize;
    } else {
        float2 center = float2(floor(position.x / spacing) + 0.5, floor(position.y / spacing) + 0.5) * spacing;
        float dist = distance(position, center);
        show = dist < dotSize;
    }

    return show ? color : half4(0, 0, 0, 0);
}



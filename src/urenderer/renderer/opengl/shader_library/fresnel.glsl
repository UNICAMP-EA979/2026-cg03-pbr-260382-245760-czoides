#ifndef LIBRARY_FRESNEL

/// Calcula a refletância de Fresnel
vec3 fresnelReflectance(vec3 baseColor, float metallic, vec3 halfAngle, vec3 lightDirection)
{
    vec3 f0 = mix(vec3(0.04), baseColor, metallic);
    float lighthalf = max(dot(halfAngle, lightDirection), 0.0f);
    return f0 + (1-f0)*pow((1-lighthalf), 5);
}

#define LIBRARY_FRESNEL
#endif
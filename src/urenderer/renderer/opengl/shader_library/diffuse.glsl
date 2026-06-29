#ifndef LIBRARY_DIFUSE

#define PI 3.14159265359

//Calcula a refletância difusa da superfície utilizando o modelo de Lambert
vec3 diffuseReflectance(vec3 fresnel, vec3 baseColor, float metallic)
{
    vec3 diffuse = (1.0 - fresnel) * baseColor / PI;
    return diffuse * (1.0 - metallic);
}

#define LIBRARY_DIFUSE
#endif
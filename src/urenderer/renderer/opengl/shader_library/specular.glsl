#ifndef LIBRARY_SPECULAR

#define PI 3.14159265359

//Calcula a refletância especular da superfície utilizando o modelo de Blinn-Phong
vec3 specularReflectance(vec3 fresnel, vec3 normal, vec3 halfAngle, vec3 viewDirection, vec3 LightDirection, float roughness)
{
    float smoothness = 1 - roughness;
    float alpha = pow(8192, smoothness);

    float normalhalf = max(dot(halfAngle, normal), 0);
    float normalview = max(dot(viewDirection, normal), 0.001);

    return (fresnel * (alpha + 2)/8 * pow(normalhalf, alpha)  / normalview);

}

#define LIBRARY_SPECULAR
#endif
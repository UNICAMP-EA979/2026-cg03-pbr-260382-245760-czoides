#ifndef LIBRARY_LIGHT

const int LIGHT_UNSET = 0;
const int LIGHT_DIRECTIONAL = 1;
const int LIGHT_POINT = 2;
const float R_MIN = 0.05;

struct Light
{
    int type;
    vec3 color;
    float intensity;
    vec3 direction; //Only directional
    vec3 position; //Only point
    float reference_distance; //Only point
};

// Calcula a atenuação da luz

vec3 computeLightDirection(Light light, vec3 position);

float computeLightAttenuation(Light light, vec3 position)
{
    float fdist = pow((light.reference_distance/max(length(light.position - position), 0.0001)), 2);
    float fdir = 1.0;
    if(light.type == LIGHT_DIRECTIONAL)
    {
        fdir = max(dot(computeLightDirection(light, position),light.direction), 0);
    }
    return  light.intensity * fdist * fdir;
}

//Calcula a direção da luz
vec3 computeLightDirection(Light light, vec3 position)
{
    return(normalize(light.position - position));
}

#define LIBRARY_LIGHT
#endif
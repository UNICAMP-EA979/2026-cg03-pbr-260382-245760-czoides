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
    if(light.type == LIGHT_DIRECTIONAL)
        return light.intensity;

    float r = length(light.position - position);
    return light.intensity * pow(light.reference_distance / max(r, R_MIN), 2.0);

    //float fdist = pow((light.reference_distance/max(length(light.position - position), R_MIN)), 2);
    //float fdir = 1.0;
    //if(light.type == LIGHT_DIRECTIONAL)
    //{
        //fdir = max(dot(computeLightDirection(light, position),light.direction), 0);
    //}
    //return  light.intensity * fdist * fdir;
}

//Calcula a direção da luz
vec3 computeLightDirection(Light light, vec3 position)
{
    if(light.type == LIGHT_DIRECTIONAL)
        return normalize(light.direction);

    return normalize(light.position - position);
    //return(normalize(light.position - position));
    //return(normalize(light.direction));
}

#define LIBRARY_LIGHT
#endif
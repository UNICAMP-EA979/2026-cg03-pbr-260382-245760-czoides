#version 330 core

#include "light.glsl"
#include "fresnel.glsl"
#include "diffuse.glsl"

#define MAX_LIGHT 10
#define PI 3.14159265359

// Adicione luz difusa ao modelo de sombreamento

in vec3 worldPosition;
in vec3 worldNormal;
in vec3 cameraPos;
out vec4 FragColor;

uniform Light lights[MAX_LIGHT];
void main()
{
    // Calcule a normal do fragmento
    vec3 worldNormalNormalized = normalize(worldNormal);

    //Calcula a direção de visualização (saindo do ponto)
    vec3 viewDirection = normalize(cameraPos - worldPosition);

    vec3 baseColor = vec3(0.5, 0.2, 0.5);
    float metallic = 0;

    vec3 color = vec3(0);
    for(int i = 0; i < MAX_LIGHT; i++)
    {
        Light light = lights[i];
        if(light.type == LIGHT_UNSET)
        {
            break;
        }

        //Calcule dados da luz (atenuação, cor, direção)
        float attenuation = computeLightAttenuation(light, worldPosition);
        vec3 lightColor = light.color;
        vec3 lightDirection = computeLightDirection(light, worldPosition);


        //Calcule o half-angle
        float lightnormal = max(dot(lightDirection, worldNormalNormalized), 0.0f);
        vec3 halfAngle = normalize(lightDirection + viewDirection);

        //Calcule as refletância de fresnel e difusa
        vec3 fresnel = fresnelReflectance(baseColor, metallic, halfAngle, lightDirection);
        vec3 diffuse = diffuseReflectance(fresnel, baseColor, metallic);

        //Calcule a refletância final
        vec3 reflectance = diffuse;

        //Calcule a contribuição da luz e acumule na color
        vec3 lightContribution = reflectance * lightnormal * lightColor * attenuation;
        color += lightContribution * PI;
    }

    // Atribua a color para a cor do fragmento
    FragColor = vec4(color, 1.0);
}

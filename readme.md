#### `p0/Reflective/Bumped Specular SMap`
The most used shader in this game

| Name             | Label                       | Type              | Default Value     | Notes                                                                                                  | Mapping (KHR_materials_pbrSpecularGlossiness)                                               |
| :--------------- | :-------------------------- | :---------------- | :---------------- | :----------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `_Color`         | `"Main Color"`              | `Color`           | `(1,1,1,1)`       |                                                                                                        | `diffuseFactor = _Color`                                                                    |
| `_BaseTintColor` | `"Tint Color"`              | `Color`           | `(1,1,1,1)`       |                                                                                                        | *see `_TintMask`*                                                                           |
| `_SpecMap`       | `"GlossMap"`                | `2D`              | `"white" {}`      | Glossiness map                                                                                         | `specularGlossinessTexture.a = _SpecMap.r`                                                  |
| `_SpecColor`     | `"Specular Color"`          | `Color`           | `(0.5,0.5,0.5,1)` |                                                                                                        | `specularFactor.xyz = _SpecColor.xyz`                                                       |
| `_Glossness`     | `"Specularness"`            | `Range(0.01, 10)` | `1`               | Specular multiplier, non-linear                                                                        | `specularFactor.xyz *= _Glossness`                                                          |
| `_Specularness`  | `"Glossness"`               | `Range(0.01, 10)` | `0.078125`        | Glossiness multiplier, non-linear                                                                      | `glossinessFactor = _Specularness`                                                          |
| `_ReflectColor`  | `"Reflection Color"`        | `Color`           | `(1,1,1,0.5)`     | Reflection cubemap color                                                                               | *discard*                                                                                   |
| `_MainTex`       | `"Base (RGB) Specular (A)"` | `2D`              | `"white" {}`      |                                                                                                        | `diffuseTexture.rgb = _MainTex.rgb` `specularGlossinessTexture.rgb = _MainTex.a`            |
| `_Cube`          | `"Reflection Cubemap"`      | `Cube`            | `"" {}`           | The cubemap reflection is added on top of the glossiness reflection                                    | *discard*                                                                                   |
| `_HasTint`       | `"Has tint"`                | `Float`           | `0`               | If the value is `1` then should perform the tint mask logic                                            | *see `_TintMask`*                                                                           |
| `_TintMask`      | `"Tint mask"`               | `2D`              | `"black" {}`      |                                                                                                        | `diffuseTexture.rgb = lerp(diffuseTexture.rgb, _MainTex.rgb * _BaseTintColor, _TintMask.r)` |
| `_BumpMap`       | `"Normalmap"`               | `2D`              | `"bump" {}`       |                                                                                                        | `normalTexture = _BumpMap`                                                                  |
| `_SpecVals`      | `"Specular Vals"`           | `Vector`          | `(1.1,2,0,0)`     | Another specular multiplier. (X) is the main, (Y) is multiplier at grazing angles, fresnel-like effect | `specularFactor.xyz *= _SpecVals.x`                                                         |
| `_DefVals`       | `"Defuse Vals"`             | `Vector`          | `(0.5,0.7,0,0)`   | Diffuse multiplier. (X) is the main multiplier and (Y) is multiplier at grazing angles                 | `diffuseFactor.rgb *= _DefVals.x`                                                           |


#### `p0/Reflective/Bumped Specular`
The main difference from the `SMap` version, is that it doesn't have the `_SpecMap` property, which is the **glossiness** map. This shader has uniform glossiness.

| Name            | Label                          | Type              | Default Value     | Notes                                                                                                     | Mapping (KHR_materials_pbrSpecularGlossiness)                                                   |
| :-------------- | :----------------------------- | :---------------- | :---------------- | :-------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `_Color`        | `"Main Color"`                 | `Color`           | `(1,1,1,1)`       |                                                                                                           | `diffuseFactor = _Color`                                                                        |
| `_SpecColor`    | `"Specular Color"`             | `Color`           | `(0.5,0.5,0.5,1)` |                                                                                                           | `specularFactor.xyz = _SpecColor.xyz`                                                           |
| `_SpecPower`    | `"Specular Power"`             | `Range(0.01, 10)` | `1`               | Glossiness multiplier *and* Specular multiplier. 0-1 is glossiness and 0-10 is specular.                  | `specularGlossinessTexture.a = _SpecPower * _Shininess` `specularFactor.xyz *= _SpecPower / 10` |
| `_Shininess`    | `"Shininess"`                  | `Range(0.01, 1)`  | `0.078125`        | Glossiness multiplier                                                                                     | `specularGlossinessTexture.a = _SpecPower * _Shininess`                                         |
| `_ReflectColor` | `"Reflection Color"`           | `Color`           | `(1,1,1,0.5)`     | Reflection cubemap color                                                                                  | *discard*                                                                                       |
| `_MainTex`      | `"Base (RGB) RefStrGloss (A)"` | `2D`              | `"white" {}`      | `RefStrGloss (A)` channel is the specular intensity map; *and* the Reflection Cubemap Strength map        | `diffuseTexture.rgb = _MainTex.rgb` `specularGlossinessTexture.rgb = _MainTex.a`                |
| `_Cube`         | `"Reflection Cubemap"`         | `Cube`            | `"" {}`           | The cubemap reflection is added on top of the glossiness reflection                                       | *discard*                                                                                       |
| `_BumpMap`      | `"Normalmap"`                  | `2D`              | `"bump" {}`       |                                                                                                           | `normalTexture = _BumpMap`                                                                      |
| `_SpecVals`     | `"Specular Vals"`              | `Vector`          | `(1.1,2,0,0)`     | Strength of Reflection Cubemap. (X) is the main, (Y) is multiplier at grazing angles, fresnel-like effect | *discard*                                                                                       |
| `_DefVals`      | `"Defuse Vals"`                | `Vector`          | `(0.5,0.7,0,0)`   | Diffuse multiplier. (X) is the main multiplier and (Y) is multiplier at grazing angles                    | `diffuseFactor.rgb *= _DefVals.x`                                                               |


#### `p0/Cutout/Bumped Diffuse`
This shader supports transparency

| Name        | Label                    | Type          | Default Value   | Notes              | Mapping (KHR_materials_pbrSpecularGlossiness)   |
| :---------- | :----------------------- | :------------ | :-------------- | :----------------- | ----------------------------------------------- |
| `_Color`    | `"Main Color"`           | `Color`       | `(1,1,1,1)`     |                    | `diffuseFactor = _Color`                        |
| `_MainTex`  | `"Base (RGB) Trans (A)"` | `2D`          | `"white" {}`    |                    | `diffuseTexture.rgba = _MainTex.rgba`           |
| `_BumpMap`  | `"Normalmap"`            | `2D`          | `"bump" {}`     |                    | `normalTexture = _BumpMap`                      |
| `_Cutoff`   | `"Alpha cutoff"`         | `Range(0, 1)` | `0.5`           |                    | `alphaMode = "MASK"` `alphaCutoff = _Cutoff` |
| `_SpecVals` | `"Specular Vals"`        | `Vector`      | `(0.35,2,0,0)`  | Seems to be unused | *discard*                                       |
| `_DefVals`  | `"Defuse Vals"`          | `Vector`      | `(0.1,2.5,0,0)` |                    | `diffuseFactor.rgb *= _DefVals.x`               |


#### `Cloth/ClothShader`
Designed to be animated, flapping in the wind

| Name                              | Label                    | Type           | Default Value | Notes                                                                             | Mapping (pbrMetallicRoughness)                     |
| :-------------------------------- | :----------------------- | :------------- | :------------ | :-------------------------------------------------------------------------------- | -------------------------------------------------- |
| `_Color`                          | `"Main Color"`           | `Color`        | `(1,1,1,1)`   |                                                                                   | `baseColorFactor = _Color`                         |
| `_MainTex`                        | `"Base (RGB)"`           | `2D`           | `"white" {}`  |                                                                                   | `baseColorTexture.rgb = _MainTex.rgb`              |
| `_GlossMap`                       | `"Gloss map"`            | `2D`           | `"white" {}`  |                                                                                   | `metallicRoughnessTexture.g = 1 - _GlossMap.r`     |
| `_NoiseTex`                       | `"Vertex Noise texture"` | `2D`           | `"grey" {}`   | the scrolling texture                                                             |                                                    |
| `_NormalMap1`                     | `"NormalMap"`            | `2D`           | `"bump1" {}`  |                                                                                   | `normalTexture = _NormalMap1`                      |
| `_NormalMap2`                     | `"NormalMap"`            | `2D`           | `"bump2" {}`  | normal map for the scrolling texture                                              |                                                    |
| `_NormalsMask`                    |                          |                |               |                                                                                   |                                                    |
| `_CutoutMask`                     |                          |                |               |                                                                                   | `diffuseTexture.a = _CutoutMask.a`                 |
| `_CutoutMaskUVScale`              |                          |                |               |                                                                                   |                                                    |
| `_Glossiness`                     | `"Smoothness"`           | `Range(-1, 1)` | `0.5`         | actual range that affect the visuals is `(0, 1)`, despite the property definition | `roughnessFactor = 1 - _Glossiness`                |
| `_Metallic`                       | `"Metallic"`             | `Range(-1, 1)` | `0`           | weird range but seems to be used fully                                            | `metallicRoughnessTexture.b = (_Metallic + 1) / 2` |
| `_ScrollXSpeed`                   |                          |                |               |                                                                                   |                                                    |
| `_ScrollYSpeed`                   |                          |                |               |                                                                                   |                                                    |
| `_ScrollSpeedRandomFactor`        |                          |                |               |                                                                                   |                                                    |
| `_NormalBlendingRandomFactor`     |                          |                |               |                                                                                   |                                                    |
| `_VertexTimeOffset`               |                          |                |               |                                                                                   |                                                    |
| `_NormalBlendThreshold`           |                          |                |               |                                                                                   |                                                    |
| `_VertexAnimationScale`           |                          |                |               |                                                                                   |                                                    |
| `_VertexAnimationSpeedMultiplier` |                          |                |               |                                                                                   |                                                    |
| `_CutOff`                         |                          |                |               |                                                                                   |                                                    |

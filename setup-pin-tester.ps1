# Script para crear el shield pin_tester automáticamente
# Ejecuta este script en la raíz de tu zmk-config

$baseDir = "config\boards\shields\pin_tester"

# Crear directorio
New-Item -ItemType Directory -Force -Path $baseDir | Out-Null

# Kconfig.shield
$kconfigShield = @"
config SHIELD_PIN_TESTER
    def_bool `$(shields_list_contains,pin_tester)
"@
Set-Content -Path "$baseDir\Kconfig.shield" -Value $kconfigShield

# Kconfig.defconfig
$kconfigDefconfig = @"
if SHIELD_PIN_TESTER

config ZMK_KEYBOARD_NAME
    default "Pin Tester"

endif
"@
Set-Content -Path "$baseDir\Kconfig.defconfig" -Value $kconfigDefconfig

# pin_tester.overlay
$overlay = @"
/ {
    chosen {
        zmk,kscan = &kscan0;
    };

    kscan0: kscan {
        compatible = "zmk,kscan-gpio-direct";
        wakeup-source;

        input-gpios
            = <&gpio0 2 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 0
            , <&gpio0 3 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 1
            , <&gpio0 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 2
            , <&gpio0 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 3
            , <&gpio0 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 4
            , <&gpio0 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 5
            , <&gpio0 8 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 6
            , <&gpio0 11 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 7
            , <&gpio0 12 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 8
            , <&gpio0 14 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 9
            , <&gpio0 15 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 10
            , <&gpio0 16 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 11
            , <&gpio0 17 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 12
            , <&gpio0 20 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 13
            , <&gpio0 22 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 14
            , <&gpio0 26 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 15
            , <&gpio0 29 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 16
            , <&gpio0 30 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 17
            , <&gpio0 31 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 18
            , <&gpio1 1 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 19
            , <&gpio1 2 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 20
            , <&gpio1 3 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 21
            , <&gpio1 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 22
            , <&gpio1 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 23
            , <&gpio1 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 24
            , <&gpio1 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 25
            , <&gpio1 9 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>   // Pin 26
            , <&gpio1 10 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 27
            , <&gpio1 11 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 28
            , <&gpio1 13 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 29
            , <&gpio1 15 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>  // Pin 30
            ;
    };
};
"@
Set-Content -Path "$baseDir\pin_tester.overlay" -Value $overlay

# pin_tester.keymap
$keymap = @"
#include <behaviors.dtsi>
#include <dt-bindings/zmk/keys.h>

/ {
    keymap {
        compatible = "zmk,keymap";

        default_layer {
            bindings = <
                &kp N1    // P0.02
                &kp N2    // P0.03
                &kp N3    // P0.04
                &kp N4    // P0.05
                &kp N5    // P0.06
                &kp N6    // P0.07
                &kp N7    // P0.08
                &kp N8    // P0.11
                &kp N9    // P0.12
                &kp N0    // P0.14
                &kp Q     // P0.15
                &kp W     // P0.16
                &kp E     // P0.17
                &kp R     // P0.20
                &kp T     // P0.22
                &kp Y     // P0.26
                &kp U     // P0.29
                &kp I     // P0.30
                &kp O     // P0.31
                &kp P     // P1.01
                &kp A     // P1.02
                &kp S     // P1.03
                &kp D     // P1.04
                &kp F     // P1.05
                &kp G     // P1.06
                &kp H     // P1.07
                &kp J     // P1.09
                &kp K     // P1.10
                &kp L     // P1.11
                &kp Z     // P1.13
                &kp X     // P1.15
            >;
        };
    };
};
"@
Set-Content -Path "$baseDir\pin_tester.keymap" -Value $keymap

# build.yaml
$buildYaml = @"
# Este archivo genera todos tus builds automáticamente.
# Añade tu nuevo shield pin_tester aquí.

include:
  - board: nice_nano_v2
    shield: pin_tester
"@
Set-Content -Path "build.yaml" -Value $buildYaml

Write-Host "✅ Shield pin_tester creado exitosamente!" -ForegroundColor Green
Write-Host ""
Write-Host "Archivos creados en:" -ForegroundColor Cyan
Write-Host "  - $baseDir\Kconfig.shield"
Write-Host "  - $baseDir\Kconfig.defconfig"
Write-Host "  - $baseDir\pin_tester.overlay"
Write-Host "  - $baseDir\pin_tester.keymap"
Write-Host "  - build.yaml (actualizado)"
Write-Host ""
Write-Host "Ahora ejecuta:" -ForegroundColor Yellow
Write-Host "  zmk build"
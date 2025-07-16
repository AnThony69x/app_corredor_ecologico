#!/bin/bash

echo "========================================"
echo "   Instalacion de Corredor Ecologico"
echo "========================================"
echo

echo "[1/5] Verificando Flutter..."
if ! command -v flutter &> /dev/null; then
    echo "ERROR: Flutter no esta instalado o no esta en el PATH"
    echo "Por favor instala Flutter desde: https://docs.flutter.dev/get-started/install"
    exit 1
fi

flutter --version

echo
echo "[2/5] Limpiando proyecto..."
flutter clean

echo
echo "[3/5] Obteniendo dependencias..."
flutter pub get

echo
echo "[4/5] Verificando configuracion..."
flutter doctor

echo
echo "[5/5] Verificando dispositivos disponibles..."
flutter devices

echo
echo "========================================"
echo "   Instalacion completada exitosamente!"
echo "========================================"
echo
echo "Proximos pasos:"
echo "1. Configura Supabase en lib/core/env.dart"
echo "2. Ejecuta: flutter run"
echo 
#!/bin/bash

# Verifica si la carpeta ya existe para evitar descargas innecesarias
rm -rf solutions
if [ ! -d "solutions" ]; then
    echo "Descargando repositorio con soluciones..."
    rm -rf solutions
    git clone https://github.com/alejorotp/benchmark-contenedores.git solutions
else
    echo "Repositorio ya descargado. Usando soluciones existentes..."
fi

# Reiniciar archivo de resultados
echo "" > results.txt

echo "Ejecutando soluciones en distintos lenguajes..."
for lang in solutions/*; do
    if [ -d "$lang" ]; then
        lang_name=$(basename "$lang")  # Extrae solo el nombre del lenguaje
        echo "Ejecutando $lang_name..."

        # Construir la imagen
        docker build -t "${lang_name}_benchmark" "$lang"

        # Ejecutar el contenedor y guardar el tiempo
        TIME_OUTPUT=$(docker run --rm "${lang_name}_benchmark")

        # Guardar el resultado en el archivo
        echo "$lang_name: $TIME_OUTPUT" >> results.txt
    fi
done

echo "Resultados:"
cat results.txt
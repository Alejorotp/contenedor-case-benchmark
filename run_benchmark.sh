#!/bin/bash

rm -rf solutions
if [ ! -d "solutions" ]; then
    echo "Descargando repositorio con soluciones..."
    rm -rf solutions
    git clone https://github.com/alejorotp/benchmark-contenedores.git solutions
else
    echo "Repositorio ya descargado. Usando soluciones existentes..."
fi

echo "" > results.txt

echo "Ejecutando soluciones en distintos lenguajes..."
for lang in solutions/*; do
    if [ -d "$lang" ]; then
        lang_name=$(basename "$lang")
        echo "Ejecutando $lang_name..."

        docker build -t "${lang_name}_benchmark" "$lang"

        TIME_OUTPUT=$(docker run --rm "${lang_name}_benchmark")

        echo "$lang_name: $TIME_OUTPUT" >> results.txt
    fi
done

echo "Resultados:"
cat results.txt
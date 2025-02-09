#!/bin/bash
echo "Descargando repositorio con soluciones..."
git clone https://github.com/alejorotp/benchmark-contenedores.git solutions

echo "Ejecutando soluciones en distintos lenguajes..."
for lang in solutions/*; do
    if [ -d "$lang" ]; then
        echo "Ejecutando $lang..."
        cd "$lang"
        docker build -t "${lang}_benchmark" .
        TIME_OUTPUT=$(docker run --rm "${lang}_benchmark")
        echo "$lang: $TIME_OUTPUT ms" >> ../results.txt
        cd ..
    fi
done

echo "Resultados:"
cat results.txt

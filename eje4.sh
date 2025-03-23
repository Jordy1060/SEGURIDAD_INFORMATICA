#!/bin/bash

sublist3r_file="sublist3r_resultado.txt"
amass_file="amass_resultado.txt"
theharvester_file="theharvester_resultado.txt"
knockpy_file="knockpy_resultado.txt"
dnsrecon_file="dnsrecon_resultado.txt"

output_file="consolidado_resultado.txt"

if [ ! -f "$sublist3r_file" ]; then
    echo "El archivo $sublist3r_file no existe. Asegúrate de que la herramienta Sublist3r se haya ejecutado correctamente."
    exit 1
fi

if [ ! -f "$amass_file" ]; then
    echo "El archivo $amass_file no existe. Asegúrate de que la herramienta Amass se haya ejecutado correctamente."
    exit 1
fi

if [ ! -f "$theharvester_file" ]; then
    echo "El archivo $theharvester_file no existe. Asegúrate de que la herramienta TheHarvester se haya ejecutado correctamente."
    exit 1
fi

if [ ! -f "$knockpy_file" ]; then
    echo "El archivo $knockpy_file no existe. Asegúrate de que la herramienta Knockpy se haya ejecutado correctamente."
    exit 1
fi

if [ ! -f "$dnsrecon_file" ]; then
    echo "El archivo $dnsrecon_file no existe. Asegúrate de que la herramienta Dnsrecon se haya ejecutado correctamente."
    exit 1
fi

> "$output_file"

add_to_output() {
    cat "$1" | sort | uniq >> "$output_file"
}

echo "Consolidando resultados de Sublist3r..." >> "$output_file"
add_to_output "$sublist3r_file"

echo "Consolidando resultados de Amass..." >> "$output_file"
add_to_output "$amass_file"

echo "Consolidando resultados de TheHarvester..." >> "$output_file"
add_to_output "$theharvester_file"

echo "Consolidando resultados de Knockpy..." >> "$output_file"
add_to_output "$knockpy_file"

echo "Consolidando resultados de Dnsrecon..." >> "$output_file"
add_to_output "$dnsrecon_file"

echo "Ordenando y eliminando duplicados..."
sort "$output_file" | uniq > "${output_file}.sorted"

echo "Resultados consolidados y ordenados:"
cat "${output_file}.sorted"

mv "${output_file}.sorted" "$output_file"

echo "Consolidación completa. Los resultados finales se encuentran en $output_file"

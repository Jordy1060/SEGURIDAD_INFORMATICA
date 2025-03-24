import subprocess
import os

def ejecutar_comando(comando):
    try:
        resultado = subprocess.check_output(comando, shell=True, stderr=subprocess.STDOUT)
        return resultado.decode("utf-8")
    except subprocess.CalledProcessError as e:
        print(f"Error al ejecutar el comando: {e}")
        return ""

def consolidar_resultados(resultados):
    resultados_unicos = sorted(set(resultados))
    return resultados_unicos

def guardar_resultados(resultados, archivo_salida):
    with open(archivo_salida, "w") as f:
        for resultado in resultados:
            f.write(f"{resultado}\n")

dominio = input("Por favor, ingresa el dominio (por ejemplo, mercadolibre.com): ")

comandos = [
    f"sublist3r -d {dominio}",
    f"theHarvester -d {dominio} -b google",
    f"knockpy {dominio}",
    f"dnsrecon -d {dominio}"
]

resultados_totales = []

for comando in comandos:
    print(f"Ejecutando: {comando}")
    resultados = ejecutar_comando(comando)
    if resultados:
        resultados_totales.extend(resultados.splitlines())

resultados_consolidados = consolidar_resultados(resultados_totales)

archivo_salida = f"resultados_consolidados_{dominio}.txt"
guardar_resultados(resultados_consolidados, archivo_salida)

print(f"Los resultados consolidados se han guardado en: {archivo_salida}")

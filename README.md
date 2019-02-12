# Compilador | Teoria I

## Grupo 2 (PLUSTRUNC)

Integrantes:
 * Altoe, Francisco
 * Rodríguez, Agustín
 * Woinilovicz, Salvador

## Ejemplo de programa:

Entrada:
```
VAR
	[FIB_A, FIB_B] = [INTEGER, INTEGER]
	[CONTADOR] = [INTEGER]
ENDVAR

PRINT "Prueba 1 (Fibonacci):"
PRINT "---------------------"
CONTADOR := 0
FIB_A := 1
FIB_B := 0
WHILE CONTADOR < 10 DO
	FIB_A := FIB_A + FIB_B
	FIB_B := FIB_A - FIB_B
	PRINT "FIB(", CONTADOR+1, ") = ", FIB_B
	CONTADOR := CONTADOR + 1
END WHILE
```
Salida:
```
FIB(1) = 1
FIB(2) = 1
FIB(3) = 2
...
```
Ver archivo `prueba.txt` para más ejemplos.

## Setup
 * clonar el repositorio:
`git clone https://github.com/FranciscoDA/compi`
 * Crear un nuevo proyecto de Eclipse en el directorio del proyecto
 * Crear un directorio "jflex" dentro del directorio del proyecto, con los contenidos de JFlex 1.6.1
 * Agregar los .jar de JFlex al proyecto creado: Project > Properties > Java Build Path > Libraries > Add JARs...
   * jflex/lib/java-cup-11a.jar
   * jflex/lib/jflex-1.6.1.jar

## Compilación a assembly (desde Eclipse)
 * Realizar el setup
 * Click derecho en el archivo build.xml
 * Run as > Ant Build

## Compilación a assembly (desde la CLI)
 * Ejecutar en la línea de comandos: `ant run`

## Compilación a ejecutable de 32 bits (con Linux+NASM)
 * Instalar NASM: `sudo apt-get install nasm` o `pacman -S nasm`, etc.
 * Compilar el objeto: `nasm -wt -felf32 -o gen/nasm-programa.o gen/nasm-programa.asm`
 * Enlazar el ejecutable: `ld -melf_i386 -o gen/nasm-exe  nasm-programa.o`
 * Ejecutar el programa: `gen/nasm-exe`
O bien:
 * Ejecutar el script bash: `./nasm-compile.sh`

## Compilación a ejecutable de 16 bits (con DOSBox+TASM4):
 * Crear un directorio "tasm" dentro del directorio del proyecto, con los contenidos de la distribución de Turbo Assembler 4
 * Compilar el objeto: `tasm\tasm.exe gen\TASM-PROGRAMA.ASM gen\TASM-PROGRAMA.OBJ`
 * Enlazar el ejecutable: `tasm\tlink.exe gen\TASM-PROGRAMA.OBJ , gen\tasm-exe.exe`
 * Ejecutar el programa: `gen\tasm-exe.exe`
O bien:
 * Ejecutar el script batch: `tasm-compile.bat`

## Links
 * Instrucciones x87 FPU: http://linasm.sourceforge.net/docs/instructions/fpu.php
 * Manual NASM: http://www.nasm.us/doc/nasmdoc0.html
 * Simply FPU: http://www.website.masmforum.com/tutorials/fptute/
 * Intel® 64 and IA-32 Architectures Software Developer’s Manual: https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-1-manual.pdf
 * Llamando funciones en assembly: https://en.wikibooks.org/wiki/X86_Disassembly/Functions_and_Stack_Frames
 * Manual TASM5: http://bitsavers.informatik.uni-stuttgart.de/pdf/borland/turbo_assembler/Turbo_Assembler_Version_5_Users_Guide.pdf

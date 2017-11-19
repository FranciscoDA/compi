# Compilador | Teoria I

## Setup
 * clonar el repositorio:
`git clone https://github.com/FranciscoDA/compi`
 * Crear un nuevo proyecto de Eclipse en el directorio del proyecto
 * Crear un directorio "jflex" dentro del directorio del proyecto, con los contenidos de JFlex 1.6.1
 * Agregar los .jar de JFlex al proyecto creado: Project > Properties > Java Build Path > Libraries > Add JARs...
   * jflex/lib/java-cup-11a.jar
   * jflex/lib/jflex-1.6.1.jar

## Compilacion y ejecucion (Eclipse/Linux)
 * Compilar y ejecutar el compilador ejecutando el archivo build.xml (click derecho > run as > Ant Build)
 * Compilar y enlazar el programa: `nasm -nasm -wt -felf32 programa-nasm.asm && ld -melf_i386 programa-nasm.o`
 * Ejecutar el programa: `./a.out`
## Compilacion y ejecucion (CLI/Linux)
 * Compilar y ejecutar el compilador: `./ant run`
 * Compilar y enlazar el programa: `nasm -nasm -wt -felf32 programa-nasm.asm && ld -melf_i386 programa-nasm.o`
 * Ejecutar el programa: `./a.out`

## Links

 * Instrucciones x87 FPU: http://linasm.sourceforge.net/docs/instructions/fpu.php
 * Manual NASM: http://www.nasm.us/doc/nasmdoc0.html
 * Simply FPU: http://www.website.masmforum.com/tutorials/fptute/
 * Intel® 64 and IA-32 Architectures Software Developer’s Manual: https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-1-manual.pdf
 * Llamando funciones en assembly: https://en.wikibooks.org/wiki/X86_Disassembly/Functions_and_Stack_Frames
 * Manual TASM5: http://bitsavers.informatik.uni-stuttgart.de/pdf/borland/turbo_assembler/Turbo_Assembler_Version_5_Users_Guide.pdf

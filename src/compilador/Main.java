package compilador;

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.HashMap;

import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;

import java_cup.runtime.Symbol;

public class Main {
	private final static Path PRUEBA_PATH = Paths.get("prueba.txt");
	public static void main(String[] argv) {
		HashMap<String, SymbolTableEntry> ts = new HashMap<String, SymbolTableEntry>();
		try {
			BufferedReader br = Files.newBufferedReader(PRUEBA_PATH);
			Scanner sc = new Scanner(br);
			parser par = new parser(sc);
			try {
				Symbol s = par.debug_parse();
				System.out.println(s.toString());
				System.out.println(s.value);
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			/*
			try {
				Symbol s = sc.debug_next_token();
				while (s.sym != sym.EOF) {
					System.out.println("Sym: " + s.toString());
					if (s.sym == sym.IDENTIFIER) {
					    ts.put(s.value.toString(), new SymbolTableEntry(s.value.toString(), null, null));
                    }
					s = sc.debug_next_token();
				}
				System.out.println();System.out.println("TABLA DE SÍMBOLOS:");System.out.println(ts.toString());
			}
			catch (RuntimeException ex) {
				ex.printStackTrace();
			}*/
		}
		catch (IOException ex) {
			System.err.println("No se pudo abrir el archivo de prueba " + PRUEBA_PATH.toString());
		}
		
	}
}

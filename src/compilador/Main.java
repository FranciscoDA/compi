package compilador;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;

import java_cup.runtime.Symbol;

public class Main {
	private final static Path PRUEBA_PATH = Paths.get("prueba.txt");
	public static void main(String[] argv) {
		HashMap<String, SymbolTableEntry> ts = new HashMap<String, SymbolTableEntry>();
		try {
			BufferedReader br = Files.newBufferedReader(PRUEBA_PATH);
			Scanner sc = new Scanner(br);
			try {
				Symbol s = sc.debug_next_token();
				while (s.sym != sym.EOF) {
					System.out.println("Sym: " + s.toString());
					if (s.sym == sym.IDENTIFIER) {
					    ts.put(s.value.toString(), new SymbolTableEntry(s.value.toString(), null, null));
                        //ts.put("a", new SymbolTableEntry("a", null, null, 0));
                        //new SymbolTableEntry("a", null, null, 0);
                    }

					s = sc.debug_next_token();
				}
				System.out.println(ts.toString());
			}
			catch (RuntimeException ex) {
				ex.printStackTrace();
			}
		}
		catch (IOException ex) {
			System.err.println("No se pudo abrir el archivo de prueba " + PRUEBA_PATH.toString());
		}
		
	}
}

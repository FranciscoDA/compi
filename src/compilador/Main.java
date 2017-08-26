package compilador;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java_cup.runtime.Symbol;

public class Main {
	private final static Path PRUEBA_PATH = Paths.get("prueba.txt");
	public static void main(String[] argv) {
		try {
			BufferedReader br = Files.newBufferedReader(PRUEBA_PATH);
			Scanner sc = new Scanner(br);
			try {
				Symbol s = sc.debug_next_token();
				while (s.sym != sym.EOF) {
					System.out.println("Sym: " + s.toString());
					s = sc.debug_next_token();
				}
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

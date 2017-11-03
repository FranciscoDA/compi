package asm;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;

public class NASMWriter {
	private PrintWriter writer;
	public NASMWriter(Path fpath) throws IOException
	{
		writer = new PrintWriter(Files.newOutputStream(fpath));
	}
}

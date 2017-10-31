package rpn;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.LinkedList;

public class Serializer {
	public static void serialize(LinkedList<rpn.Node> program, OutputStream output)
	{
		PrintWriter pw = new PrintWriter(output);
		for (rpn.Node node : program)
		{
			pw.println(node.toString());
		}
		pw.close();
	}
}

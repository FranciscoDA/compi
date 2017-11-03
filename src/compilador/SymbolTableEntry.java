package compilador;

public class SymbolTableEntry {
	public enum TypeName {
		INTEGER,
		FLOAT
	}
    public SymbolTableEntry(String name, TypeName type) {
    	this.name = name;
    	this.type = type;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public TypeName getType() {
        return type;
    }
    public void setType(TypeName type) {
        this.type = type;
    }    

    @Override
    public String toString() {
    	return name.toString() + " " + type.toString();
    }

    private String name;
    private TypeName type;
}

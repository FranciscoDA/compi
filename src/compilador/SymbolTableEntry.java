package compilador;

import constructs.TypeName;

public class SymbolTableEntry implements Comparable<SymbolTableEntry> {
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
    
	@Override
	public int compareTo(SymbolTableEntry o) {
		return this.name.compareTo(o.getName());
	}

    private String name;
    private TypeName type;
}

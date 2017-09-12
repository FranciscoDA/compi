package compilador;

/**
 * Created by naninho205 on 2017-09-12.
 */
public class SymbolTableEntry {
    public SymbolTableEntry(String name, Integer type, Object value) {
        this(name, type, value, 0);
    }
    public SymbolTableEntry(String name, Integer type, Object value, int length){
        setName(name);
        setType(type);
        setVal(value);
        setLen(length);
    }
    public String getName() {
        return name;
    }
    public Integer getType() {
        return type;
    }
    private Object getValue() {
        return val;
    }
    private int getLength() {
        return len;
    }
    private String name;

    public void setName(String name) {
        this.name = name;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Object getVal() {
        return val;
    }

    public void setVal(Object val) {
        this.val = val;
    }

    public int getLen() {
        return len;
    }

    public void setLen(int len) {
        this.len = len;
    }

    private Integer type;
    private Object val;
    private int len;
}

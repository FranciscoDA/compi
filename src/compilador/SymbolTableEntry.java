package compilador;

/**
 * Created by naninho205 on 2017-09-12.
 */
public class SymbolTableEntry {
    public SymbolTableEntry(String name, Integer type, Object value) {
        this(name, type, value, 0);
    }
    public SymbolTableEntry(String name, Integer type, Object value, Integer length){
        setName(name);
        setType(type);
        setVal(value);
        setLen(length);
    }


    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }


    private Integer type;
    public Integer getType() {
        return type;
    }
    public void setType(Integer type) {
        this.type = type;
    }


    private Object val;
    public Object getVal() {
        return val;
    }
    public void setVal(Object val) {
        this.val = val;
    }


    private Integer len;
    public Integer getLen() {
        return len;
    }
    public void setLen(Integer len) {
        this.len = len;
    }
}

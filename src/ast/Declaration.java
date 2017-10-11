package ast;

import java.util.LinkedList;

public class Declaration {
	public Declaration(String identifier, TypeName type) {
		setIdentifier(identifier);
		setType(type);
		setNext(null);
	}
	public Declaration(String identifier, TypeName type, Declaration next) {
		setIdentifier(identifier);
		setType(type);
		setNext(next);
	}
	public void setIdentifier(String identifier) {
		_identifier = identifier;
	}
	public String getIdentifier() {
		return _identifier;
	}
	public void setType(TypeName type) {
		_type = type;
	}
	public TypeName getType() {
		return _type;
	}
	public void setNext(Declaration next) {
		_next = next;
	}
	public Declaration getNext() {
		return _next;
	}
	public void concatenate(Declaration next) {
		if (_next != null) {
			_next.concatenate(next);
		}
		else {
			setNext(next);
		}
	}
	public void invert() {
		LinkedList<TypeName> types = new LinkedList<>();
		types.addLast(_type);
		if (_next != null) {
			_next.invert(types);
		}
		_type = types.pollFirst();
	}
	public void invert(LinkedList<TypeName> types) {
		types.addLast(_type);
		if (_next != null) {
			_next.invert(types);
		}
		_type = types.pollFirst();
	}
	private String _identifier;
	private TypeName _type;
	private Declaration _next;
}

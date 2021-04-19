import java.util.*;

public abstract class Component {
	private String name;

	protected Component(String name) {
		this.name = name;
	}

	public final String name() {
		return this.name;
	}

	public abstract int price();
	public abstract int wattage();
	public abstract void add(Component c);
	public abstract void remove(Component c);
	public abstract Iterator<Component> iterator();
	public abstract String display();
}

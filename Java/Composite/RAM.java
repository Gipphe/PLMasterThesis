import java.util.*;

public class RAM extends LeafComponent {
	private int price;
	private int capacity;

	public RAM(String name, int price, int capacity) {
		super(name);
		this.price = price;
		this.capacity = capacity;
	}

	public int price() {
		return this.price;
	}

	public int wattage() {
		return 30;
	}

	public String display() {
		StringJoiner sj = Utils.componentStringJoiner();
		sj.add("Name: " + this.name());
		sj.add("Price: " + this.price);
		sj.add("Wattage: " + this.wattage());
		sj.add("Capacity: " + this.capacity + " B");
		return "RAM\n" + Utils.indent(sj.toString());
	}
}

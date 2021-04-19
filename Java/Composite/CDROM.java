import java.util.*;

public class CDROM extends LeafComponent {
	private int price;

	public CDROM(String name, int price) {
		super(name);
		this.price = price;
	}

	public int price() {
		return this.price;
	}

	public int wattage() {
		return 20;
	}

	public String display() {
		StringJoiner sj = Utils.componentStringJoiner();

		sj.add("Name: " + this.name());
		sj.add("Price: " + this.price);
		sj.add("Wattage: " + this.wattage());
		return "CDROM\n" + Utils.indent(sj.toString());
	}
}

import java.util.*;

public class Chassis extends CompositeComponent {
	private int ownPrice;

	public Chassis(String name, int ownPrice) {
		super(name);
		this.ownPrice = ownPrice;
	}

	public int price() {
		int p = this.ownPrice;
		Iterator<Component> itr = this.iterator();
		while (itr.hasNext()) {
			Component c = itr.next();
			p += c.price();
		}
		return p;
	}

	public int wattage() {
		int w = 0;
		Iterator<Component> itr = this.iterator();
		while (itr.hasNext()) {
			Component c = itr.next();
			w += c.wattage();
		}
		return w;
	}

	public String display() {
		StringJoiner sj = Utils.componentStringJoiner();
		sj.add("Name: " + this.name());
		sj.add("Own price: " + this.ownPrice);
		sj.add("Total price: " + this.price());
		sj.add("Total wattage: " + this.wattage());
		sj.add("Components:\n" + Utils.indent(this.displayComponents()));

		return "Chassis\n" + Utils.indent(sj.toString());
	}
}

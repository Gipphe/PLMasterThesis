import java.util.*;

public class Motherboard extends CompositeComponent {
	private int ownPrice;
	private final int ownWattage = 40;

	public Motherboard(String name, int ownPrice) {
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
		int w = this.ownWattage;
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
		sj.add("Own Price: " + this.ownPrice);
		sj.add("Total price: " + this.price());
		sj.add("Own wattage: " + this.ownWattage);
		sj.add("Total wattage: " + this.wattage());
		sj.add("Components:\n" + Utils.indent(Utils.indent(this.displayComponents())));

		return "Motherboard\n" + Utils.indent(sj.toString());
	}
}

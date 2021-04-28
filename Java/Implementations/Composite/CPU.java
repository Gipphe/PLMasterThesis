import java.util.*;

public class CPU extends LeafComponent {
	private int price;
	private String clockFreq;

	public CPU(String name, int price, String clockFreq) {
		super(name);
		this.price = price;
		this.clockFreq = clockFreq;
	}

	public int price() {
		return this.price;
	}

	public int wattage() {
		return 140;
	}

	public String display() {
		StringJoiner sj = Utils.componentStringJoiner();
		sj.add("Name: " + this.name());
		sj.add("Price: " + this.price);
		sj.add("Wattage: " + this.wattage());
		sj.add("Clock frequency: " + this.clockFreq);
		return "CPU\n" + Utils.indent(sj.toString());
	}
}

import java.util.*;

abstract class Part implements Cloneable {
	public abstract String display();

	public Part clone() throws CloneNotSupportedException {
		return (Part) super.clone();
	}
}

class ThrusterPart extends Part {
	private int thrust;

	public ThrusterPart(int thrust) {
		this.thrust = thrust;
	}

	public String display() {
		return "Thruster with " + this.thrust + " thrust";
	}

	public Part clone() throws CloneNotSupportedException {
		return (ThrusterPart) super.clone();
	}
}

class StructurePart extends Part {
	private String name;

	public StructurePart() {
		this.name = "";
	}

	public StructurePart(String name) {
		this.name = name;
	}

	public String display() {
		return "Structure " + this.name;
	}

	public Part clone() throws CloneNotSupportedException {
		return (StructurePart) super.clone();
	}
}

class WindowPart extends Part {
	private int tint;

	public WindowPart(int tint) {
		this.tint = tint;
	}

	public String display() {
		return "Window with " + this.tint + " black tint to it";
	}

	public Part clone() throws CloneNotSupportedException {
		return (WindowPart) super.clone();
	}
}

class GunPart extends Part {
	private int power;

	public GunPart(int power) {
		this.power = power;
	}

	public String display() {
		return "Gun with " + this.power + " power";
	}

	public Part clone() throws CloneNotSupportedException {
		return (GunPart) super.clone();
	}
}

class SpaceShip {
	private List<Part> parts = new ArrayList<>();

	public SpaceShip addPart(Part part) {
		try {
			this.parts.add(part.clone());
		} catch (CloneNotSupportedException e) {
			// Do something sensible here.
		}
		return this;
	}

	public String display() {
		StringBuilder sb = new StringBuilder();
		sb.append("Space ship with the following parts:\n");
		for (Part part : this.parts) {
			sb.append("  ");
			sb.append(part.display());
			sb.append("\n");
		}
		return sb.toString();
	}
}

public class Main {
	public static void main(String... args) {
		SpaceShip ss = new SpaceShip();

		ThrusterPart tp = new ThrusterPart(30);
		StructurePart sp = new StructurePart();
		WindowPart wp = new WindowPart(50);
		GunPart gp = new GunPart(10);

		ss
			.addPart(tp)
			.addPart(tp)
			.addPart(wp)
			.addPart(gp);

		for (int i = 0; i < 10; i += 1) {
			ss.addPart(sp);
		}

		System.out.println(ss.display());
	}
}

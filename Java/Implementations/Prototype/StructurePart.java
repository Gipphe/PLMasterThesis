public class StructurePart implements Part {
	private int hitpoints;

	public StructurePart(int hp) {
		this.hitpoints = hp;
	}

	public String display() {
		return "Structure: " + this.hitpoints + " hp";
	}

	public Part clone() {
		return new StructurePart(this.hitpoints);
	}
}

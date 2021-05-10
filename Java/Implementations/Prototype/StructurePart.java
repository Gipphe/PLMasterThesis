public class StructurePart extends Part {
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

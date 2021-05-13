import java.util.*;

public class SpaceShip {
	private List<Part> parts = new ArrayList<>();
	private String name;

	public SpaceShip(String name) {
		this.name = name;
	}

	public SpaceShip addPart(Part part) {
		this.parts.add(part.clone());
		return this;
	}

	public String display() {
		StringJoiner sj = new StringJoiner("\n");
		sj.add(
			"Space ship "
			+ this.name
			+ " with "
			+ this.parts.size()
			+ " parts:"
		);
		for (Part part : this.parts) {
			sj.add("  " + part.display());
		}
		return sj.toString();
	}
}

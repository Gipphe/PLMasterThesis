import java.util.*;

public class SpaceShip {
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

import java.util.*;

public class Rectangle implements Display {
	private int height;
	private int width;

	public Rectangle(int width, int height) {
		this.width = width;
		this.height = height;
	}

	public String display() {
		String hor = "-".repeat(this.width);
		String vert = "|" + " ".repeat(this.width - 2) + "|";
		StringJoiner sj = new StringJoiner("\n");
		sj.add(hor);
		for (int i = 0; i < this.height - 2; i += 1) {
			sj.add(vert);
		}
		sj.add(hor);

		return "Rectangle of size " + this.width + "x" + this.height + "\n" + sj.toString();
	}
}

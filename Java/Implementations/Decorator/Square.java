import java.util.*;

public class Square implements Display {
	private int size;

	public Square(int size) {
		this.size = size;
	}

	public String display() {
		String hor = "-".repeat(this.size);
		String vert = "|" + " ".repeat(this.size - 2) + "|";
		StringJoiner sj = new StringJoiner("\n");
		sj.add(hor);
		for (int i = 0; i < this.size - 2; i += 1) {
			sj.add(vert);
		}
		sj.add(hor);

		return "Square of size " + this.size + "x" + this.size + "\n" + sj.toString();
	}
}

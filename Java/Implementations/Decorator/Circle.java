public class Circle implements Display {
	private int radius;

	public Circle(int radius) {
		this.radius = radius;
	}

	public String display() {
		return "Circle with radius " + this.radius + "\n" + "Drawing circles\nin a terminal\nis too hard.";
	}
}

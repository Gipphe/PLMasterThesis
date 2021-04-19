public class Rectangle implements Display {
	private int height;
	private int width;

	public Rectangle(int width, int height) {
		this.width = width;
		this.height = height;
	}

	public String display() {
		return "Rectangle of size " + this.width + "x" + this.height;
	}
}

public class Square implements Display {
	private int size;

	public Square(int size) {
		this.size = size;
	}

	public String display() {
		return "Square of size " + this.size + "x" + this.size;
	}
}

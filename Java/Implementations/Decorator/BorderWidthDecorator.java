public class BorderWidthDecorator extends DisplayDecorator {
	private int width;

	public BorderWidthDecorator(int width, Display contained) {
		super(contained);
		this.width = width;
	}

	public String display() {
		return this.contained.display() + "\nBorder width: " + this.width;
	}
}

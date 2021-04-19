public class BorderColorDecorator extends DisplayDecorator {
	private String color;

	public BorderColorDecorator(String color, Display contained) {
		super(contained);
		this.color = color;
	}

	public String display() {
		return this.contained.display() + "\nBorder color: " + this.color;
	}
}

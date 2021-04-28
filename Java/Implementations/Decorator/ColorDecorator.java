public class ColorDecorator extends DisplayDecorator {
	private String color;

	public ColorDecorator(String color, Display contained) {
		super(contained);
		this.color = color;
	}

	public String display() {
		return this.contained.display() + "\nColor: " + this.color;
	}
}

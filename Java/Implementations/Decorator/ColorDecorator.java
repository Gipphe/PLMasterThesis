public class ColorDecorator extends DisplayDecorator {
	private Color color;

	public ColorDecorator(Color color, Display contained) {
		super(contained);
		this.color = color;
	}

	public String display() {
		return this.color.colorCode() + this.contained.display();
	}
}

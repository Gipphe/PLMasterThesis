public class OpacityDecorator extends DisplayDecorator {
	private int opacity;

	public OpacityDecorator(int opacity, Display contained) {
		super(contained);
		this.opacity = opacity;
	}

	public String display() {
		return this.contained.display() + "\nOpacity: " + this.opacity;
	}
}

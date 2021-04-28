public abstract class DisplayDecorator implements Display {
	protected Display contained;

	public DisplayDecorator(Display contained) {
		this.contained = contained;
	}

	public abstract String display();
}

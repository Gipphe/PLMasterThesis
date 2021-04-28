public class UpperCaseDecorator extends DisplayDecorator {
	public UpperCaseDecorator(Display contained) {
		super(contained);
	}

	public String display() {
		return this.contained.display().toUpperCase();
	}
}

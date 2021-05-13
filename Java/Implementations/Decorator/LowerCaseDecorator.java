public class LowerCaseDecorator extends DisplayDecorator {
	public LowerCaseDecorator(Display contained) {
		super(contained);
	}

	public String display() {
		return this.contained.display().toLowerCase();
	}
}

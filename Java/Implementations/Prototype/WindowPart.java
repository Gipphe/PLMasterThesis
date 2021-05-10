public class WindowPart extends Part {
	private int tint;

	public WindowPart(int tint) {
		this.tint = tint;
	}

	public String display() {
		return "Window with " + this.tint + " black tint to it";
	}

	public Part clone() throws CloneNotSupportedException {
		return (WindowPart) super.clone();
	}
}

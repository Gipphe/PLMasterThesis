public class WindowPart implements Part {
	private int hitpoints;

	public WindowPart(int hp) {
		this.hitpoints = hp;
	}

	public String display() {
		return "Window: " + this.hitpoints + " hp";
	}

	public Part clone() {
		return new WindowPart(this.hitpoints);
	}
}

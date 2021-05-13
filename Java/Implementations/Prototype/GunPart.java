public class GunPart implements Part {
	private int power;

	public GunPart(int power) {
		this.power = power;
	}

	public String display() {
		return "Gun: " + this.power + " power";
	}

	public Part clone() {
		return new GunPart(this.power);
	}
}

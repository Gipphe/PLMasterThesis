public class GunPart extends Part {
	private int power;

	public GunPart(int power) {
		this.power = power;
	}

	public String display() {
		return "Gun with " + this.power + " power";
	}

	public Part clone() throws CloneNotSupportedException {
		return (GunPart) super.clone();
	}
}

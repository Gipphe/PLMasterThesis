public class ThrusterPart extends Part {
	private int thrust;

	public ThrusterPart(int thrust) {
		this.thrust = thrust;
	}

	public String display() {
		return "Thruster with " + this.thrust + " thrust";
	}

	public Part clone() throws CloneNotSupportedException {
		return (ThrusterPart) super.clone();
	}
}

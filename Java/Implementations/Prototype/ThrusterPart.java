public class ThrusterPart implements Part {
	private int thrust;

	public ThrusterPart(int thrust) {
		this.thrust = thrust;
	}

	public String display() {
		return "Thruster: " + this.thrust + " thrust";
	}

	public Part clone() {
		return new ThrusterPart(this.thrust);
	}
}

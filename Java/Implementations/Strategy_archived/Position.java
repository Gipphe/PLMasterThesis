public class Position {
	public final double x;
	public final double y;

	public Position(double x, double y) {
		this.x = x;
		this.y = y;
	}

	public double distanceTo(Position dest) {
		return Math.sqrt(Math.pow(dest.x - this.x, 2) + Math.pow(dest.y - this.y, 2));
	}

	public String toString() {
		return "(" + Utils.roundTo(this.x, 2) + ", " + Utils.roundTo(this.y, 2) + ")";
	}
}

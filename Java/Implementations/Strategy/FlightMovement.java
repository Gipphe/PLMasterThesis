import java.lang.Math;

public class FlightMovement implements Movement {
	private double speed;

	public FlightMovement(double speed) {
		this.speed = speed;
	}

	public String moveTo(Position from, Position to) {
		double distance = from.distanceTo(to);
		double time = distance / speed;
		return "flies from " + from + " to " + to
			+ ",\na distance of " + Utils.roundTo(distance, 2)
			+ ",\nat a speed of " + Utils.roundTo(this.speed, 2)
			+ ",\nwhich will take " + Utils.roundTo(time, 2) + " seconds";
	}
}

public class DrivingMovement implements Movement {
	private double maximumSpeed;
	private double minimumSpeed;

	public DrivingMovement(double minimumSpeed, double maximumSpeed) {
		this.minimumSpeed = minimumSpeed;
		this.maximumSpeed = maximumSpeed;
	}

	public String moveTo(Position from, Position to) {
		double distance = from.distanceTo(to);
		double averageSpeed = (this.maximumSpeed + this.minimumSpeed) / 2;
		double maximumTime = distance / this.minimumSpeed;
		double minimumTime = distance / this.maximumSpeed;
		double averageTime = distance / averageSpeed;

		return "driving from "
			+ from
			+ " to "
			+ to
			+ ",\na distance of "
			+ Utils.roundTo(distance, 2)
			+ ",\nat a speed between "
			+ Utils.roundTo(this.minimumSpeed, 2)
			+ " and "
			+ Utils.roundTo(this.maximumSpeed, 2)
			+ ",\nwhich will take between "
			+ Utils.roundTo(minimumTime, 2)
			+ " and "
			+ Utils.roundTo(maximumTime, 2)
			+ " seconds"
			+ ",\nbut will on average take "
			+ Utils.roundTo(averageTime, 2)
			+ " seconds";
	}
}

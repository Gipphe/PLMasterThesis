public class BipedalMovement implements Movement {
	private MovementSpeed movementSpeed;

	public BipedalMovement(MovementSpeed movementSpeed) {
		this.movementSpeed = movementSpeed;
	}

	public String moveTo(Position from, Position to) {
		double distance = from.distanceTo(to);
		double speed = this.movementSpeed.speed();
		double time = distance / speed;

		return this.movementSpeed.verb() + " from " + from + " to " + to
			+ ",\na distance of " + Utils.roundTo(distance, 2)
			+ ",\nat a speed of " + Utils.roundTo(speed, 2)
			+ ",\nwhich will take " + Utils.roundTo(time, 2) + " seconds";
	}

	public enum MovementSpeed {
		WALK("walking", 1),
		RUN("running", 3);

		private double speed;
		private String verb;

		private MovementSpeed(String verb, double speed) {
			this.verb = verb;
			this.speed = speed;
		}

		private double speed() {
			return this.speed;
		}

		private String verb() {
			return this.verb;
		}
	}
}

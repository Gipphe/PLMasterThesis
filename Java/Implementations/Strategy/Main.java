import java.util.Random;

public class Main {

	public static void main(String... args) {
		Duck[] ducks = new Duck[]{
			new Duck("Grace", new BipedalMovement(BipedalMovement.MovementSpeed.WALK)),
			new Duck("Tim", new DrivingMovement(5, 12)),
			new Duck("Alan", new FlightMovement(20)),
			new Duck("Donald", new BipedalMovement(BipedalMovement.MovementSpeed.RUN)),
			new Duck("John", new DrivingMovement(7, 16)),
		};

		Position pos;
		Random rand = new Random(1234);
		Position maxPos = new Position(300, 300);
		Position minPos = new Position(0, 0);

		System.out.println("Round 1\n-----");

		for (Duck duck : ducks) {
			moveDuck(maxPos, minPos, rand, duck);
			System.out.println("-----");
		}

		System.out.println("Round 2");

		for (Duck duck : ducks) {
			System.out.println("-----");
			moveDuck(maxPos, minPos, rand, duck);
		}
	}

	private static void moveDuck(Position maxPos, Position minPos, Random rand, Duck duck) {
		double newX = (maxPos.x * rand.nextDouble()) + minPos.x;
		double newY = (maxPos.y * rand.nextDouble()) + minPos.y;
		Position newPos = new Position(newX, newY);
		duck.moveTo(newPos);
	}
}

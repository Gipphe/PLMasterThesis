import java.util.Random;
import java.util.StringJoiner;

public class Main {

	public static void main(String... args) {
		Duck[] ducks = new Duck[]{
			new Duck("Grace", new BipedalMovement(BipedalMovement.MovementSpeed.WALK)),
			new Duck("Tim", new DrivingMovement(5, 12)),
			new Duck("Alan", new FlightMovement(20)),
			new Duck("Donald", new BipedalMovement(BipedalMovement.MovementSpeed.RUN)),
			new Duck("John", new DrivingMovement(7, 16)),
		};

		Random rand = new Random(1234);
		Position maxPos = new Position(300, 300);
		Position minPos = new Position(0, 0);

		StringJoiner r1 = new StringJoiner("\n-----\n");
		r1.add("Round 1");

		for (Duck duck : ducks) {
			r1.add(moveDuck(maxPos, minPos, rand, duck));
		}
		System.out.println(r1.toString());

		System.out.println("-----");

		StringJoiner r2 = new StringJoiner("\n-----\n");
		r2.add("Round 2");

		for (Duck duck : ducks) {
			r2.add(moveDuck(maxPos, minPos, rand, duck));
		}
		System.out.println(r2.toString());
	}

	private static String moveDuck(Position maxPos, Position minPos, Random rand, Duck duck) {
		double newX = (maxPos.x * rand.nextDouble()) + minPos.x;
		double newY = (maxPos.y * rand.nextDouble()) + minPos.y;
		Position newPos = new Position(newX, newY);
		return duck.moveTo(newPos);
	}
}

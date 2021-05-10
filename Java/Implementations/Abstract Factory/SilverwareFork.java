/**
 * The finest fork you can find.
 */
public class SilverwareFork extends Fork {
	public SilverwareFork() {
		super(3, 30);
	}

	public void stickFood(String food) {
		System.out.println(
			"You stick the fork gently and elegantly into the "
			+ food
			+ "."
		);
	}
}

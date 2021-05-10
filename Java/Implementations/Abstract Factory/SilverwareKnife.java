/**
 * The finest knife you can find.
 */
public class SilverwareKnife extends Knife {
	public SilverwareKnife() {
		super(false, 240);
	}

	public void cutFood(String food) {
		System.out.println(
			"The "
			+ food
			+ " slices easily, and with finesse."
		);
	}
}

/**
 * A sharp rock.
 */
class PrimitiveKnife extends Knife {
	public PrimitiveKnife() {
		super(true, 110);
	}

	public void cutFood(String food) {
		System.out.println(
			"You attempt to cut the "
			+ food
			+ ", but you instead end up clumsily crushing it."
		);
	}
}

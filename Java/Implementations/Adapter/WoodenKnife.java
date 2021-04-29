public class WoodenKnife implements Knife {
	public String appearance() {
		return "like a twig right off of a tree";
	}

	public String sharpness() {
		return "nonexistent";
	}

	public String type() {
		return "wooden";
	}

	public String cutFood(String food) {
		return "You cut the "
			+ food
			+ " with the wooden knife. A challenge, to say the least; you're literally trying to"
			+ " eat a meal with a butter knife...";
	}
}

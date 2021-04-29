public class SteelKnife implements Knife {
	public String appearance() {
		return "dull and boring";
	}

	public String sharpness() {
		return "definitely sharp";
	}

	public String type() {
		return "steel";
	}

	public String cutFood(String food) {
		return "You cut the "
			+ food
			+ " with the steel knife. It cuts the food with ease. It doesn't look spectacular, but"
			+ " it is effective.";
	}
}

public class SilverKnife implements Knife {
	public String appearance() {
		return "elegant and exquisite";
	}

	public String sharpness() {
		return "like a razor";
	}

	public String type() {
		return "silver";
	}

	public String cutFood(String food) {
		return "You cut the "
			+ food
			+ " with the silver knife. It slices through like the food isn't even there. "
			+ Utils.sentenceCase(this.appearance())
			+ ".";
	}
}
